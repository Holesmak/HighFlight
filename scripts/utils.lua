function GetEnemyTeams(teamId, ignoreNeutrals) -- ADD RETURN SIDES ONLY PARAM
        local teamstable = {}
        if not ignoreNeutrals then
                --Print("Testing: " .. teamId)
                --Print("Enemy table:")
                for i = 1, GetTeamCount(), 1 do
                        local enemyside = GetTeamId(i) % 100
                        if teamId % 100 ~= enemyside then
                                table.insert(teamstable, GetTeamId(i))
                                --Print(GetTeamId(i))
                        end
                end
                return teamstable
        else
                for i = 1, GetTeamCount(), 1 do
                        local enemyside = GetTeamId(i) % 100
                        if teamId % 100 ~= enemyside and (enemyside == TEAM_1 or enemyside == TEAM_2) then
                                table.insert(teamstable, GetTeamId(i))
                                --Print(GetTeamId(i))
                        end
                end
                return teamstable
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

        if color.a > 15  and gradientMax and gradientMax > 0.05 then
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
