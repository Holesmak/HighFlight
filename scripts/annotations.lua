-- https://github.com/LuaLS/lua-language-server/wiki/Annotations#return

---@class forts
---@type function
---@return number teamCount Built in function.
function GetTeamCount()
        local n
        return n
end
---@type function
---@param timeSeconds number
---@param func function
---@param param any
function ScheduleCall(timeSeconds, func, param)
end
---@type function
---@param nodeId number
---@return table velocity Built in function.
function NodeVelocity(nodeId)
        local vel
        return vel
end
---@type function
---@param nodeId number
---@return number teamId Built in function.
function GetTeamId(nodeId)
        local n
        return n
end
---@type function
---@param posA table Built in function. Draws a debug line
---@param posB table
---@param color table
---@param timeToFade number
function SpawnLine(posA, posB, color, timeToFade)
end
---@type function
---@param pos table Built in function. Draws a debug circle
---@param radius number
---@param color table
---@param timeToFade number
function SpawnCircle(pos, radius, color, timeToFade)
end
---@type function
---@param string string Built in function. Does not convert other types to string
function Log(string)
end
---@type function
---@param projectileNodeId number
---@return string saveName Built in function.
function GetNodeProjectileSaveName(projectileNodeId)
        local s
        return s
end
---@type function
---@param nodeId number
---@return table position Built in function.
function NodePosition(nodeId)
        local pos
        return pos
end
---@type function
---@param r number
---@param g number
---@param b number
---@param a number
---@return table colour Built in function.
function Colour(r, g, b, a)
        local c
        return c
end
---@type function
---@param projectileNodeId number Built in function.
---@param pos table
function SetMissileTarget(projectileNodeId, pos)
end
---@type function
---@param teamId number
---@return number nodeCount Built in function.
function NodeCount(teamId)
        local n
        return n
end
---@type function
---@param teamId number
---@return number projectileCount Built in function.
function ProjectileCount(teamId)
        local n
        return n
end
---@type function
---@param teamId number
---@param teamNodeId number
---@return number nodeId Built in function. Returns global nodeId when given team nodeId
function GetNodeId(teamId, teamNodeId)
        local id
        return id
end
---@type function
---@param nodeId number
---@return boolean doesExist Built in function.
function NodeExists(nodeId)
        local b
        return b
end
---@type function
---@param nodeid number
---@return number type Built in function. See types in forts.lua
function GetNodeProjectileType(nodeid)
        local n
        return n
end
---@type table
data = {}
---@type string
path = ""


---@class Vec3
---@type function
---@param vector table
---@return number length Built in function. Returns vector magnitude
function Vec3Length(vector)
        local n
        return n
end
---@type function
---@param x number
---@param y number
---@return table vector Built in function. Returns vector made out of 'x' and 'y' axes
function Vec3(x, y)
        local vec
        return vec
end
---@type function
---@param x table
---@param y table
---@return number dot Built in function. Returns dot product of the two vectors
function Vec3Dot(x, y)
        local n
        return n
end