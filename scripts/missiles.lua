---@class forts

dofile(path .. "/scripts/missiles_config.lua")

function MissilesLoad(gameStart)
        data.smartMissiles = {}
end

function MissilesOnRestart()
        data.smartMissiles = {}
end

function MissilesUpdate(frame)
        UpdateMissilesVision(frame)
end

function MakeSmartMissile(teamId, projectileNodeId)
        if AnyOf(SMARTMISSILE_SAVENAMES, GetNodeProjectileSaveName(projectileNodeId)) --[[GetNodeProjectileType(projectileNodeId) == 2]] then
                local missile = {}
                missile.projectileNodeId = projectileNodeId
                missile.teamId = teamId
                missile.saveName = GetNodeProjectileSaveName(projectileNodeId)
                table.insert(data.smartMissiles, #data.smartMissiles + 1, missile)
                --Print(SMARTMISSILE_CONFIG[missile.saveName].courseHoldDelay .. " : " .. #data.smartMissiles + 1)
                ScheduleCall(SMARTMISSILE_CONFIG[missile.saveName].courseHoldDelay, MissileCourseHoldDelay, projectileNodeId)
        end
end

function DestroySmartMissile(nodeId)
        for i, v in pairs(data.smartMissiles) do
                if v.projectileNodeId == nodeId then
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

function UpdateMissilesVision(frame)
        for i, v in pairs(data.smartMissiles) do
                local selfvel = NodeVelocity(v.projectileNodeId)
                local anglev = Vec3Nor(selfvel)
                local position = NodePosition(v.projectileNodeId)
                local conf = SMARTMISSILE_CONFIG[GetNodeProjectileSaveName(v.projectileNodeId)]
                local nodes = GetNodesInSector(position, anglev, conf.sectorWidth, v.teamId, conf.sectorRadius, conf.ignoreNeutrals, SMARTMISSILE_CONFIG[GetNodeProjectileSaveName(v.projectileNodeId)].ignoreProjectiles, conf.ignoreStructures)
                local closestnode = ClosestOf(nodes, position)
                local angle = GetVectorAngle(anglev)

                local aimat
                if closestnode then
                        aimat = nodes[closestnode]
                        SpawnCircle(nodes[closestnode], 50, Colour(255, 255, 100, 255), 0.1)
                        if conf.predictionType == 1 then
                                aimat = nodes[closestnode] + Vec3MultiplyScalar(NodeVelocity(closestnode), Vec3Length((nodes[closestnode] - position)) / Vec3Length(NodeVelocity(v.projectileNodeId)))
                        elseif conf.predictionType == 2 then
                                aimat = nodes[closestnode] + Vec3MultiplyScalar(NodeVelocity(closestnode), Vec3Length((nodes[closestnode] - position)) / Vec3Length(NodeVelocity(closestnode) - NodeVelocity(v.projectileNodeId)))
                        elseif conf.predictionType == 3 then
                                local acc = Vec3(0, 0)
                                local targetvel = NodeVelocity(closestnode)
                                local targetpos = nodes[closestnode]
                                if v.lastTargetVelocity then
                                        acc = (targetvel - v.lastTargetVelocity) - (selfvel - v.lastSelfVelocity)
                                        aimat = targetpos + Vec3MultiplyScalar(targetvel, Vec3Length((targetpos - position)) / Vec3Length(targetvel - selfvel - acc))
                                else
                                        aimat = targetpos + Vec3MultiplyScalar(targetvel, Vec3Length((targetpos - position)) / Vec3Length(targetvel - selfvel))
                                end
                                v.lastTargetVelocity = targetvel
                        end
                else
                        v.lastTargetVelocity = nil
                end

                for i, v in pairs(nodes) do
                        SpawnCircle(v, 20, Colour(255, 100, 100, 255), 0.1)
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

function GetNodesInSector(position, anglev, degrees, teamOwner, radius, ignoreNeutrals, ignoreProjectiles, ignoreStructures)
        --Print(GetVectorAngle(angle))
        --Print(AngleToVector(angle, 5).x .. "   " .. AngleToVector(angle, 5).y)
        --Print(angle.x .. "   " .. angle.y)
        local enemyteams = GetEnemyTeams(teamOwner, ignoreNeutrals)
        local angle = GetVectorAngle(anglev)
        local nodes = {}

        DrawCircleSector(position, angle, degrees, radius, Red(), 0.05, false)

        if not CheckType(enemyteams, "number") then --dont ignore neutrals
                for k, enemyteam in pairs(enemyteams) do
                        if not ignoreStructures then
                                for i = 0, NodeCount(enemyteam), 1 do
                                        local nodeid = GetNodeId(enemyteam, i)
                                        local nodepos = NodePosition(nodeid)
                                        local dirNonNor = nodepos - position
                                        --local nodeangle = GetVectorAngle(Vec3Nor(dirNonNor))
                                        local anglebetween = AngleBetweenTwoVectors(Vec3Nor(dirNonNor), anglev)
                                        if anglebetween < degrees and Vec3Length(dirNonNor) < radius and NodeExists(nodeid) then
                                                nodes[nodeid] = nodepos
                                        end
                                end
                        end

                        if not ignoreProjectiles then
                                for i = 0, ProjectileCount(enemyteam), 1 do
                                        local nodeid = GetProjectileId(enemyteam, i)
                                        local nodepos = NodePosition(nodeid)
                                        local dirNonNor = nodepos - position
                                        --local nodeangle = GetVectorAngle(Vec3Nor(dirNonNor))
                                        local anglebetween = AngleBetweenTwoVectors(Vec3Nor(dirNonNor), anglev)
                                        if anglebetween < degrees and Vec3Length(dirNonNor) < radius and NodeExists(nodeid) and (GetNodeProjectileType(nodeid) == 2 or GetNodeProjectileType(nodeid) == 3) then
                                                nodes[nodeid] = nodepos
                                        end
                                end
                        end
                end
        else
                local enemyteam = enemyteams
                if not ignoreStructures then
                        for i = 0, NodeCount(enemyteam), 1 do
                                local nodeid = GetNodeId(enemyteam, i)
                                local nodepos = NodePosition(nodeid)
                                local dirNonNor = nodepos - position
                                --local nodeangle = GetVectorAngle(Vec3Nor(dirNonNor))
                                local anglebetween = AngleBetweenTwoVectors(Vec3Nor(dirNonNor), anglev)
                                if anglebetween < degrees and Vec3Length(dirNonNor) < radius and NodeExists(nodeid) then
                                        nodes[nodeid] = nodepos
                                end
                        end
                end

                if not ignoreProjectiles then
                        for i = 0, ProjectileCount(enemyteam), 1 do
                                local nodeid = GetProjectileId(enemyteam, i)
                                local nodepos = NodePosition(nodeid)
                                local dirNonNor = nodepos - position
                                --local nodeangle = GetVectorAngle(Vec3Nor(dirNonNor))
                                local anglebetween = AngleBetweenTwoVectors(Vec3Nor(dirNonNor), anglev)
                                if anglebetween < degrees and Vec3Length(dirNonNor) < radius and NodeExists(nodeid) and (GetNodeProjectileType(nodeid) == 2 or GetNodeProjectileType(nodeid) == 3) then
                                        nodes[nodeid] = nodepos
                                end
                        end
                end
        end
        return nodes
end