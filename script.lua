---@class script
---@field path string

dofile("scripts/forts.lua")
dofile(path .. "/scripts/utils.lua")

dofile(path .. "/scripts/missiles.lua")

--[[
TODO

make missiles choose untargeted projectiles to spread the damage

GetNodesInSector returns countermeassurements and projectiles only, if it finds em

perhaps GetNodesInSector raycast targets to check visibility. Discard if not optimised

make debug stuff togglable 

starting working on the flying stuff

]]

function Load(gameStart)
        MissilesLoad(gameStart)
        --local t = GetEnemyTeams(1, false)
        --for index, v in ipairs(t) do
        --        Print(v)
        --end
end

function OnRestart()
        MissilesOnRestart()
end

function Update(frame)
        MissilesUpdate(frame)
end

function OnLinkCreated(teamId, saveName, nodeA, nodeB, pos1, pos2, extrusion)
        --local chance = GetRandomFloat(0.0, 1.0, "roll for decorative materials")
        --if chance < 0.5 then
        --        CreateLink(teamId, "armour", nodeA, nodeB)
        --else
        --        CreateLink(teamId, "door", nodeA, nodeB)
        --end
end

function OnWeaponFired(teamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)
        MakeSmartMissile(teamId, projectileNodeId)
end

function OnProjectileDestroyed(nodeId, teamId, saveName, structureIdHit, destroyType)
        DestroySmartMissile(nodeId)
end
