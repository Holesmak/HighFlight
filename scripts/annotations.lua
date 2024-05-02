-- https://github.com/LuaLS/lua-language-server/wiki/Annotations#return

---@class forts
---@type function
---@see GetTeamCount Built in function.
---@return number teamCount
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
---@see NodeVelocity Built in function.
---@param nodeId number
---@return table velocity
function NodeVelocity(nodeId)
        local vel
        return vel
end
---@type function
---@see GetTeamId Built in function.
---@param nodeId number
---@return number teamId
function GetTeamId(nodeId)
        local n
        return n
end
---@type function
---@see SpawnLine Built in function. Draws a debug line
---@param posA table
---@param posB table
---@param color table
---@param timeToFade number
function SpawnLine(posA, posB, color, timeToFade)
end
---@type function
---@see SpawnCircle Built in function. Draws a debug circle
---@param pos table
---@param radius number
---@param color table
---@param timeToFade number
function SpawnCircle(pos, radius, color, timeToFade)
end
---@type function
---@see Log Built in function. Does not convert other types to string
---@param string string
function Log(string)
end
---@type function
---@see GetNodeProjectileSaveName Built in function.
---@param projectileNodeId number
---@return string saveName
function GetNodeProjectileSaveName(projectileNodeId)
        local s
        return s
end
---@type function
---@see NodePosition Built in function.
---@param nodeId number
---@return table position 
function NodePosition(nodeId)
        local pos
        return pos
end
---@type function
---@see Colour Built in function. Returns colour table
---@param r number
---@param g number
---@param b number
---@param a number
---@return table colour
function Colour(r, g, b, a)
        local c
        return c
end
---@type function
---@see Red Built in function. Returns red colour table
---@return table colour
function Red()
        local c
        return c
end
---@type function
---@see White Built in function. Returns white colour table
---@return table colour
function White()
        local c
        return c
end
---@type function
---@see Blue Built in function. Returns blue colour table
---@return table colour
function Blue()
        local c
        return c
end
---@type function
---@see Green Built in function. Returns green colour table
---@return table colour
function Green()
        local c
        return c
end
---@type function
---@see SetMissileTarget Built in function. Sets position which the missile will be targeted at
---@param projectileNodeId number
---@param pos table
function SetMissileTarget(projectileNodeId, pos)
end
---@type function
---@see NodeCount Built in function.
---@param teamId number
---@return number nodeCount
function NodeCount(teamId)
        local n
        return n
end
---@type function
---@see ProjectileCount Built in function.
---@param teamId number
---@return number projectileCount
function ProjectileCount(teamId)
        local n
        return n
end
---@type function
---@see GetNodeId Built in function. Returns global nodeId when given team nodeId
---@param teamId number
---@param teamNodeId number
---@return number nodeId
function GetNodeId(teamId, teamNodeId)
        local id
        return id
end
---@type function
---@see GetProjectileId Built in function. Returns global nodeProjectileId when given team nodeProjectileId
---@param teamId number
---@param teamNodeProjectileId number
---@return number nodeProjectileId
function GetProjectileId(teamId, teamNodeProjectileId)
        local id
        return id
end
---@type function
---@see NodeExists  Built in function.
---@param nodeId number
---@return boolean doesExist
function NodeExists(nodeId)
        local b
        return b
end
---@type function
---@see GetNodeProjectileType Built in function. See types in forts.lua
---@param nodeid number
---@return number type
function GetNodeProjectileType(nodeid)
        local n
        return n
end
---@type function
---@see ButtonSprite Built in function. Creates a button sprite
---@param name string
---@param path string
---@param size number
---@param size2 number
function ButtonSprite(name, path, size--[[?]], size2--[[?]])
end
---@type table
---@see data Table which is being synced between players. Use for storing variables and clear on OnReset
data = {}
---@type string
---@see path String which consist of an actual path to the mod's folder. Example of usage: path .. "/scripts/utils.lua"
path = ""
---@type table
---@see ShootableProjectile Table of the projectiles which will be targeted by the AI anti-air
ShootableProjectile = {}
---@type number
---@see TEAM_1 Team one Id.
TEAM_1 = 1
---@type number
---@see TEAM_2 Team two Id.
TEAM_2 = 2
---@type string
---@see StandardDeviceSmokeEmitter Makes damaged devices smoke
StandardDeviceSmokeEmitter = ""


---@class Vec3
---@type function
---@see Vec3Length Built in function. Returns vector magnitude
---@param vector table
---@return number length
function Vec3Length(vector)
        local n
        return n
end
---@type function
---@see Vec3 Built in function. Returns vector table made out of 'x' and 'y' axes
---@param x number
---@param y number
---@return table vector
function Vec3(x, y)
        local vec
        return vec
end
---@type function
---@see Vec3Dot Built in function. Returns dot product of the two vectors
---@param x table
---@param y table
---@return number dot
function Vec3Dot(x, y)
        local n
        return n
end