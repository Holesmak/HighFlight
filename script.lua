dofile("scripts/forts.lua")
dofile("scripts/core.lua")


--[[
TODO

make missiles choose untargeted projectiles to spread the damage

]]
SMARTMISSILE_SAVENAMES = {
        --"rocketemp",
        --"missile2",
        --"rocket",
        --"rocketmi24",
        "HighFlight_antiair1"
}

SMARTMISSILE_CONFIG = {}
SMARTMISSILE_CONFIG["rocketemp"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = false,
        ignoreStructures = false,
        predictionType = 1,
        sectorRadius = 2500,
        sectorWidth = 30,
}

SMARTMISSILE_CONFIG["rocketmi24"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = false,
        ignoreStructures = true,
        predictionType = 1,
        sectorRadius = 4000,
        sectorWidth = 45,
}

SMARTMISSILE_CONFIG["missile2"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = true,
        ignoreStructures = false,
        predictionType = 1,
        sectorRadius = 2500,
        sectorWidth = 30,
}

SMARTMISSILE_CONFIG["HighFlight_antiair1"] = {
        ignoreNeutrals = false,
        ignoreProjectiles = false,
        ignoreStructures = false,
        predictionType = 2,
        sectorRadius = 7000,
        sectorWidth = 30,
        courseHoldDelay = 1,
}

function Load(gameStart)
        data.smartMissiles = {}
        --local t = GetEnemyTeams(1, false)
        --for index, v in ipairs(t) do
        --        Print(v)
        --end
end

function OnRestart()
        data.smartMissiles = {}
end

function Update(frame)
        UpdateMissilesVision(frame)
end

function OnWeaponFired(teamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)
        --Print(saveName)
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

function OnProjectileDestroyed(nodeId, teamId, saveName, structureIdHit, destroyType)
        CleanSmartMissiles(nodeId)
end

function CleanSmartMissiles(nodeId)
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

function GetEnemyTeams(teamId, ignoreNeutrals)
        local teamstable = {}
        if not ignoreNeutrals then
                --Print("Testing: " .. teamId)
                --Print("Enemy table:")
                for i = 1, GetTeamCount(), 1 do
                        if teamId % 100 ~= GetTeamId(i) % 100 then
                                table.insert(teamstable, GetTeamId(i))
                                --Print(GetTeamId(i))
                        end
                end
                return teamstable
        else
                if teamId % 100 == 1 then
                        return 2
                elseif teamId % 100 == 2 then
                        return 1
                end
        end
end

function Vec3Nor(vector)
        local l = Vec3Length(vector)
        local il = 1 / l
        local x = vector.x * il
        local y = vector.y * il
        --local z = vector.z * il
        return Vec3(x, y)
end

function Vec3MultiplyScalar(vector, scalar)
        local x = vector.x * scalar
        local y = vector.y * scalar
        return Vec3(x, y)
end

--function Vec3DivideScalar(vector, scalar)
--        local x = vector.x / scalar
--        local y = vector.y / scalar
--        return Vec3(x, y)
--end

function AnyOf(table, element)
        for i, v in pairs(table) do
                if v == element then
                        return true
                end
        end
        return false
end

function FindIn(table, element)
        for i, v in pairs(table) do
                if v == element then
                        return i
                end
        end
end

function ClosestOf(table, position)
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

function AngleBetweenTwoVectors(a, b)
        if not b then
                local b = Vec3(1, 0)
        end
        local ans = math.acos(Vec3Dot(a, b) / (Vec3Length(a) * Vec3Length(b)))
        return math.deg(ans)
end

function GetVectorAngle(vector)
        --CHECK IF X = 0
        local ans = math.deg(math.atan(vector.y / vector.x))
        if vector.x < 0 then
                ans = ans + 180
        end
        if vector.y < 0 and vector.x > 0 then
                ans = ans + 360
        end
        return ans
end

function AngleToVector(angle, radius)
        if radius then
                return Vec3MultiplyScalar(Vec3(math.cos(math.rad(angle)), math.sin(math.rad(angle))), radius)
        else
                return Vec3(math.cos(math.rad(angle)), math.sin(math.rad(angle)))
        end
end

function DrawCircleSector(position, angle, degrees, radius, color, fadetime, middleLine)
        local lowerangle = angle - (degrees)
        local upperrangle = angle + (degrees)
        SpawnLine(position, position + AngleToVector(lowerangle, radius), color, fadetime)
        SpawnLine(position, position + AngleToVector(upperrangle, radius), color, fadetime)
        if middleLine then
                SpawnLine(position, position + AngleToVector(angle, radius), color, fadetime)
        end

        local vertexes = math.ceil(radius / 100)
        local currentangle = lowerangle
        local step = 2 * degrees / vertexes
        for i = 1, vertexes, 1 do
                local nextangle = currentangle + step
                SpawnLine(position + AngleToVector(currentangle, radius), position + AngleToVector(nextangle, radius),
                        color, fadetime)
                currentangle = nextangle
        end
end

function FixVelocityV(vector) -- NOT NEEDED
        return Vec3(vector.x, -vector.y)
end

function CheckType(object, typ)
        if type(object) == typ then
                return true
        else
                return false
        end
end

function Print(text)
        Log(tostring(text))
end
