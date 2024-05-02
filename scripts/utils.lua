function GetEnemyTeams(teamId, ignoreNeutrals) -- ADD RETURN SIDES ONLY PARAM
        local teamstable = {}
        if not ignoreNeutrals then
                --Print("Testing: " .. teamId)
                --Print("Enemy table:")
                for i = 1, GetTeamCount(), 1 do
                        local enemyside = GetSide(GetTeamId(i))
                        if GetSide(teamId) ~= enemyside then
                                table.insert(teamstable, GetTeamId(i))
                                --Print(GetTeamId(i))
                        end
                end
                return teamstable
        else
                for i = 1, GetTeamCount(), 1 do
                        local enemyside = GetSide(GetTeamId(i))
                        if GetSide(teamId) ~= enemyside and (enemyside == TEAM_1 or enemyside == TEAM_2) then
                                table.insert(teamstable, GetTeamId(i))
                                --Print(GetTeamId(i))
                        end
                end
                return teamstable
        end
end

function GetEnemySides(side, ignoreNeutrals)
        if ignoreNeutrals then
                if side == 1 then
                        return { 2 }
                else
                        return { 1 }
                end
        else
                if side == 1 then
                        return { 2, 0, -1, -2, -3 }
                else
                        return { 1, 0, -1, -2, -3 }
                end
        end
end

function GetStructurePosition(startPos, structureId, allNodes, structureRadius)
        local inversePos = Vec3(startPos.x, -startPos.y)
        local nodeIdclosest1 = FindNodeOnStructure(startPos, structureId, false)
        local nodeIdfurthest1 = FindNodeOnStructure(startPos, structureId, true)
        --Log(tostring(NodePosition(nodeIdclosest)) .. "    " .. tostring(NodePosition(nodeIdfurthest)))
        local closestPos1
        local furthestPos1
        if allNodes then
                closestPos1 = allNodes.nodes[nodeIdclosest1].position
                furthestPos1 = allNodes.nodes[nodeIdfurthest1].position
        else
                closestPos1 = NodePosition(nodeIdclosest1)
                furthestPos1 = NodePosition(nodeIdfurthest1)
        end
        if structureRadius == nil then
                structureRadius = 100
        end

        if Vec3Length(closestPos1) < 0.1 then
                local a = furthestPos1 - Vec3MultiplyScalar(Vec3Nor(furthestPos1 - startPos), structureRadius)
                return a
        end
        return Vec3MultiplyScalar(closestPos1 + furthestPos1, 0.5)
end

function GetStructurePositionAccurate(startPos, structureId, allNodes, structureRadius)
        local twoPos = Vec3(startPos.x, -startPos.y)
        local threePos = Vec3(-startPos.x, -startPos.y)
        local fourPos = Vec3(-startPos.x, startPos.y)

        local nodeIdclosest1 = FindNodeOnStructure(startPos, structureId, false)
        local nodeIdfurthest1 = FindNodeOnStructure(startPos, structureId, true)
        local nodeIdclosest2 = FindNodeOnStructure(twoPos, structureId, false)
        local nodeIdfurthest2 = FindNodeOnStructure(twoPos, structureId, true)
        local nodeIdclosest3 = FindNodeOnStructure(threePos, structureId, false)
        local nodeIdfurthest3 = FindNodeOnStructure(threePos, structureId, true)
        local nodeIdclosest4 = FindNodeOnStructure(fourPos, structureId, false)
        local nodeIdfurthest4 = FindNodeOnStructure(fourPos, structureId, true)
        --Log(tostring(NodePosition(nodeIdclosest)) .. "    " .. tostring(NodePosition(nodeIdfurthest)))
        local closestPos1
        local furthestPos1
        local closestPos2
        local furthestPos2
        local closestPos3
        local furthestPos3
        local closestPos4
        local furthestPos4
        if allNodes then
                closestPos1 = allNodes.nodes[nodeIdclosest1].position
                furthestPos1 = allNodes.nodes[nodeIdfurthest1].position
                closestPos2 = allNodes.nodes[nodeIdclosest2].position
                furthestPos2 = allNodes.nodes[nodeIdfurthest2].position
                closestPos3 = allNodes.nodes[nodeIdclosest3].position
                furthestPos3 = allNodes.nodes[nodeIdfurthest3].position
                closestPos4 = allNodes.nodes[nodeIdclosest4].position
                furthestPos4 = allNodes.nodes[nodeIdfurthest4].position
        else
                closestPos1 = NodePosition(nodeIdclosest1)
                furthestPos1 = NodePosition(nodeIdfurthest1)
                closestPos2 = NodePosition(nodeIdclosest2)
                furthestPos2 = NodePosition(nodeIdfurthest2)
                closestPos3 = NodePosition(nodeIdclosest3)
                furthestPos3 = NodePosition(nodeIdfurthest3)
                closestPos4 = NodePosition(nodeIdclosest4)
                furthestPos4 = NodePosition(nodeIdfurthest4)
        end
        SpawnCircle(furthestPos1, 20, Colour(0, 255, 100, 255), 0.1)
        SpawnCircle(furthestPos2, 50, Colour(255, 255, 100, 255), 0.1)
        SpawnCircle(furthestPos3, 40, Colour(255, 255, 255, 255), 0.1)
        SpawnCircle(furthestPos4, 30, Colour(105, 255, 250, 255), 0.1)
        if structureRadius == nil then
                structureRadius = 100
        end

        if Vec3Length(closestPos1) < 0.1 or Vec3Length(closestPos2) < 0.1 or Vec3Length(closestPos3) < 0.1 or Vec3Length(closestPos4) < 0.1 then
                local a = furthestPos1 - Vec3MultiplyScalar(Vec3Nor(furthestPos1 - startPos), structureRadius)
                local b = furthestPos2 - Vec3MultiplyScalar(Vec3Nor(furthestPos2 - twoPos), structureRadius)
                local c = furthestPos3 - Vec3MultiplyScalar(Vec3Nor(furthestPos3 - threePos), structureRadius)
                local d = furthestPos4 - Vec3MultiplyScalar(Vec3Nor(furthestPos4 - fourPos), structureRadius)
                SpawnCircle(a, 20, Colour(0, 255, 100, 255), 0.1)
                SpawnCircle(b, 50, Colour(255, 255, 100, 255), 0.1)
                SpawnCircle(c, 40, Colour(255, 255, 255, 255), 0.1)
                SpawnCircle(d, 30, Colour(105, 255, 250, 255), 0.1)
                return Vec3MultiplyScalar(a + b + c + d, 0.25)
        end
        return Vec3MultiplyScalar(closestPos1 + furthestPos1 + closestPos2 + furthestPos2 + closestPos3 + furthestPos3 + closestPos4 + furthestPos4, 0.125)
end

function GetStructureAllNodes(allNodes, structureId)
        local side = GetSide(GetStructureTeam(structureId))

        if allNodes == nil then
                allNodes = {}
                allNodes.sidesStructures = {}
                allNodes.sidesStructures[side] = {}
                allNodes.sidesStructures[side][structureId] = {}
        end

        allNodes.sidesStructures[side][structureId].nodes = {}
        allNodes.sidesStructures[side][structureId].isInWater = GetStructureInWater(structureId)
        allNodes.sidesStructures[side][structureId].isOnLand = GetStructureOnLand(structureId)
        allNodes.sidesStructures[side][structureId].radius = GetStructureRadius(structureId)
        allNodes.sidesStructures[side][structureId].position = GetStructurePositionAccurate(Vec3(1000000, 1000000), structureId, nil, allNodes.sidesStructures[side][structureId].radius)
        allNodes.sidesStructures[side][structureId].teamId = GetStructureTeam(structureId)

        allNodes.nodes = {}
        for i = 0, NodeCount(side) - 1, 1 do
                local nodeId = GetNodeId(side, i)
                if NodeExists(nodeId) then
                        local nodeStructureId = NodeStructureId(nodeId)
                        if nodeStructureId == structureId then
                                if allNodes.sidesStructures[side][nodeStructureId] ~= nil and allNodes.sidesStructures[side][nodeStructureId].nodes ~= nil then
                                        local position = NodePosition(nodeId)
                                        local velocity = NodeVelocity(nodeId)
                                        local nonSegmentLinkCount = NodeNonSegmentedLinkCount(nodeId)
                                        local linkCount = NodeLinkCount(nodeId)

                                        allNodes.sidesStructures[side][nodeStructureId].nodes[nodeId] = {}
                                        allNodes.sidesStructures[side][nodeStructureId].nodes[nodeId].position = position
                                        allNodes.sidesStructures[side][nodeStructureId].nodes[nodeId].velocity = velocity
                                        allNodes.sidesStructures[side][nodeStructureId].nodes[nodeId].nonSegmentedLinkCount = nonSegmentLinkCount
                                        allNodes.sidesStructures[side][nodeStructureId].nodes[nodeId].linkCount = linkCount

                                        allNodes.nodes[nodeId] = {}
                                        allNodes.nodes[nodeId].position = position
                                        allNodes.nodes[nodeId].velocity = velocity
                                        allNodes.nodes[nodeId].nonSegmentLinkCount = nonSegmentLinkCount
                                        allNodes.nodes[nodeId].linkCount = linkCount
                                end
                        end
                end
        end

        return allNodes
end

function FindNodesInRadius(allNodes, radius, pos, structureRadiusMultiplier)
        local nodes = {}
        for side, sideTable in pairs(allNodes.sidesStructures) do
                for structureId, structureTable in pairs(sideTable) do
                        local distance = structureTable.position - pos
                        local structureRadius = structureTable.radius * structureRadiusMultiplier

                        if Vec3Length(distance) - structureRadius < radius then
                                for nodeId, nodeTable in pairs(structureTable.nodes) do
                                        local nodeDistance = Vec3Length(nodeTable.position - pos)
                                        if nodeDistance < radius then
                                                nodes[nodeId] = nodeDistance
                                        end
                                end
                        end
                end
        end
        return nodes
end

function FindSideNodesInRadius(allNodes, radius, pos, structureRadiusMultiplier, side)
        local nodes = {}
        for structureId, structureTable in pairs(allNodes.sidesStructures[side]) do
                local distance = structureTable.position - pos
                local structureRadius = structureTable.radius * structureRadiusMultiplier

                if Vec3Length(distance) - structureRadius < radius then
                        for nodeId, nodeTable in pairs(structureTable.nodes) do
                                local nodeDistance = Vec3Length(nodeTable.position - pos)
                                if nodeDistance < radius then
                                        nodes[nodeId] = nodeDistance
                                end
                        end
                end
        end
        return nodes
end

function FindStructureNodesInRadius(allNodes, radius, pos, side, structureId)
        local nodes = {}
        for nodeId, nodeTable in pairs(allNodes.sidesStructures[side][structureId]) do
                local nodeDistance = Vec3Length(nodeTable.position - pos)
                if nodeDistance < radius then
                        nodes[nodeId] = nodeDistance
                end
        end
        return nodes
end

function IsWithinDistance(vector1, vector2, distance)
        local dx = vector1.x - vector2.x
        local dy = vector1.y - vector2.y
        local distanceSquared = dx * dx + dy * dy
        local givenDistanceSquared = distance * distance
    
        return distanceSquared <= givenDistanceSquared
    end

function GetSide(teamId)
        local side = teamId % 100
        if side > 50 then
                side = side - 100
        end
        return side
end

function GetTableCount(table)
        local i = 0
        for key, value in pairs(table) do
                i = i + 1
        end
        return i
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

function Vec3Limit(vector, scalar)
        local length = Vec3Length(vector)
        if length > scalar then
                return Vec3MultiplyScalar(vector, scalar / length)
        else
                return vector
        end
end

function Vec3MHLength(vector)
        return math.abs(math.abs(vector.x) - math.abs(vector.y)) + math.min(math.abs(vector.x), math.abs(vector.y)) * 1.41421
end

function Vec3CheapLength(vector)
        return math.min(vector.x, vector.y)
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
                b = Vec3(1, 0)
        end
        return math.deg(math.acos(Vec3Dot(a, b) / (Vec3Length(a) * Vec3Length(b))))
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

function GetFortsVectorAngle(vector)
        --CHECK IF X = 0
        vector = Vec3(vector.x, -vector.y)
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

function AngleToFortsVector(angle, radius)
        if radius then
                return Vec3MultiplyScalar(Vec3(math.cos(math.rad(angle)), -math.sin(math.rad(angle))), radius)
        else
                return Vec3(math.cos(math.rad(angle)), -math.sin(math.rad(angle)))
        end
end

function ConvertAngleToForts(angle)
        local output = angle
        if output > 270 then
                output = output - 360
        end
        return math.rad(output)
end

function ConvertAngleToNormal(angle)
        local output = math.deg(angle)
        if output < 0 then
                output = output + 360
        end
        return output
end

---@type function
---@param error number Difference between set value and the desired
---@param prevError number Error on the last tick
---@param kp number Proportional multiplier
---@param ki number Integral multiplier
---@param kd number Differentional multiplier
---@param dT number Delta time
---@param i number Saved integral value
---@return number output PID result
---@return number i Integral number to be saved and passed on the next run
function PID(error, prevError, kp, ki, kd, dT, i)
        local p = error
        if i == nil then
                i = 0
        end
        i = i + (error * dT)
        local d = (error - prevError) / dT

        local output = (kp * p) + (ki * i) + (kd * d)
        return output, i
end

function CalculateTimeVelocityAccelerationDistance(v0, a, d)
        local discriminant = v0 ^ 2 + 2 * a * d
        if a == 0 or discriminant <= 0 then
                if v0 == 0 then
                        return d / 0.00001
                else
                        return d / v0
                end
        end
        return (-v0 + math.sqrt(discriminant)) / a
end

function DrawCircleSector(position, angle, degrees, radius, color, fadetime, middleLine, gradient, gradientMax, gradienMin)
        local lowerangle = angle - (degrees)
        local upperrangle = angle + (degrees)

        local lineSegments = 4

        if gradient then
                if gradienMin == nil then
                        gradienMin = 1
                end
                if gradientMax == nil then
                        gradientMax = 0
                end
                local col
                for i = 1, lineSegments, 1 do
                        col = Colour(color.r, color.g, color.b, color.a * math.min(math.max((lineSegments - i) / lineSegments, gradientMax), gradienMin))
                        local radmin = radius * (i - 1) / lineSegments
                        local radmax = radius * i / lineSegments
                        SpawnLine(position + AngleToVector(lowerangle, radmin), position + AngleToVector(lowerangle, radmax), col, fadetime)
                        SpawnLine(position + AngleToVector(upperrangle, radmin), position + AngleToVector(upperrangle, radmax), col, fadetime)
                        if middleLine then
                                SpawnLine(position + AngleToVector(angle, radmin), position + AngleToVector(angle, radmax), col, fadetime)
                        end
                end
                color = col
        else
                SpawnLine(position, position + AngleToVector(lowerangle, radius), color, fadetime)
                SpawnLine(position, position + AngleToVector(upperrangle, radius), color, fadetime)
                if middleLine then
                        SpawnLine(position, position + AngleToVector(angle, radius), color, fadetime)
                end
        end

        if color.a > 15 and gradientMax and gradientMax > 0.05 then
                local vertexes = math.ceil(radius / 250)
                local currentangle = lowerangle
                local step = 2 * degrees / vertexes
                for i = 1, vertexes, 1 do
                        local nextangle = currentangle + step
                        SpawnLine(position + AngleToVector(currentangle, radius), position + AngleToVector(nextangle, radius), color, fadetime)
                        currentangle = nextangle
                end
        end
end

function TestCall(func, ...)
        local isGood, result = pcall(func, unpack(arg))
        if not isGood then
                Print(result)
        end
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

function PrintTable(table)
        for i, v in pairs(table) do
                Print(v)
        end
end
