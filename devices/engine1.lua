ConstructEffect = "effects/device_construct.lua"
CompleteEffect = "effects/device_complete.lua"
Scale = 1.0
SelectionWidth = 40.0
SelectionHeight = 40.0
SelectionOffset = { 0.0, -40.5 }
Mass = 40.0
HitPoints = 100.0
EnergyProductionRate = 0.0
MetalProductionRate = 0.0
EnergyStorageCapacity = 2000.0
MetalStorageCapacity = 0.0
MinWindEfficiency = 1
MaxWindHeight = 0
MaxRotationalSpeed = 0
DeviceSplashDamage = 175
DeviceSplashDamageMaxRadius = 250
DeviceSplashDamageDelay = 0.2
IgnitePlatformOnDestruct = true
StructureSplashDamage = 60
StructureSplashDamageMaxRadius = 150
DestroyEffect = "effects/battery_explode.lua"
DestroyUnderwaterEffect = "mods/dlc2/effects/device_explode_submerged_small.lua"

dofile("effects/device_smoke.lua")
SmokeEmitter = StandardDeviceSmokeEmitter

--Sprites =
--{
--	{
--		Name = "battery_detail",
--
--		States =
--		{
--			Normal =
--			{
--				Frames =
--				{
--					{ texture = "devices/battery/battery01.dds" },
--					{ texture = "devices/battery/battery02.dds" },
--					{ texture = "devices/battery/battery03.dds" },
--					{ texture = "devices/battery/battery04.dds" },
--					{ texture = "devices/battery/battery05.dds" },
--					{ texture = "devices/battery/battery06.dds" },
--					{ texture = "devices/battery/battery07.dds" },
--					{ texture = "devices/battery/battery08.dds" },
--					{ texture = "devices/battery/battery09.dds" },
--
--					duration = 0.06,
--					blendColour = false,
--					blendCoordinates = false,
--					mipmap = true,
--				},
--				NextState = "Normal",
--			},
--		},
--	},
--	{
--		Name = "battery-base",
--		States =
--		{
--			Normal = { Frames = { { texture = "devices/battery/base.dds" }, mipmap = true, }, },
--		},
--	},
--}

NodeEffects =
{
	{
		NodeName = "Head",
		EffectPath = "effects/battery_ambient.lua",
	},
}

Root =
{
	Name = "Battery",
	Angle = 0,
	Pivot = { 0, -0.235 },
	PivotOffset = { 0, 0 },
	Sprite = "battery-base",
	
	ChildrenInFront =
	{
		{
			Name = "Head",
			Angle = 0,
			Pivot = { 0, 0 },
			PivotOffset = { 0, 0 },
			Sprite = "battery_detail",
			UserData = 50,
		},
	},
}
