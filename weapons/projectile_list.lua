function MakeNoFuelMissile(missileSaveName, fuelTime, flameoutEffect, turnToMortar, gravity, drag, maxAge, trailEffect, steerPerSecondMultiplier, rocketThrustMultiplier, thrustExtentMultiplier, rocketThrustChangeMultiplier)
        if gravity == nil then
                gravity = 980
        end
        if drag == nil then
                drag = 0
        end
        if maxAge == nil then
                maxAge = 10000000
        end
        if trailEffect == nil then
                trailEffect = "effects/sniper_trail.lua"
        end
        if flameoutEffect == nil then
                flameoutEffect = "effects/bullet_sandbag_hit.lua"
        end

        local projectile = FindProjectile(missileSaveName)
        local sufix = "_StageNoFuel"

        local nofuelProjectile = DeepCopy(projectile)
	nofuelProjectile.SaveName = missileSaveName .. sufix

	if turnToMortar then
		nofuelProjectile.ProjectileType = "mortar"
                nofuelProjectile.Missile = nil
        else
                nofuelProjectile.Missile.RocketThrust = nofuelProjectile.Missile.RocketThrust * rocketThrustMultiplier
                nofuelProjectile.Missile.RocketThrustChange = nofuelProjectile.Missile.RocketThrust * rocketThrustChangeMultiplier
                nofuelProjectile.Missile.ThrustAngleExtent = nofuelProjectile.Missile.ThrustAngleExtent * thrustExtentMultiplier
                nofuelProjectile.Missile.RocketThrustChange = 0.000001
                nofuelProjectile.Missile.MaxSteerPerSecond = nofuelProjectile.Missile.MaxSteerPerSecond * steerPerSecondMultiplier
                nofuelProjectile.Missile.ErraticThrust = 0
	end

        nofuelProjectile.ProjectileDrag = drag
        nofuelProjectile.Gravity = gravity
        nofuelProjectile.MaxAge = maxAge
        nofuelProjectile.ProjectileShootDownRadius = nofuelProjectile.ProjectileThickness
        nofuelProjectile.TrailEffect = trailEffect

        for key, value in pairs(nofuelProjectile.Projectile.Root.ChildrenInFront) do
                if value.Name == "Flame" then
                        nofuelProjectile.Projectile.Root.ChildrenInFront[key] = nil
                end
        end
        
        if projectile then
                if projectile.Effects.Age == nil then
                        projectile.Effects.Age = {}
                end
                projectile.Effects.Age["t"..fuelTime] = { Effect = flameoutEffect, Projectile = { Count = 1, Type = missileSaveName .. sufix, StdDev = 0 }, Splash = false, Terminate = true, KeepLifespan = true, KeepHitpointLoss = true, KeepAge = true, PosT = 1, Offset = 0 }
        end

        table.insert(Projectiles, nofuelProjectile)

        return nofuelProjectile
end

table.insert(Sprites,
{
        Name = "SmartMissile1",

        States =
        {
                Normal =
                {
                        Frames =
                        {
                                { texture = path .. "/weapons/missiles/SmartMissile1/Missile1.tga"},
                                --{ texture = path .. "/effects/media/mortar04.dds", colour = { 1, 1, 1, 0.0 }, duration = 2 }, -- just makes a blank frame long enough to last the rest of the effect

                                --duration = 1.0,
                                blendColour = false,
                                blendCoordinates = false,
                                mipmap = false,
                        },
                        --RandomPlayLength = 2,
                        NextState = "Normal",
                },
        },
})

table.insert(Sprites,
{
        Name = "SM_Flame1",

        States =
        {
                Normal =
                {
                        Frames =
                        {
                                { texture = path .. "/weapons/missiles/Fires/Flame1/Flame11.tga"},
                                { texture = path .. "/weapons/missiles/Fires/Flame1/Flame12.tga"},
                                { texture = path .. "/weapons/missiles/Fires/Flame1/Flame13.tga"},
                                { texture = path .. "/weapons/missiles/Fires/Flame1/Flame14.tga"},
                                --{ texture = path .. "/effects/media/mortar04.dds", colour = { 1, 1, 1, 0.0 }, duration = 2 }, -- just makes a blank frame long enough to last the rest of the effect

                                duration = 0.05,
                                blendColour = false,
                                blendCoordinates = false,
                                mipmap = false,
                        },
                        --RandomPlayLength = 2,
                        NextState = "Normal",
                },
        },
})

table.insert(Sprites,
{
        Name = "SM_Flame2",

        States =
        {
                Normal =
                {
                        Frames =
                        {
                                { texture = path .. "/weapons/missiles/Fires/Flame2/Flame21.tga"},
                                { texture = path .. "/weapons/missiles/Fires/Flame2/Flame22.tga"},
                                { texture = path .. "/weapons/missiles/Fires/Flame2/Flame23.tga"},
                                { texture = path .. "/weapons/missiles/Fires/Flame2/Flame24.tga"},
                                --{ texture = path .. "/effects/media/mortar04.dds", colour = { 1, 1, 1, 0.0 }, duration = 2 }, -- just makes a blank frame long enough to last the rest of the effect

                                duration = 0.05,
                                blendColour = false,
                                blendCoordinates = false,
                                mipmap = false,
                        },
                        --RandomPlayLength = 2,
                        NextState = "Normal",
                },
        },
})

table.insert(Sprites,
{
        Name = "SM_Flame1Blink",

        States =
        {
                Normal =
                {
                        Frames =
                        {
                                { texture = path .. "/weapons/missiles/Fires/Flame1/Flame11.tga"},
                                { texture = path .. "/weapons/missiles/Fires/Flame1/Flame1Low.tga"},
                                { texture = path .. "/weapons/missiles/Fires/Flame1/Flame12.tga"},
                                { texture = path .. "/weapons/missiles/Fires/Flame1/Flame1Low.tga"},
                                { texture = path .. "/weapons/missiles/Fires/Flame1/Flame13.tga"},
                                { texture = path .. "/weapons/missiles/Fires/Flame1/Flame1Low.tga"},
                                { texture = path .. "/weapons/missiles/Fires/Flame1/Flame14.tga"},
                                { texture = path .. "/weapons/missiles/Fires/Flame1/Flame1Low.tga"},
                                --{ texture = path .. "/effects/media/mortar04.dds", colour = { 1, 1, 1, 0.0 }, duration = 2 }, -- just makes a blank frame long enough to last the rest of the effect

                                duration = 0.05,
                                blendColour = true,
                                blendCoordinates = false,
                                mipmap = false,
                        },
                        --RandomPlayLength = 2,
                        NextState = "Normal",
                },
        },
})

VerticalMissileLaunch = { Effect = "", --[[Projectile = { Count = 12, Type = "shrapnel", Speed = 4000, StdDev = 1.1 },]] Offset = 0, Terminate = false, Splash = false, PosT = 1}

table.insert(Projectiles,
{
	SaveName = "HighFlight_antiair1",

	ProjectileType = "missile",
	DrawBlurredProjectile = false,
	ProjectileMass = 5.0,
	ProjectileDrag = 10,
	DisableShields = true,
	DeflectedByShields = false,
	ExplodeOnTouch = true,

	Impact = 1000000,
	BeamTileRate = 0.02,
	BeamScrollRate = 0.0,
	ProjectileDamage = 3000.0,
	ProjectileSplashDamage = 200.0,
	ProjectileSplashDamageMaxRadius = 500.0,
	ProjectileSplashMaxForce = 15000000, --remove 0000
	SpeedIndicatorFactor = 0.05,

        ProjectileIncendiary = true,
        IncendiaryRadius = 800,
        AlwaysIncendiary = true,
        --IncendiaryRadiusHeated = ,
	--IncendiaryOffset = 0.5,

	AntiAirDamage = 600.0,
        AntiAirHitpoints = 1,
        CanBeShotDown = true,
        --FieldCreatesImpactProjectile = true,
        --FieldType = 4,
        --FieldRadius = 100,
        --FieldStrengthMax = 500000
        --FieldStrengthMin = 400000
        CollidesWithBeams = true,
        CollidesWithProjectiles = true,
        CollidesWithLike = true,
        MaxAge = 120,
	--EMPRadius = 150,
	--EMPOffset = 50,
	--EMPDuration = 10,
	--EMPSensitivity = 0,
	Gravity = 0,
	IgnitesBackgroundMaterials = true,
	IgnitesBackgroundMaterialsPassing = true,
	IgnitesBackgroundMaterialsPassingSource = false,

        CollisionLookaheadDist = 5,--если есть что то спереди сразу колизится с ним как я понял
	ProjectileThickness = 4.0, --хитбокс настоящий
	ProjectileShootDownRadius = 50, --хитбокс по сути, реагирует на другие проджектайлы
	ProjectileShootDownRadiusBeamWidth = 5,--хз, не колизит с другими проджектайлами или физическими обьектами

	-- example usage
	--MaxAgeUnderwater = 3,
	--UnderwaterFadeDuration = 0.5,

	Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = "SmartMissile1",
			Pivot = { 0, 0 },
                        Scale = 0.3,

			ChildrenInFront =
			{
				{
					Name = "Flame",
					Angle = 0,
					Offset = { 0, 1.25 },
					Pivot = { 0, 0.1 },
					PivotOffset = { 0, 0 },
                                        Scale = 4,
                                        Sprite = "missile_tail",
				},
			},
		}
	},

	TrailEffect = path .. "/effects/SmartMissileTrail.lua",

	Missile =
	{
		ThrustAngleExtent = 30.0001, -- влияет на виляние, физическое увеличение скорости поворота, вызывает раскачивание при больших значениях
		ErraticAngleExtentStdDev = 0.000001,
		ErraticAngleExtentMax = 0.000001,
		MaxSteerPerSecond = 1000000000, --советовали держать 1\10 от скорости, сколько раз в секунду меняется скорость поворота, лучше чтобы было 100х-1000х от thrustangleextent и держать соотношение, чем больше, тем выше точность
		MaxSteerPerSecondErratic = 0.000001, -- возможно количество раз в секунду смены курса виляния
		ErraticAnglePeriodMean = 0.000001, -- наверное имеет дело к вилянию
		ErraticAnglePeriodStdDev = 0.000001, -- наверное рандомизация виляния
		RocketThrust = 100000, -- сила ускорения
		RocketThrustChange = 0.000001, -- изменение силы со временем
		ErraticThrust = 0, -- тряска, смена курса, вроде
		CruiseTargetDistance = 0.00001, --не делает ничего
		CruiseTargetDuration = 0.00001, -- не делает ничего
		TargetRearOffsetDistance = 0.000001, -- расстояние точки в которую будет целиться ракета за текущей целью от текущей цели, если из-за нижнего параметра прицеливание сбросится
		MinTargetUpdateDistance = 0.000001, --отмена трекинга при приближении. Не работает если постоянно ставишь трекинг
	},

	DamageMultiplier =
	{
		--{ SaveName = "shield", Direct = 0, Splash = 0.5 },
	},

	Effects =
	{
		Impact =
		{
			["default"] = path .. "/effects/ExplosionBig1.lua",
                        ["antiair"] = path .. "/effects/ExplosionBig1.lua",
                        ["foundations"] = path .. "/effects/ExplosionBig1.lua",
                        ["rocks01"] = path .. "/effects/ExplosionBig1.lua",
		},
		Deflect =
		{
		},
	},
})

table.insert(Projectiles,
{
	SaveName = "HighFlight_verticalMissile1",

	ProjectileType = "missile",
	DrawBlurredProjectile = false,
	ProjectileMass = 5.0,
	ProjectileDrag = 10,
	DisableShields = true,
	DeflectedByShields = false,
	ExplodeOnTouch = true,

	Impact = 1000000,
	BeamTileRate = 0.02,
	BeamScrollRate = 0.0,
	ProjectileDamage = 3000.0,
	ProjectileSplashDamage = 200.0,
	ProjectileSplashDamageMaxRadius = 500.0,
	ProjectileSplashMaxForce = 15000000, --remove 0000
	SpeedIndicatorFactor = 0.05,

        ProjectileIncendiary = true,
        IncendiaryRadius = 800,
        AlwaysIncendiary = true,
        --IncendiaryRadiusHeated = ,
	--IncendiaryOffset = 0.5,

	AntiAirDamage = 600.0,
        AntiAirHitpoints = 1,
        CanBeShotDown = true,
        --FieldCreatesImpactProjectile = true,
        --FieldType = 4,
        --FieldRadius = 100,
        --FieldStrengthMax = 500000
        --FieldStrengthMin = 400000
        CollidesWithBeams = true,
        CollidesWithProjectiles = true,
        CollidesWithLike = true,
        MaxAge = 120,
	--EMPRadius = 150,
	--EMPOffset = 50,
	--EMPDuration = 10,
	--EMPSensitivity = 0,
	Gravity = 980,
	IgnitesBackgroundMaterials = true,
	IgnitesBackgroundMaterialsPassing = true,
	IgnitesBackgroundMaterialsPassingSource = false,

        CollisionLookaheadDist = 5,--если есть что то спереди сразу колизится с ним как я понял
	ProjectileThickness = 4.0, --хитбокс настоящий
	ProjectileShootDownRadius = 50, --хитбокс по сути, реагирует на другие проджектайлы
	ProjectileShootDownRadiusBeamWidth = 5,--хз, не колизит с другими проджектайлами или физическими обьектами

	-- example usage
	--MaxAgeUnderwater = 3,
	--UnderwaterFadeDuration = 0.5,

	Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = "warhead",
			Pivot = { 0, 0.35 },

			ChildrenInFront =
			{
				{
					Name = "Flame",
					Angle = 0,
					Offset = { 0, 0.8 },
					Pivot = { 0, 0.1 },
					PivotOffset = { 0, 0 },
					Sprite = "missile_tail",
				},
			},
		}
	},

	TrailEffect = path .. "/effects/SmartMissileTrail.lua",

	Missile =
	{
		ThrustAngleExtent = 40.0001, -- влияет на виляние, физическое увеличение скорости поворота, вызывает раскачивание при больших значениях
		ErraticAngleExtentStdDev = 0.000001,
		ErraticAngleExtentMax = 0.000001,
		MaxSteerPerSecond = 1000, --советовали держать 1\10 от скорости, сколько раз в секунду меняется скорость поворота, лучше чтобы было 100х-1000х от thrustangleextent и держать соотношение, чем больше, тем выше точность
		MaxSteerPerSecondErratic = 0.000001, -- возможно количество раз в секунду смены курса виляния
		ErraticAnglePeriodMean = 0.000001, -- наверное имеет дело к вилянию
		ErraticAnglePeriodStdDev = 0.000001, -- наверное рандомизация виляния
		RocketThrust = 100000, -- сила ускорения
		RocketThrustChange = 0.000001, -- изменение силы со временем
		ErraticThrust = 0, -- тряска, смена курса, вроде
		CruiseTargetDistance = 0.00001, --не делает ничего
		CruiseTargetDuration = 0.00001, -- не делает ничего
		TargetRearOffsetDistance = 0.000001, -- расстояние точки в которую будет целиться ракета за текущей целью от текущей цели, если из-за нижнего параметра прицеливание сбросится
		MinTargetUpdateDistance = 0.000001, --отмена трекинга при приближении. Не работает если постоянно ставишь трекинг
	},

	DamageMultiplier =
	{
		{ SaveName = "shield", Direct = 0, Splash = 0.5 },
	},

	Effects =
	{
		Impact =
		{
			["default"] = path .. "/effects/ExplosionBig1.lua",
                        ["antiair"] = path .. "/effects/ExplosionBig1.lua",
                        ["foundations"] = path .. "/effects/ExplosionBig1.lua",
                        ["rocks01"] = path .. "/effects/ExplosionBig1.lua",
		},
		Deflect =
		{
		},
                Age =
		{
			t1 = VerticalMissileLaunch,
		},
	},
})

MakeNoFuelMissile(
"HighFlight_verticalMissile1", -- Missile saveName
10000 * 100, -- Fuel time
nil, -- Flameout effect
true, -- Turn to mortar
nil, -- Gravity
0, -- Drag
nil, -- Max age
nil, -- Trail effect
10000, -- steerPerSecond multiplier
0.1--[[0.04]], -- rocketThrust multiplier
10000, -- thrustAngleExtent multiplier 
1 -- rocketThrustChange multiplier
)

--MakeFlamingVersion("HighFlight_verticalMissile1",		1.33,	3, flamingSwarmTrail, 85, nil, genericFlamingExpire)

table.insert(Projectiles,
{
	SaveName = "HighFlight_command",

	ProjectileType = "bullet",
	DrawBlurredProjectile = false,
	ProjectileMass = 1.0,
	ProjectileDrag = 1,
	DisableShields = false,
	DeflectedByShields = false,
	ExplodeOnTouch = true,

	Impact = 0,
	BeamTileRate = 0.02,
	BeamScrollRate = 0.0,
	ProjectileDamage = 0.0,
	ProjectileSplashDamage = 0.0,
	ProjectileSplashDamageMaxRadius = 0.0,
	ProjectileSplashMaxForce = 0, --remove 0000
	SpeedIndicatorFactor = 0.05,

        --ProjectileIncendiary = true,
        --IncendiaryRadius = 400,

	--AntiAirDamage = 0.0,
        --AntiAirHitpoints = 1,
        CanBeShotDown = false,
        --FieldCreatesImpactProjectile = true,
        --FieldType = 4,
        --FieldRadius = 100,
        --FieldStrengthMax = 500000
        --FieldStrengthMin = 400000
        CollidesWithBeams = false,
        CollidesWithProjectiles = false,
        CollidesWithLike = false,
        MaxAge = 0.01,
	--EMPRadius = 150,
	--EMPOffset = 50,
	--EMPDuration = 10,
	--EMPSensitivity = 0,
	Gravity = 0,
	IgnitesBackgroundMaterials = true,
	IgnitesBackgroundMaterialsPassing = true,
	IgnitesBackgroundMaterialsPassingSource = false,

        CollisionLookaheadDist = 5,--если есть что то спереди сразу колизится с ним как я понял
	ProjectileThickness = 4.0, --хитбокс настоящий
	ProjectileShootDownRadius = 50, --хитбокс по сути, реагирует на другие проджектайлы
	ProjectileShootDownRadiusBeamWidth = 5,--хз, не колизит с другими проджектайлами или физическими обьектами

        Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = "",
			Pivot = { 0, 0.35 },
		}
	},

        Effects =
	{
		Impact =
		{
			["default"] = "",
		},
		Deflect =
		{
		},
	},
})

table.insert(Projectiles,
{
	SaveName = "HighFlight_verticalMissile1Pointer",

	ProjectileType = "bullet",
	DrawBlurredProjectile = false,
	ProjectileMass = 1.0,
	ProjectileDrag = 1,
	DisableShields = false,
	DeflectedByShields = false,
	ExplodeOnTouch = true,

	Impact = 0,
	BeamTileRate = 0.02,
	BeamScrollRate = 0.0,
	ProjectileDamage = 0.0,
	ProjectileSplashDamage = 0.0,
	ProjectileSplashDamageMaxRadius = 0.0,
	ProjectileSplashMaxForce = 0, --remove 0000
	SpeedIndicatorFactor = 0.05,

        --ProjectileIncendiary = true,
        --IncendiaryRadius = 400,

	--AntiAirDamage = 0.0,
        --AntiAirHitpoints = 1,
        CanBeShotDown = false,
        --FieldCreatesImpactProjectile = true,
        --FieldType = 4,
        --FieldRadius = 100,
        --FieldStrengthMax = 500000
        --FieldStrengthMin = 400000
        CollidesWithBeams = false,
        CollidesWithProjectiles = false,
        CollidesWithLike = false,
        MaxAge = 0.01,
	--EMPRadius = 150,
	--EMPOffset = 50,
	--EMPDuration = 10,
	--EMPSensitivity = 0,
	Gravity = 0,
	IgnitesBackgroundMaterials = true,
	IgnitesBackgroundMaterialsPassing = true,
	IgnitesBackgroundMaterialsPassingSource = false,

        CollisionLookaheadDist = 5,--если есть что то спереди сразу колизится с ним как я понял
	ProjectileThickness = 4.0, --хитбокс настоящий
	ProjectileShootDownRadius = 50, --хитбокс по сути, реагирует на другие проджектайлы
	ProjectileShootDownRadiusBeamWidth = 5,--хз, не колизит с другими проджектайлами или физическими обьектами

        Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = "",
			Pivot = { 0, 0.35 },
		}
	},

        Effects =
	{
		Impact =
		{
			["default"] = "",
		},
		Deflect =
		{
		},
	},
})



























table.insert(Sprites,
{
        Name = "SM_PicketACap",

        States =
        {
                Normal =
                {
                        Frames =
                        {
                                { texture = path .. "/weapons/missiles/Picket/PicketACap.tga"},

                                --duration = 1.0,
                                blendColour = false,
                                blendCoordinates = false,
                                mipmap = false,
                        },
                        NextState = "Normal",
                },
        },
})

table.insert(Sprites,
{
        Name = "SM_PicketA",

        States =
        {
                Normal =
                {
                        Frames =
                        {
                                { texture = path .. "/weapons/missiles/Picket/PicketA.tga"},

                                --duration = 1.0,
                                blendColour = false,
                                blendCoordinates = false,
                                mipmap = false,
                        },
                        NextState = "Normal",
                },
        },
})

PicketStage0 = { Effect = "", Projectile = { Count = 1, Type = "SM_PicketA_Stage0", --[[Speed = 4000, StdDev = 1.1]] }, Offset = 0, Terminate = true, Splash = false, PosT = 1}
PicketStageN1 = { Effect = "", Projectile = { Count = 1, Type = "SM_PicketA_Stage-1", --[[Speed = 4000, StdDev = 1.1]] }, Offset = 0, Terminate = true, Splash = false, PosT = 1}

table.insert(Projectiles,
{
	SaveName = "SM_PicketA_Stage-2",

	ProjectileType = "missile",
	DrawBlurredProjectile = false,
	ProjectileMass = 5.0,
	ProjectileDrag = 0,
        MaxAge = 120,
	Gravity = 980,

	Impact = 1000000,
	BeamTileRate = 0.02,
	BeamScrollRate = 0.0,
	ProjectileDamage = 3000.0,
	ProjectileSplashDamage = 200.0,
	ProjectileSplashDamageMaxRadius = 500.0,
	ProjectileSplashMaxForce = 15000000,
	SpeedIndicatorFactor = 0.05,
        DisableShields = true,
	DeflectedByShields = false,
	ExplodeOnTouch = true,

        ProjectileIncendiary = true,
        IncendiaryRadius = 800,
        AlwaysIncendiary = true,
        --IncendiaryRadiusHeated = ,
	--IncendiaryOffset = 0.5,
        IgnitesBackgroundMaterials = true,
	IgnitesBackgroundMaterialsPassing = true,
	IgnitesBackgroundMaterialsPassingSource = false,

	AntiAirDamage = 600.0,
        AntiAirHitpoints = 1,
        CanBeShotDown = true,
        CollidesWithBeams = true,
        CollidesWithProjectiles = true,
        CollidesWithLike = true,

        CollisionLookaheadDist = 5,--если есть что то спереди сразу колизится с ним как я понял
	ProjectileThickness = 4.0, --хитбокс настоящий
	ProjectileShootDownRadius = 50, --хитбокс по сути, реагирует на другие проджектайлы
	ProjectileShootDownRadiusBeamWidth = 5,--хз, не колизит с другими проджектайлами или физическими обьектами

        --FieldCreatesImpactProjectile = true,
        --FieldType = 4,
        --FieldRadius = 100,
        --FieldStrengthMax = 500000
        --FieldStrengthMin = 400000

	--EMPRadius = 150,
	--EMPOffset = 50,
	--EMPDuration = 10,
	--EMPSensitivity = 0,

	--MaxAgeUnderwater = 3,
	--UnderwaterFadeDuration = 0.5,

	Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = "SM_PicketACap",
			Pivot = { 0, 0 },
                        Scale = 0.3,
		}
	},

	--TrailEffect = path .. "/effects/SmartMissileTrail.lua",

	Missile =
	{
		ThrustAngleExtent = 1.0001, -- влияет на виляние, физическое увеличение скорости поворота, вызывает раскачивание при больших значениях
		ErraticAngleExtentStdDev = 0.000001,
		ErraticAngleExtentMax = 0.000001,
		MaxSteerPerSecond = 5000,--1000, --советовали держать 1\10 от скорости, сколько раз в секунду меняется скорость поворота, лучше чтобы было 100х-1000х от thrustangleextent и держать соотношение, чем больше, тем выше точность
		MaxSteerPerSecondErratic = 0.000001, -- возможно количество раз в секунду смены курса виляния
		ErraticAnglePeriodMean = 0.000001, -- наверное имеет дело к вилянию
		ErraticAnglePeriodStdDev = 0.000001, -- наверное рандомизация виляния
		RocketThrust = 0.01, -- сила ускорения
		RocketThrustChange = 0.000001, -- изменение силы со временем
		ErraticThrust = 0, -- тряска, смена курса, вроде
		CruiseTargetDistance = 0.00001, --не делает ничего
		CruiseTargetDuration = 0.00001, -- не делает ничего
		TargetRearOffsetDistance = 0.000001, -- расстояние точки в которую будет целиться ракета за текущей целью от текущей цели, если из-за нижнего параметра прицеливание сбросится
		MinTargetUpdateDistance = 0.000001, --отмена трекинга при приближении. Не работает если постоянно ставишь трекинг
	},

	DamageMultiplier =
	{
		{ SaveName = "shield", Direct = 0, Splash = 0.5 },
	},

	Effects =
	{
		Impact =
		{
			["default"] = path .. "/effects/ExplosionBig1.lua",
                        ["antiair"] = path .. "/effects/ExplosionBig1.lua",
                        ["foundations"] = path .. "/effects/ExplosionBig1.lua",
                        ["rocks01"] = path .. "/effects/ExplosionBig1.lua",
		},
		Deflect =
		{
		},
                Age =
		{
			t1 = VerticalMissileLaunch,
			t1000 = PicketStageN1,
		},
	},
})

table.insert(Projectiles,
{
	SaveName = "SM_PicketA_Stage-1",

	ProjectileType = "missile",
	DrawBlurredProjectile = false,
	ProjectileMass = 5.0,
	ProjectileDrag = 0,
        MaxAge = 120,
	Gravity = 980,

	Impact = 1000000,
	BeamTileRate = 0.02,
	BeamScrollRate = 0.0,
	ProjectileDamage = 3000.0,
	ProjectileSplashDamage = 200.0,
	ProjectileSplashDamageMaxRadius = 500.0,
	ProjectileSplashMaxForce = 15000000,
	SpeedIndicatorFactor = 0.05,
        DisableShields = true,
	DeflectedByShields = false,
	ExplodeOnTouch = true,

        ProjectileIncendiary = true,
        IncendiaryRadius = 800,
        AlwaysIncendiary = true,
        --IncendiaryRadiusHeated = ,
	--IncendiaryOffset = 0.5,
        IgnitesBackgroundMaterials = true,
	IgnitesBackgroundMaterialsPassing = true,
	IgnitesBackgroundMaterialsPassingSource = false,

	AntiAirDamage = 600.0,
        AntiAirHitpoints = 1,
        CanBeShotDown = true,
        CollidesWithBeams = true,
        CollidesWithProjectiles = true,
        CollidesWithLike = true,

        CollisionLookaheadDist = 5,--если есть что то спереди сразу колизится с ним как я понял
	ProjectileThickness = 4.0, --хитбокс настоящий
	ProjectileShootDownRadius = 50, --хитбокс по сути, реагирует на другие проджектайлы
	ProjectileShootDownRadiusBeamWidth = 5,--хз, не колизит с другими проджектайлами или физическими обьектами

        --FieldCreatesImpactProjectile = true,
        --FieldType = 4,
        --FieldRadius = 100,
        --FieldStrengthMax = 500000
        --FieldStrengthMin = 400000

	--EMPRadius = 150,
	--EMPOffset = 50,
	--EMPDuration = 10,
	--EMPSensitivity = 0,

	--MaxAgeUnderwater = 3,
	--UnderwaterFadeDuration = 0.5,

	Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = "SM_PicketACap",
			Pivot = { 0, 0 },
                        Scale = 0.3,

			ChildrenInFront =
			{
				{
					Name = "Flame",
					Angle = 0,
					Offset = { 0, 1.65 },
					Pivot = { 0, 0 },
					PivotOffset = { 0, 0 },
					Sprite = "SM_Flame1",
                                        Scale = 1.5,
				},
                                {
					Name = "SideFlame1",
					Angle = -75,
					Offset = { 1.9, 0.0 },
					Pivot = { 0, 0 },
					PivotOffset = { 0, 0 },
					Sprite = "SM_Flame1Blink",
                                        Scale = 1,
				},
                                {
					Name = "SideFlame2",
					Angle = 75,
					Offset = { -1.9, 0.0 },
					Pivot = { 0, 0 },
					PivotOffset = { 0, 0 },
					Sprite = "SM_Flame1Blink",
                                        Scale = 1,
				},
			},
		}
	},

	--TrailEffect = path .. "/effects/SmartMissileTrail.lua",

	Missile =
	{
		ThrustAngleExtent = 50.0001, -- влияет на виляние, физическое увеличение скорости поворота, вызывает раскачивание при больших значениях
		ErraticAngleExtentStdDev = 0.000001,
		ErraticAngleExtentMax = 0.000001,
		MaxSteerPerSecond = 500,--1000, --советовали держать 1\10 от скорости, сколько раз в секунду меняется скорость поворота, лучше чтобы было 100х-1000х от thrustangleextent и держать соотношение, чем больше, тем выше точность
		MaxSteerPerSecondErratic = 0.000001, -- возможно количество раз в секунду смены курса виляния
		ErraticAnglePeriodMean = 0.000001, -- наверное имеет дело к вилянию
		ErraticAnglePeriodStdDev = 0.000001, -- наверное рандомизация виляния
		RocketThrust = 0.01, -- сила ускорения
		RocketThrustChange = 30000.000001, -- изменение силы со временем
		ErraticThrust = 0, -- тряска, смена курса, вроде
		CruiseTargetDistance = 0.00001, --не делает ничего
		CruiseTargetDuration = 0.00001, -- не делает ничего
		TargetRearOffsetDistance = 0.000001, -- расстояние точки в которую будет целиться ракета за текущей целью от текущей цели, если из-за нижнего параметра прицеливание сбросится
		MinTargetUpdateDistance = 0.000001, --отмена трекинга при приближении. Не работает если постоянно ставишь трекинг
	},

	DamageMultiplier =
	{
		{ SaveName = "shield", Direct = 0, Splash = 0.5 },
	},

	Effects =
	{
		Impact =
		{
			["default"] = path .. "/effects/ExplosionBig1.lua",
                        ["antiair"] = path .. "/effects/ExplosionBig1.lua",
                        ["foundations"] = path .. "/effects/ExplosionBig1.lua",
                        ["rocks01"] = path .. "/effects/ExplosionBig1.lua",
		},
		Deflect =
		{
		},
                Age =
		{
			t1 = VerticalMissileLaunch,
			t1500 = PicketStage0,
		},
	},
})

table.insert(Projectiles,
{
	SaveName = "SM_PicketA_Stage0",

	ProjectileType = "missile",
	DrawBlurredProjectile = false,
	ProjectileMass = 5.0,
	ProjectileDrag = 10,
        MaxAge = 120,
	Gravity = 980,

	Impact = 1000000,
	BeamTileRate = 0.02,
	BeamScrollRate = 0.0,
	ProjectileDamage = 3000.0,
	ProjectileSplashDamage = 200.0,
	ProjectileSplashDamageMaxRadius = 500.0,
	ProjectileSplashMaxForce = 15000000,
	SpeedIndicatorFactor = 0.05,
        DisableShields = true,
	DeflectedByShields = false,
	ExplodeOnTouch = true,

        ProjectileIncendiary = true,
        IncendiaryRadius = 800,
        AlwaysIncendiary = true,
        --IncendiaryRadiusHeated = ,
	--IncendiaryOffset = 0.5,
        IgnitesBackgroundMaterials = true,
	IgnitesBackgroundMaterialsPassing = true,
	IgnitesBackgroundMaterialsPassingSource = false,

	AntiAirDamage = 600.0,
        AntiAirHitpoints = 1,
        CanBeShotDown = true,
        CollidesWithBeams = true,
        CollidesWithProjectiles = true,
        CollidesWithLike = true,

        CollisionLookaheadDist = 5,--если есть что то спереди сразу колизится с ним как я понял
	ProjectileThickness = 4.0, --хитбокс настоящий
	ProjectileShootDownRadius = 50, --хитбокс по сути, реагирует на другие проджектайлы
	ProjectileShootDownRadiusBeamWidth = 5,--хз, не колизит с другими проджектайлами или физическими обьектами

        --FieldCreatesImpactProjectile = true,
        --FieldType = 4,
        --FieldRadius = 100,
        --FieldStrengthMax = 500000
        --FieldStrengthMin = 400000

	--EMPRadius = 150,
	--EMPOffset = 50,
	--EMPDuration = 10,
	--EMPSensitivity = 0,

	--MaxAgeUnderwater = 3,
	--UnderwaterFadeDuration = 0.5,

	Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = "SM_PicketA",
			Pivot = { 0, 0 },
                        Scale = 0.3,

			ChildrenInFront =
			{
				{
					Name = "Flame",
					Angle = 0,
					Offset = { 0, 1.0 },
					Pivot = { 0, 0 },
					PivotOffset = { 0, 0 },
					Sprite = "SM_Flame2",
                                        Scale = 3,
				},
			},
		}
	},

	TrailEffect = path .. "/effects/SmartMissileTrail.lua",

	Missile =
	{
		ThrustAngleExtent = 40.0001, -- влияет на виляние, физическое увеличение скорости поворота, вызывает раскачивание при больших значениях
		ErraticAngleExtentStdDev = 0.000001,
		ErraticAngleExtentMax = 0.000001,
		MaxSteerPerSecond = 1000, --советовали держать 1\10 от скорости, сколько раз в секунду меняется скорость поворота, лучше чтобы было 100х-1000х от thrustangleextent и держать соотношение, чем больше, тем выше точность
		MaxSteerPerSecondErratic = 0.000001, -- возможно количество раз в секунду смены курса виляния
		ErraticAnglePeriodMean = 0.000001, -- наверное имеет дело к вилянию
		ErraticAnglePeriodStdDev = 0.000001, -- наверное рандомизация виляния
		RocketThrust = 100000, -- сила ускорения
		RocketThrustChange = 0.000001, -- изменение силы со временем
		ErraticThrust = 0, -- тряска, смена курса, вроде
		CruiseTargetDistance = 0.00001, --не делает ничего
		CruiseTargetDuration = 0.00001, -- не делает ничего
		TargetRearOffsetDistance = 0.000001, -- расстояние точки в которую будет целиться ракета за текущей целью от текущей цели, если из-за нижнего параметра прицеливание сбросится
		MinTargetUpdateDistance = 0.000001, --отмена трекинга при приближении. Не работает если постоянно ставишь трекинг
	},

	DamageMultiplier =
	{
		{ SaveName = "shield", Direct = 0, Splash = 0.5 },
	},

	Effects =
	{
		Impact =
		{
			["default"] = path .. "/effects/ExplosionBig1.lua",
                        ["antiair"] = path .. "/effects/ExplosionBig1.lua",
                        ["foundations"] = path .. "/effects/ExplosionBig1.lua",
                        ["rocks01"] = path .. "/effects/ExplosionBig1.lua",
		},
		Deflect =
		{
		},
	},
})

table.insert(Projectiles,
{
	SaveName = "SM_PicketA_Pointer",

	ProjectileType = "bullet",
	DrawBlurredProjectile = false,
	ProjectileMass = 1.0,
	ProjectileDrag = 1,
	DisableShields = false,
	DeflectedByShields = false,
	ExplodeOnTouch = true,

	Impact = 0,
	BeamTileRate = 0.02,
	BeamScrollRate = 0.0,
	ProjectileDamage = 0.0,
	ProjectileSplashDamage = 0.0,
	ProjectileSplashDamageMaxRadius = 0.0,
	ProjectileSplashMaxForce = 0,
	SpeedIndicatorFactor = 0.05,
        CanBeShotDown = false,
        CollidesWithBeams = false,
        CollidesWithProjectiles = false,
        CollidesWithLike = false,
        MaxAge = 0.01,
	Gravity = 0,
	IgnitesBackgroundMaterials = false,
	IgnitesBackgroundMaterialsPassing = false,
	IgnitesBackgroundMaterialsPassingSource = false,

        CollisionLookaheadDist = 0,--если есть что то спереди сразу колизится с ним как я понял
	ProjectileThickness = 0.1, --хитбокс настоящий
	ProjectileShootDownRadius = 0.1, --хитбокс по сути, реагирует на другие проджектайлы
	ProjectileShootDownRadiusBeamWidth = 0.1,--хз, не колизит с другими проджектайлами или физическими обьектами

        Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = "",
			Pivot = { 0, 0.35 },
		}
	},

        Effects =
	{
		Impact =
		{
			["default"] = "",
		},
		Deflect =
		{
		},
	},
})