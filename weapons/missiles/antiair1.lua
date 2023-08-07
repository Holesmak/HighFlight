Scale = 1
SelectionWidth = 70.0
SelectionHeight = 45
SelectionOffset = { -40.0, -45.5 }
RecessionBox =
{
        Size = { 200, 25 },
        Offset = { -300, -50 },
}

WeaponMass = 40.0
HitPoints = 30.0
EnergyProductionRate = 0.0
MetalProductionRate = 0.0
EnergyStorageCapacity = 0.0
MetalStorageCapacity = 0.0
MinWindEfficiency = 1
MaxWindHeight = 0
MaxRotationalSpeed = 0

FireEffect = "effects/sniper_flash.lua"
ConstructEffect = "effects/device_construct.lua"
CompleteEffect = "effects/device_complete.lua"
DestroyEffect = "effects/sniper_explode.lua"
DestroyUnderwaterEffect = "mods/dlc2/effects/device_explode_submerged_small.lua"
ShellEffect = "effects/shell_eject_sniper.lua"
ReloadEffect = "effects/sniper_reload.lua"
ReloadEffectOffset = -.5
Projectile = "HighFlight_antiair1"
BarrelLength = 10.0
MinFireClearance = 500
FireClearanceOffsetInner = 20
FireClearanceOffsetOuter = 40
ReloadTime = 2.8
ReloadTimeIncludesBurst = false
MinFireSpeed = 500.0
MaxFireSpeed = 500.1
MinFireRadius = 600.0
MaxFireRadius = 1560.0
MinVisibility = 0.3
MaxVisibilityHeight = 1000
MinFireAngle = -50
MaxFireAngle = 60
KickbackMean = 35
KickbackStdDev = 7
MouseSensitivityFactor = 0.6
PanDuration = 0
FireStdDev = 0.001
FireStdDevAuto = 0.004
Recoil = 50000
EnergyFireCost = 30.0
MetalFireCost = 0

--RoundsEachBurst = 1
--RoundPeriod = 0.5
--BeamDuration = 0.05

CanOverheat = true
HeatPeriod = 0.15
CoolPeriod = 99999
CoolPeriodOverheated = 7

NodeEffects =
{
	{
		NodeName = "Hardpoint0",
		EffectPath = "effects/weapon_overheated.lua",
		Automatic = false,
	},
}

ShowFireAngle = true

LaserScale = 1.2
LaserSightSolid = "laser_sight"
LaserSightDashed = "laser_sight_dashed"

dofile("effects/device_smoke.lua")
SmokeEmitter = StandardDeviceSmokeEmitter

-- Sprites =
-- {
        -- {
                -- Name = "snipertower-base",
                -- States =
                -- {
                        -- Normal = { Frames = { { texture = "weapons/snipertower/base.png" }, mipmap = true, }, },
                        -- Idle = Normal,
                -- },
        -- },
        -- {
                -- Name = "snipertower-head",
                -- States =
                -- {
                        -- Normal = { Frames = { { texture = "weapons/snipertower/barrel.png" }, mipmap = true, }, },
                        -- Idle = Normal,
                -- },
        -- },
        -- {
                -- Name = "snipertower-arm",
                -- States =
                -- {
                        -- Normal = {
                                -- Frames = { { texture = "weapons/snipertower/Sniper-ReloadAnim01.dds" }, mipmap = true, }, },
                        -- Idle = Normal,
                        -- Reload =
                        -- {
                                -- Frames =
                                -- {
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim01.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim02.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim03.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim04.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim05.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim06.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim07.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim08.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim09.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim10.dds", duration = 120 },
                                        -- mipmap = true,
                                        -- duration = 0.1,
                                -- },
                        -- },
                        -- ReloadEnd =
                        -- {
                                -- Frames =
                                -- {
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim11.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim12.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim13.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim14.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim15.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim16.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim17.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim18.dds" },
                                        -- { texture = "weapons/snipertower/Sniper-ReloadAnim19.dds" },
                                        -- mipmap = true,
                                        -- duration = 0.1,
                                -- },
                                -- NextState = "Normal",
                        -- },
                -- },
        -- },
-- }

Root =
{
        Name = "Sniper",
        Angle = 0,
        Pivot = { 0.25, -0.55 },
        PivotOffset = { 0, 0 },
        Sprite = "snipertower-base",
        UserData = 0,

        ChildrenInFront =
        {
                {
                        Name = "Head",
                        Angle = 0,
                        Pivot = { -0.25, -0.1 },
                        PivotOffset = { 0.25, 0.05 },
                        Sprite = "snipertower-head",
                        UserData = 50,

                        ChildrenInFront =
                        {
                                {
                                        Name = "Arm",
                                        Angle = 0,
                                        Pivot = { -0.185, -0.08 },
                                        Sprite = "snipertower-arm",
                                        PivotOffset = { 0, 0 },
                                        UserData = 100,
                                },
                                {
                                        Name = "Hardpoint0",
                                        Angle = 90,
                                        Pivot = { -0.17, -0.15 },
                                        PivotOffset = { 0, 0 },
                                },
                                {
                                        Name = "LaserSight",
                                        Angle = 90,
                                        Pivot = { -0.04, -0.2 },
                                        PivotOffset = { 0, 0 },
                                },
                                {
                                        Name = "Chamber",
                                        Angle = 0,
                                        Pivot = { -0.17, -0.15 },
                                        PivotOffset = { 0, 0 },
                                },
                        },
                },
        },
}
