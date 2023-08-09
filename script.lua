dofile("scripts/forts.lua")
dofile(path .. "/scripts/utils.lua")

dofile(path .. "/scripts/missiles.lua")

--[[
TODO

make missiles choose untargeted projectiles to spread the damage

GetNodesInSector returns countermeassurements and projectiles only, if it finds em

perhaps GetNodesInSector raycast targets to check visibility. Discard if not optimised

add guidance delay

missiles fuel runs out and it transforms to a missile without thrust power and thrusting effects (if it works good)

make other types of guidance (beam riding, TV(mouse), infrared(devices)) to use less radar(nodes) missiles and cause less lag

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

        --for i = 0, GetWeaponCount(1), 1 do --THE AMMO SYSTEM
        --        SetWeaponReloadTime(GetWeaponId(1, i), GetWeaponReloadTime(GetWeaponId(1, i)) - 0.001)
        --end


        --local tEmp = GetRandomFloat(5.0, 10.0, "how long will emp last") --THE GENERATORS SYSTEM
        --for i = 0, GetWeaponCount(1), 1 do
        --        if IsDeviceFullyBuilt(GetWeaponId(1, i)) then
        --                EMPDevice(GetWeaponId(1, i), tEmp)
        --        end
        --end
end

function OnLinkCreated(teamId, saveName, nodeA, nodeB, pos1, pos2, extrusion)
        --local chance = GetRandomFloat(0.0, 1.0, "roll for decorative materials") -- THE MATERIAL DECORATIONS SYSTEM
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
