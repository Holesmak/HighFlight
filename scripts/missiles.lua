---@class forts

dofile(path .. "/scripts/missiles_config.lua")

function MissilesLoad(gameStart)
        data.smartMissiles = {}
end

function MissilesOnRestart()
        data.smartMissiles = {}
end

function MissilesUpdate(frame, allNodes)
        local targetedStructures, targetedProjectiles = UpdateMissilesVision(frame, allNodes)
end

function MakeSmartMissile(teamId, projectileNodeId, saveName, weaponId, projectileNodeIdFrom)
        local projectileSaveName = GetNodeProjectileSaveName(projectileNodeId)
        if SMARTMISSILE_CONFIG[projectileSaveName] then
                local missile = {}
                missile.projectileNodeId = projectileNodeId
                missile.teamId = teamId
                missile.saveName = projectileSaveName
                missile.gravity = GetProjectileParamInt(projectileSaveName, teamId, "Gravity", 0)
                missile.mass = GetProjectileParamInt(projectileSaveName, teamId, "ProjectileMass", 1)
                local conf = SMARTMISSILE_CONFIG[missile.saveName]
                --Print(conf.courseHoldDelay .. " : " .. #data.smartMissiles + 1)
                if conf.trackingDelay then
                        ScheduleCall(conf.trackingDelay, MakeSmartMissileDelayed, missile)
                else

                        table.insert(data.smartMissiles, #data.smartMissiles + 1, missile)
                end
                if conf.courseHoldDelay == 0 then
                        SetMissileTarget(projectileNodeId, Vec3MultiplyScalar(NodeVelocity(projectileNodeId), 10000000))
                elseif conf.courseHoldDelay ~= -1 then
                        ScheduleCall(conf.courseHoldDelay, MissileCourseHoldDelay, projectileNodeId)
                end
                if conf.relativeVelocity then
                        dlc2_ApplyForce(projectileNodeId, Vec3MultiplyScalar(NodeVelocity(GetDevicePlatformA(weaponId)), missile.mass / data.updateDelta))
                        --Print(Vec3MultiplyScalar(NodeVelocity(GetDevicePlatformA(weaponId)), missile.mass / data.updateDelta))
                end
        else
                if SMARTMISSILE_POINTER_MISSILE_PAIRS[projectileSaveName] ~= nil then
                        local missilePairedSaveName = SMARTMISSILE_POINTER_MISSILE_PAIRS[projectileSaveName]
                        local conf = SMARTMISSILE_CONFIG[missilePairedSaveName]
                        local velocityMultiplier = 1
                        local setCourseAgainDelayMultiplier = 1
                        local pointerVelocity = NodeVelocity(projectileNodeId)
                        local additionalVelocity
                        if conf.relativeVelocity then
                                additionalVelocity = NodeVelocity(GetDevicePlatformA(weaponId))
                        else
                                additionalVelocity = Vec3(0, 0)
                        end
                        if conf.pointerVelocityAffects == 1 then
                                velocityMultiplier = Vec3Length(pointerVelocity)
                        elseif conf.pointerVelocityAffects == 2 then
                                setCourseAgainDelayMultiplier = Vec3Length(pointerVelocity)
                        elseif conf.pointerVelocityAffects == 3 then
                                velocityMultiplier = Vec3Length(pointerVelocity)
                                setCourseAgainDelayMultiplier = Vec3Length(pointerVelocity)
                        end

                        local deviceSaveName = GetDeviceTypeSaveNameByIndex(weaponId, GetSide(teamId))
                        local spawnPosition = GetDevicePosition(weaponId) + Rotate(conf.verticalLaunchOffset, -GetDeviceAngle(weaponId))
                        local spawnVelocity = Vec3MultiplyScalar(Rotate(conf.verticalLaunchVelocity, -GetDeviceAngle(weaponId)), velocityMultiplier)
                        local MaxAge = GetProjectileParamInt(missilePairedSaveName, teamId, "MaxAge", 1)
                        local spawnedId = dlc2_CreateProjectile(missilePairedSaveName, deviceSaveName, teamId, spawnPosition, spawnVelocity + additionalVelocity, MaxAge)
                        if conf.setCourseAgain then
                                local position = Vec3MultiplyScalar(pointerVelocity, 100000000)
                                ScheduleCall(conf.setCourseAgainDelay * setCourseAgainDelayMultiplier, SetMissileTargetDelayed, spawnedId, position)
                        end
                        --Print(GetProjectileParamInt(missilePairedSaveName, teamId, "TESTPARAM", 1)) -- IMPORTANT STUFF
                        --SpawnCircle(spawnPosition, 50, Colour(255, 100, 100, 255), 15.05)
                        --SpawnCircle(spawnPosition + spawnVelocity, 50, Colour(255, 255, 255, 255), 15.05)
                end
        end
end

function DestroySmartMissile(nodeId)
        for i, v in pairs(data.smartMissiles) do
                if v.projectileNodeId == nodeId then
                        --local effectid = SpawnEffect(path .. "/effects/ExplosionBig1.lua", NodePosition(nodeId))
                        table.remove(data.smartMissiles, i)
                end
        end
end

function MissileCourseHoldDelay(id)
        for i, v in pairs(data.smartMissiles) do
                if v.projectileNodeId == id then
                        data.smartMissiles[i].courseHoldDelayExpired = true
                end
        end
end

function MakeSmartMissileDelayed(missile)
        if NodeExists(missile.projectileNodeId) then
                table.insert(data.smartMissiles, #data.smartMissiles + 1, missile)
        end
end

function SetMissileTargetDelayed(projectileNodeId, position)
        if NodeExists(projectileNodeId) then
                SetMissileTarget(projectileNodeId, position)
        end
end

function UpdateMissilesVision(frame, allNodes)
        for i, v in pairs(data.smartMissiles) do
                local selfvel = NodeVelocity(v.projectileNodeId)
                local selfspeed = Vec3Length(selfvel)
                local anglev = Vec3Nor(selfvel)
                local position = NodePosition(v.projectileNodeId)
                local saveName = GetNodeProjectileSaveName(v.projectileNodeId)
                local conf = SMARTMISSILE_CONFIG[saveName]
                local nodesPos = GetNodesInSector(allNodes, position, anglev, conf.sectorWidth, v.teamId, conf.sectorRadius, conf.ignoreNeutrals, SMARTMISSILE_CONFIG[saveName].ignoreProjectiles, conf.ignoreStructures, SMARTMISSILE_DRAW_TRACKERS, conf, White())
                local targetedNode = ProcessNodesInSector(nodesPos, position)
                local angle = GetVectorAngle(anglev)
                local targetAcceleration = Vec3(0, 0)

                local aimat
                if targetedNode then
                        local targetpos = nodesPos[targetedNode] -- NOT IDEAL OPTIMISE IF NEEDED
                        local targetvel = allNodes.nodes[targetedNode].velocity
                        local positionalDifference = targetpos - position
                        local distance = Vec3Length(positionalDifference)
                        local velocityDifference = targetvel - selfvel
                        local selfAcceleration = Vec3(0, 0)
                        if v.lastSelfVelocity then
                                selfAcceleration = selfvel - v.lastSelfVelocity
                        end
                        if v.lastTargetVelocity then
                                targetAcceleration = (targetvel - v.lastTargetVelocity) - selfAcceleration
                        end

                        aimat = targetpos

                        local prediction = Vec3(0, 0)
                        SpawnCircle(targetpos, 250, Colour(255, 100, 100, 255), 0.05)
                        if conf.predictionType == 1 then
                                prediction = Vec3MultiplyScalar(targetvel, distance / selfspeed)
                        elseif conf.predictionType == 2 or conf.predictionType == 3 then
                                prediction = Vec3MultiplyScalar(targetvel, distance / Vec3Length(velocityDifference - targetAcceleration))
                        end
                        aimat = aimat + prediction

                        if conf.ballisticTrajectory then
                                if v.ballisticPrevTimeDifX == nil then
                                        v.ballisticPrevTimeDifX = 0
                                end
                                if v.ballisticPrevTimeDifY == nil then
                                        v.ballisticPrevTimeDifY = 0
                                end
                                if v.ballisticPIDix == nil then
                                        v.ballisticPIDix = 0
                                end
                                if v.ballisticPIDiy == nil then
                                        v.ballisticPIDiy = 0
                                end

                                local timeToArrive = Vec3(0, 0)
                                timeToArrive.x = CalculateTimeVelocityAccelerationDistance(selfvel.x, selfAcceleration.x, positionalDifference.x)
                                timeToArrive.y = CalculateTimeVelocityAccelerationDistance(selfvel.y, selfAcceleration.y + (v.gravity * data.worldGravity / data.normalGravity) * conf.ballisticTrajectoryMultiplier, positionalDifference.y)

                                local timeDifY = timeToArrive.y - timeToArrive.x
                                local timeDifX = timeToArrive.x - timeToArrive.y
                                local pidresultx, PIDix = PID(timeDifX, v.ballisticPrevTimeDifX, conf.ballisticPMultiplier, 0, 0, data.updateDelta, v.ballisticPIDix)
                                local pidresulty, PIDiy = PID(timeDifY, v.ballisticPrevTimeDifY, conf.ballisticPMultiplier, 0, 0, data.updateDelta, v.ballisticPIDiy)
                                --Print(timeDif .. "    time Dif")
                                --Print(PIDi .. "    PIDi")
                                --Print(pidresult .. "    pidresult")
                                --Print(timeToArrive .. "    timeToArrive")
                                aimat = aimat + Vec3(pidresultx, pidresulty)

                                v.ballisticPrevTimeDifX = timeDifX
                                v.ballisticPrevTimeDifY = timeDifY
                                v.ballisticPIDix = PIDix
                                v.ballisticPIDiy = PIDiy
                        end

                        v.lastTargetVelocity = targetvel
                else
                        v.lastTargetVelocity = nil
                end

                for i, v in pairs(nodesPos) do
                        --SpawnCircle(v, 20, Colour(255, 100, 100, 255), 0.1)
                end

                if aimat then
                        SetMissileTarget(v.projectileNodeId, aimat)
                else
                        if v.courseHoldDelayExpired then
                                SetMissileTarget(v.projectileNodeId, position + Vec3MultiplyScalar(anglev, 1000000))
                        end
                end
                --SpawnCircle(position + AngleToVector(angle, Vec3Length(NodeVelocity(v.projectileNodeId))), 20,
                --        Colour(255, 255, 255, 255), 0.1)

                v.lastSelfVelocity = selfvel
        end
end

function GetNodesInSector(allNodes, position, anglev, degrees, teamOwner, radius, ignoreNeutrals, ignoreProjectiles, ignoreStructures, drawVisuals, smartMissileConfig, color) -- OPTIMISE THIS. BIGGEST LAG SOURCE. ADD CHECK ON THE CLOSEST STRUCTURE + ITS RADIUS
        local nodes = {}

        if drawVisuals then
                local angle = GetVectorAngle(anglev)
                if smartMissileConfig then
                        DrawCircleSector(position, angle, degrees, radius, smartMissileConfig.trackerColor, 1 / 20, false, smartMissileConfig.trackerGradient, smartMissileConfig.trackerGradientMax, smartMissileConfig.trackerGradientMin)
                elseif color then
                        DrawCircleSector(position, angle, degrees, radius, color, 1 / 20, false)
                end
        end

        --local enemyteams = GetEnemyTeams(teamOwner, ignoreNeutrals)
        --for k, enemyteam in pairs(enemyteams) do
        --        if not ignoreStructures then -- OPTIMISATION PURPOSES: CHECK ONLY STRUCTURES IN RANGE, USE allNodes, RAYCAST TO THE TARGET TO CHECK VISIBILITY
        --                for i = 0, NodeCount(enemyteam), 1 do -- SCAN RESOLUTION. AFFECTS LAG VERY MUCH
        --                        local nodeid = GetNodeId(enemyteam, i)
        --                        if not NodeExists(nodeid) then
        --                                continue
        --                        end
        --                        if NodeNonSegmentedLinkCount(nodeid) < 1 then
        --                                continue
        --                        end
        --                        local nodepos = NodePosition(nodeid)
        --                        local dirNonNor = nodepos - position
        --                        if Vec3Length(dirNonNor) > radius then
        --                                continue
        --                        end
        --                        local anglebetween = AngleBetweenTwoVectors(Vec3Nor(dirNonNor), anglev)
        --                        if anglebetween < degrees then
        --                                nodes[nodeid] = nodepos
        --                        end
        --                end
        --        end
        --        if not ignoreProjectiles then
        --                for i = 0, ProjectileCount(enemyteam), 1 do
        --                        local nodeid = GetProjectileId(enemyteam, i)
        --                        if not NodeExists(nodeid) then
        --                                continue
        --                        end
        --                        local nodeProjectileType = GetNodeProjectileType(nodeid)
        --                        if nodeProjectileType ~= (2 or 3) then
        --                                continue
        --                        end
        --                        local nodepos = NodePosition(nodeid)
        --                        local dirNonNor = nodepos - position
        --                        if Vec3Length(dirNonNor) > radius then
        --                                continue
        --                        end
        --                        local anglebetween = AngleBetweenTwoVectors(Vec3Nor(dirNonNor), anglev)
        --                        if anglebetween < degrees then
        --                                nodes[nodeid] = nodepos
        --                        end
        --                end
        --        end
        --end

        local enemySides = GetEnemySides(GetSide(teamOwner), ignoreNeutrals)
        for __, side in pairs(enemySides) do
                if allNodes.sidesStructures[side] == nil then
                        continue
                end
                for structureId, structure in pairs(allNodes.sidesStructures[side]) do
                        local structureRadius = allNodes.sidesStructures[side][structureId].radius * SMARTMISSILE_STRUCTURE_RADIUS_MULTIPLIER
                        local structurePos = allNodes.sidesStructures[side][structureId].position
                        local distanceToStructure = Vec3Length(structurePos - position) - structureRadius
                        if distanceToStructure > radius then
                                continue
                        end
                        local scanEveryXLoops = math.floor(GetTableCount(structure.nodes) / (1000 / GetTableCount(data.smartMissiles)))
                        local scanDelay = scanEveryXLoops
                        for nodeId, node in pairs(structure.nodes) do
                                scanDelay = scanDelay - 1
                                if scanDelay > 0 then
                                        continue
                                end
                                scanDelay = scanEveryXLoops

                                --SpawnCircle(node.position, 20, Colour(0, 255, 100, 255), 0.1)
                                if node.nonSegmentedLinkCount < 1 then
                                        continue
                                end
                                local dirNonNor = node.position - position
                                if Vec3Length(dirNonNor) > radius then
                                        continue
                                end
                                local anglebetween = AngleBetweenTwoVectors(Vec3Nor(dirNonNor), anglev)
                                if anglebetween > degrees then
                                        continue
                                end
                                if CastGroundRay(position, node.position, SMARTMISSILE_TERRAINFLAGS) ~= 0 then
                                        continue
                                end
                                --SpawnCircle(node.position, 50, Colour(0, 255, 200, 255), 0.1)
                                nodes[nodeId] = node.position
                        end
                end
        end

        for __, side in pairs(enemySides) do
                if allNodes.sideProjectiles[side] == nil then
                        continue
                end
                for projectileId, projectile in pairs(allNodes.sideProjectiles[side]) do
                        --SpawnCircle(projectile.position, 20, Colour(0, 255, 100, 255), 0.1)

                        if not AnyOf(smartMissileConfig.targetProjectiles, projectile.type) then
                                continue
                        end

                        local dirNonNor = projectile.position - position
                        if Vec3Length(dirNonNor) > radius then
                                continue
                        end

                        local anglebetween = AngleBetweenTwoVectors(Vec3Nor(dirNonNor), anglev)
                        if anglebetween > degrees then
                                continue
                        end
                        if CastGroundRay(position, projectile.position, SMARTMISSILE_TERRAINFLAGS) ~= 0 then
                                continue
                        end
                        nodes[projectileId] = projectile.position
                end
        end
        return nodes
end

function ProcessNodesInSector(table, position)
        local closestid
        local smallestLength = math.huge
        for i, v in pairs(table) do
                local len = Vec3Length(position - v)
                --if not smallestLength then
                --        smallestLength = len
                --        closestid = i
                --else
                if smallestLength > len then
                        smallestLength = len
                        closestid = i
                end
                --end
        end
        return closestid
end
