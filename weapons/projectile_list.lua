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

	Impact = 100000,
	BeamTileRate = 0.02,
	BeamScrollRate = 0.0,
	ProjectileDamage = 200.0,
	ProjectileSplashDamage = 50.0,
	ProjectileSplashDamageMaxRadius = 15.0,
	ProjectileSplashMaxForce = 5000000, --remove 0000
	SpeedIndicatorFactor = 0.05,

        --ProjectileIncendiary = true,
        --IncendiaryRadius = 400,

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
        MaxAge = 15,
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

	TrailEffect = "effects/missile_trail.lua",

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
		{ SaveName = "shield", Direct = 0, Splash = 0.5 },
	},

	Effects =
	{
		Impact =
		{
			["default"] = "effects/missile_structure_hit.lua",
                        ["antiair"] = "effects/missile_structure_hit.lua",
		},
		Deflect =
		{
		},
	},
})