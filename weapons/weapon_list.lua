function IndexOfWeapon(saveName)
	for k,v in ipairs(Weapons) do
		if v.SaveName == saveName then
			return k
		end
	end
	return #Weapons
end


table.insert(Weapons, IndexOfWeapon("sniper") + 1 ,
        {
                Enabled = true,
                SaveName = "HighFlight_antiair1",
                FileName = path .. "/weapons/missiles/antiair1.lua",
                Icon = "hud-snipertower-icon",
                GroupButton = "hud-group-sniper",
                Detail = "hud-detail-sniper",
                Prerequisite = "",
                BuildTimeComplete = 5.0,
                ScrapPeriod = 5,
                MetalCost = 1500,
                EnergyCost = 5000,
                MetalRepairCost = 40,
                EnergyRepairCost = 200,
                MetalReclaimMin = 0,
                MetalReclaimMax = 0,
                EnergyReclaimMin = 0,
                EnergyReclaimMax = 500,
                SpotterFactor = 0,
                MaxSpotterAssistance = 0.1, -- small benefit from other spotters
                MaxUpAngle = 45,
                BuildOnGroundOnly = false,
                DrawBlurredProjectile = true,
                RequiresSpotterToFire = false,
                --AlignToCursorNormal = false,
                SelectEffect = "ui/hud/weapons/ui_weapons",

                Upgrades =
                {
                        --{
                        --        Enabled = true,
                        --        SaveName = "jump_drive",
                        --        MetalCost = 0,
                        --        EnergyCost = 0,
                        --        Button = "jumpdrive_button_green_upgrade",
                        --},
                }
        })
