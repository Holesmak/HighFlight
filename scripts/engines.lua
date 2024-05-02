dofile(path .. "/scripts/engines_config.lua")

function EnginesLoad(gameStart)
        data.engines = {}
        ----data.changePosTasks = {}
        data.commands = {}
end

function EnginesOnRestart()
        data.engines = {}
        ----data.changePosTasks = {}
        data.commands = {}
end

function EnginesUpdate(frame, allNodes)
        ----FloatThrust(frame)
        ----ChangePosAll(frame)
        for i, v in pairs(data.engines) do
                local radiusNodes = FindNodesOnStructureInRadius(allNodes, GetDevicePosition(i), 50, GetDeviceStructureId(i))
                
        end




        ----local debugforce = 0
        ----for i, v in pairs(data.engines) do
        ----        debugforce = debugforce + Vec3Length(v.currentForce)
        ----end
        ------Print(debugforce / 100000)

        ----local debugtasks = 0
        ----for i, v in pairs(data.changePosTasks) do
        ----        debugtasks = debugtasks + 1
        ----end
        ------Print(debugtasks)

        ----for i, v in pairs(data.engines) do
        ----        SpawnCircle(v.setPos, 20, Blue(), 0.05)
        ----        SpawnCircle(v.setPosB, 20, Red(), 0.05)
        ----end
end

function FindNodesOnStructureInRadius(allNodes, pos, radius, structureId)
        
end

----function OnKey(key, down)
----        if key == "h" and down then
----                local result = ScreenToWorld(GetMousePos())
----                --SendScriptEvent("TestH", tostring(result.x) .. "," .. tostring(result.y), "", true)
----                if GetLocalSelectedDeviceId() > -1 then
----                        local id = GetLocalSelectedDeviceId()
----                        SendScriptEvent("SetPosByCommandId", "Vec3" .. tostring(result) .. "," .. id .. "," .. GetDeviceAngle(id), "", true)
----                end
----        end
----end

----function FloatThrust(frame)
----        for i, v in pairs(data.engines) do
----                local node = GetDevicePlatformA(i)
----                local nodepos = NodePosition(node)
----
----                local nodeb = GetDevicePlatformB(i)
----                local nodeposb = NodePosition(nodeb)
----                local linkLength = Vec3Length(nodepos - nodeposb)
----
----                v.setPosB = AngleToVector(v.Rotation - 90, linkLength) + v.setPos
----
----                local error = v.setPos - nodepos
----                local errorB = v.setPosB - nodeposb
----
----                if v.lastError == nil then
----                        v.lastError = error                 
----                end
----                if v.lastErrorB == nil then
----                        v.lastErrorB = errorB            
----                end
----
----                --local forceincrement = nodevelocity.y * ENGINES_VELOCITY_MUL + acceleration.y * ENGINES_ACCELERATION_MUL
----                --v.currentForce = v.currentForce + forceincrement
----                --dlc2_ApplyForce(node, Vec3(0, math.max(-math.min(v.currentForce, 30 * 100000)), 0)) -- limit
----
----                local forceX, Ix = PID(error.x, v.lastError.x, 50, 0, 1000, data.updateDelta, v.iComponentX)
----                local forceY, Iy = PID(error.y, v.lastError.y, 1000, 400--[[400]], 1000--[[1000]], data.updateDelta, v.iComponentY)
----
----                local forceXB, Ixb = PID(errorB.x, v.lastErrorB.x, 50, 0, 1000, data.updateDelta, v.iComponentXB)
----                local forceYB, Iyb = PID(errorB.y, v.lastErrorB.y, 1000, 400--[[400]], 1000--[[1000]], data.updateDelta, v.iComponentYB)
----                --Print(I)
----                local force = Vec3(math.max(math.min(forceX, 100000), -100000), math.max(math.min(forceY, 0), -5000000))
----                local forceb = Vec3(math.max(math.min(forceXB, 100000), -100000), math.max(math.min(forceYB, 0), -5000000))
----                --local force = Vec3Limit(Vec3(forceX, forceY), 5000000)
----                v.currentForce = force
----                v.currentForceB = forceb
----                dlc2_ApplyForce(node, force)
----                dlc2_ApplyForce(nodeb, forceb)
----                v.iComponentX = Ix
----                v.iComponentY = Iy
----                v.iComponentXB = Ixb
----                v.iComponentYB = Iyb
----                
----                v.lastError = error
----                v.lastErrorB = errorB
----        end
----end

----function SetPosById(id, pos, angle)
----        for i, v in pairs(data.engines) do
----                if i == id then
----                        data.changePosTasks[i] = {
----                                targetPos = pos
----                        }
----                        v.Rotation = ConvertAngleToNormal(angle)
----                end
----        end
----end

-----@param angle number Takes Forts rotation values
----function SetPosByCommandId(pos, id, angle)
----        local currentAngle = GetDeviceAngle(id)
----        local command = data.commands[id]
----
----        command.setPos = pos
----        if command.engines == nil then
----                command.engines = {}
----        end
----
----        command.rotation = currentAngle
----        local angleDif = angle - currentAngle
----        local commandPos = NodePosition(GetDevicePlatformA(id))
----        local engines = {}
----
----        for i, v in pairs(data.engines) do -- checks if engine is on the same structure -- it also calculates relative pos. MAKE IT SO IT DOESNT DO THAT WHILE ROTATING
----                if GetDeviceStructureId(id) == GetDeviceStructureId(i) then
----                        table.insert(engines, i, NodePosition(GetDevicePlatformA(i)) - commandPos)
----                end
----        end
----
----        for i, v in pairs(engines) do --sets engines pos and rot. calculates relative transform
----                if command.engines[i] == nil then
----                        command.engines[i] = {}
----                end
----                if command.engines[i].engineRotation == nil then
----                        command.engines[i].engineRotation = GetDeviceAngle(i) + angleDif
----                end
----                if command.engines[i].relativePos == nil then
----                        command.engines[i].relativePos = Rotate(v ,angleDif)
----                end
----                SetPosById(i, command.engines[i].relativePos + pos, command.engines[i].engineRotation)
----        end
----end

----function RotateCommand(weaponId, projectileNodeId)
----        if data.commands[weaponId].engines then
----                for i, v in pairs(data.commands[weaponId].engines) do
----                        if v.engineRotation then
----                                v.engineRotation = nil
----                        end
----                        --if v.relativePos then
----                        --        v.relativePos = nil
----                        --end
----                end
----        end
----        SetPosByCommandId(data.commands[weaponId].setPos, weaponId, ConvertAngleToForts(GetVectorAngle(Vec3Nor(NodeVelocity(projectileNodeId))) + 90))
----end

----function ChangePosAll(frame) -- FIX THAT
----        for i, v in pairs(data.changePosTasks) do
----                if not DeviceExists(i) then
----                        data.changePosTasks[i] = nil
----                        continue
----                end
----                local setpos = data.engines[i].setPos
----                local error = v.targetPos - setpos
----                if Vec3Length(error) < ENGINES_CHANGEPOS_SPEED then
----                        data.changePosTasks[i] = nil
----                        continue
----                end
----
----                local errorX = math.max(math.min(error.x, ENGINES_CHANGEPOS_SPEED * 1000), -ENGINES_CHANGEPOS_SPEED * 1000)
----                local errorY = math.max(math.min(error.y, ENGINES_CHANGEPOS_SPEED), -ENGINES_CHANGEPOS_SPEED)
----                data.engines[i].setPos = setpos + Vec3(errorX, errorY)
----        end
----end

--function ResetHeight(deviceId)
--        local node = GetDevicePlatformA(deviceId)
--        local engine = data.engines[deviceId]
--        local nodevelocity = NodeVelocity(node)
--        local acceleration
--        if engine.lastVelocity then
--                acceleration = nodevelocity - engine.lastVelocity
--        else
--                acceleration = Vec3(0, 0)
--        end
--        acceleration = nodevelocity - engine.lastVelocity
--        engine.currentForce = nodevelocity.y * ENGINES_VELOCITY_MUL + acceleration.y * ENGINES_ACCELERATION_MUL
--end

function MakeEngine(teamId, deviceId, saveName)
        if AnyOf(ENGINES_SAVENAMES, saveName) then
                local v = { saveName = saveName, teamId = teamId }

                if v.Rotation == nil then
                        v.Rotation = ConvertAngleToNormal(GetDeviceAngle(deviceId))
                end
                if v.setPos == nil then --MOVE ALL THIS TO MAKE ENGINE
                        v.setPos = NodePosition(GetDevicePlatformA(deviceId))
                end
                if v.iComponentX == nil then
                        v.iComponentX = 0
                end
                if v.iComponentY == nil then
                        v.iComponentY = 0
                end
                if v.iComponentX == nil then
                        v.iComponentXB = 0
                end
                if v.iComponentY == nil then
                        v.iComponentYB = 0
                end

                data.engines[deviceId] = v
        end
end

function MakeCommand(teamId, deviceId, saveName)
        if AnyOf(COMMANDS_SAVENAMES, saveName) then
                data.commands[deviceId] = { saveName = saveName--[[, teamId = teamId, setPos = NodePosition(GetDevicePlatformA(deviceId))]] }
        end
end

function DestroyEngine(teamId, deviceId, saveName, nodeA, nodeB, t)
        for i, v in pairs(data.engines) do
                if i == deviceId then
                        data.engines[i] = nil
                end
        end
end

function DestroyCommand(teamId, deviceId, saveName, nodeA, nodeB, t)
        for i, v in pairs(data.commands) do
                if i == deviceId then
                        data.commands[i] = nil
                end
        end
end
