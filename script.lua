dofile("scripts/forts.lua")
dofile(path .. "/scripts/BetterLog.lua")
dofile(path .. "/scripts/utils.lua")

dofile(path .. "/scripts/missiles.lua")
dofile(path .. "/scripts/engines.lua")

--[[
TODO

missile comments

utils comments

ENGINE CONFIG COMMENTS

MOVE COMMAND DEVICE TO WEAPONS AND MAKE IT SHOOT PROJECTILE WHICH ARE USED TO ROTATE IT

fix angle finding if X = 0

make missiles choose untargeted projectiles to spread the damage

GetNodesInSector returns countermeassurements and projectiles only, if it finds em

perhaps GetNodesInSector raycast targets to check visibility. Discard if not optimised

add guidance delay

missiles fuel runs out and it transforms to a missile without thrust power and thrusting effects (if it works good)

make other types of guidance (beam riding, TV(mouse), infrared(devices)) to use less radar(nodes) missiles and cause less lag

make debug stuff togglable

WORK ON PID AND FLOATING. MOVE PID VALUES TO CONFIG FILE AS A TABLE OF CONSTANTS

MAKE CHANGING OF ALTITUDE BE SMOOTH BY SMOOTHING P (OR I THINK THIS MIGHT BE THE CASE TOO: RESETING LAST ERROR TO SMOOTH OUT D) (ANOTHER SOLUTION IS TO SMOOTH OUT PID OUTPUT RATHER THAN ITS COMPONENTS. MIGHT BE INACCURATE)

CALIBRATE ENGINE HORIZONTAL MOVEMENT

MAKE RECALCULATE POSITIONS BUTTON AND ALSO MAKE IT SO COMMAND MODULE STORES RELATIVE POSITIONS TO PREVIOUSLY CONTROLLED ENGINES AND RECALCULATES IT ONCE THEY WERE DISCONECTED FROM THE STRUCTURE

to consider tractor beams \ fields (people playground)
]]

function Load(gameStart)
        data.worldGravity = GetConstant("Physics.Gravity")
        data.normalGravity = 981
        InnitialiseAdditionalConfig()
        MissilesLoad(gameStart)
        EnginesLoad(gameStart)
        --local t = GetEnemyTeams(1, false)
        --for index, v in ipairs(t) do
        --        Print(v)
        --end
end

function OnRestart()
        data.worldGravity = GetConstant("Physics.Gravity")
        data.normalGravity = 981
        InnitialiseAdditionalConfig()
        MissilesOnRestart()
        EnginesOnRestart()
end

function Update(frame)
        --local success,allNodes = pcall( GetAllNodes )
        local allNodes = GetAllNodes()
        --allNodes = GetStructureAllNodes(allNodes, 1)

--        if success then 
--
--                local successMissiles,outcome = pcall( MissilesUpdate, frame, allNodes )
--                if not successMissiles then Print("Error: "..outcome) end
--
--                EnginesUpdate(frame, allNodes)
--        else Print("Error: "..allNodes) end
        --local success,outcome = pcall(DebugShowAllNodes,allNodes)
        --if not success then Print("Error: "..outcome) end

        TestCall(DebugShowAllNodes,allNodes)

        MissilesUpdate(frame, allNodes)

        --local vectest = Vec3(2343243,-234342)
        --local before = GetRealTime()
        --for i = 1, 100000, 1 do
        --        Vec3CheapLength(vectest)
        --end
        --local after = GetRealTime()
        --Print((after - before) / data.updateDelta)

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
        --MakeSmartMissile(teamId, projectileNodeId, saveName, weaponId, projectileNodeIdFrom)
        local successMissiles,outcome = pcall( MakeSmartMissile, teamId, projectileNodeId, saveName, weaponId, projectileNodeIdFrom )
        if not successMissiles then Print("Error: "..outcome) end
        --RotateCommand(weaponId, projectileNodeId) --FIXTHAT
end

function OnProjectileDestroyed(nodeId, teamId, saveName, structureIdHit, destroyType)
        DestroySmartMissile(nodeId)
end

function OnDeviceCompleted(teamId, deviceId, saveName)
        MakeEngine(teamId, deviceId, saveName)
        MakeCommand(teamId, deviceId, saveName)
end

function OnDeviceDestroyed(teamId, deviceId, saveName, nodeA, nodeB, t)
        DestroyEngine(teamId,deviceId,saveName,nodeA,nodeB, t)
        DestroyCommand(teamId,deviceId,saveName,nodeA,nodeB, t)
end

function OnDeviceDeleted(teamId, deviceId, saveName, nodeA, nodeB, t)
        DestroyEngine(teamId,deviceId,saveName,nodeA,nodeB, t)
        DestroyCommand(teamId,deviceId,saveName,nodeA,nodeB, t)
end

function GetAllNodes()
        local allNodes = {}
        allNodes.sidesStructures = {}
        for i = 0, GetStructureCount() - 1, 1 do --iterate structures
                local structureId = GetStructureId(i)
                local structureSide = GetSide(GetStructureTeam(structureId))
                if allNodes.sidesStructures[structureSide] == nil then
                        allNodes.sidesStructures[structureSide] = {}
                end
                allNodes.sidesStructures[structureSide][structureId] = {}
                allNodes.sidesStructures[structureSide][structureId].nodes = {}
                allNodes.sidesStructures[structureSide][structureId].isInWater = GetStructureInWater(structureId)
                allNodes.sidesStructures[structureSide][structureId].isOnLand = GetStructureOnLand(structureId)
                allNodes.sidesStructures[structureSide][structureId].radius = GetStructureRadius(structureId)
                allNodes.sidesStructures[structureSide][structureId].position = GetStructurePositionAccurate(Vec3(1000000, 1000000), structureId, nil, allNodes.sidesStructures[structureSide][structureId].radius)
                allNodes.sidesStructures[structureSide][structureId].teamId = GetStructureTeam(structureId)
        end

        allNodes.nodes = {}
        for side, _ in pairs(allNodes.sidesStructures) do --iterate nodes
                for i = 0, NodeCount(side) - 1, 1 do
                        local nodeId = GetNodeId(side, i)
                        if NodeExists(nodeId) then
                                local nodeStructureId = NodeStructureId(nodeId)
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
--
        allNodes.sideProjectiles = {}
        allNodes.sideProjectiles[-3] = {}
        allNodes.sideProjectiles[-2] = {}
        allNodes.sideProjectiles[-1] = {}
        allNodes.sideProjectiles[0] = {}
        allNodes.sideProjectiles[1] = {}
        allNodes.sideProjectiles[2] = {}
--
        for side, _ in pairs(allNodes.sideProjectiles) do --iterate projectiles
                for i = 0, ProjectileCount(side) - 1, 1 do
                        local nodeId = GetProjectileId(side, i)
                        local type = GetNodeProjectileType(nodeId)
                        if type ~= 0 and AnyOf(SMARTMISSILE_ALLOWED_PROJECTILES, type) then
                                if NodeExists(nodeId) then    
                                        allNodes.sideProjectiles[side][nodeId] = {}
                                        allNodes.sideProjectiles[side][nodeId].position = NodePosition(nodeId)
                                        allNodes.sideProjectiles[side][nodeId].velocity = NodeVelocity(nodeId)
                                        allNodes.sideProjectiles[side][nodeId].type = type
                                end
                        end
                end
        end

        return allNodes
end

function DebugShowAllNodes(allNodes)
        --local test = 0
        --local testSide = 0
        --local testStrucure = 0
        --local testNodeId = 0
        --local testtable = {}
        --local testPosition
        for side, sideTable in pairs(allNodes.sidesStructures) do
                --Print(side)
                for structureId, structure in pairs(sideTable) do
                        local radius = allNodes.sidesStructures[side][structureId].radius
                        local pos = allNodes.sidesStructures[side][structureId].position
                        SpawnCircle(pos, radius, Colour(255, 255, 100, 255), 0.1)
                        for nodeId, node in pairs(structure.nodes) do
                                if true then
                                        --test = test + 1
                                        --testSide = side
                                        --testStrucure = structureId
                                        --testNodeId = nodeId
                                        --testtable[side] = sideTable
                                        --testtable[side][structureId] = structure
                                        --testtable[side][structureId][nodeId] = node

                                        --SpawnCircle(node.position, 20, Colour(255, 255, 100, 255), 0.1)

                                        --testPosition = node.position
                                end
                        end
                end
        end

        if allNodes.sideProjectiles then
                for side, sideTable in pairs(allNodes.sideProjectiles) do
                        for projectileId, projectile in pairs(sideTable) do
                                SpawnCircle(projectile.position, 20, Colour(0, 255, 100, 255), 0.1)
                        end
                end
        end

        --SpawnCircle(allNodes.sidesStructures[1][1][1].velocity, 50, Colour(255, 255, 100, 255), 0.1)
        --SpawnCircle(node.position, 50, Colour(255, 255, 100, 255), 0.1)
        --Print(testSide .. "  side")
        --Print(testStrucure .. "    strucure Id")
        --Print(testNodeId .. "    node Id")
        --Print(test .. " Count")
        --BetterLog(allNodes.sidesStructures[98])
        --BetterLog(testtable)
        --Print(test)
end