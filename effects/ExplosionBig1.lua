LifeSpan = 10.0
local EffectSize = 4

Sprites =
{
	{
		Name = "ExplosionBig1",

		States =
		{
			Normal =
			{
				Frames =
				{
					{ texture = path .. "/effects/ExplosionBig1/Normal/0001.png", colour = { 1, 1, 1, 1.0 },  duration = 0.05  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0002.png", colour = { 1, 1, 1, 1.0 },  duration = 0.05  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0003.png", colour = { 1, 1, 1, 1.0 },  duration = 0.05  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0004.png", colour = { 1, 1, 1, 1.0 },  duration = 0.05  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0005.png", colour = { 1, 1, 1, 1.0 },  duration = 0.05  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0006.png", colour = { 1, 1, 1, 1.0 },  duration = 0.05  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0007.png", colour = { 1, 1, 1, 1.0 },  duration = 0.05  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0008.png", colour = { 1, 1, 1, 1.0 },  duration = 0.05  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0009.png", colour = { 1, 1, 1, 1.0 },  duration = 0.05  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0010.png", colour = { 1, 1, 1, 1.0 },  duration = 0.05  },
                                        { texture = path .. "/effects/ExplosionBig1/Normal/0011.png", colour = { 1, 1, 1, 1.0 },  duration = 0.05  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0012.png", colour = { 1, 1, 1, 1.0 },  duration = 0.05  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0013.png", colour = { 1, 1, 1, 1.0 },  duration = 0.05  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0014.png", colour = { 1, 1, 1, 1.0 },  duration = 0.05 },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0015.png", colour = { 1, 1, 1, 1.0 },  duration = 0.075 },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0016.png", colour = { 1, 1, 1, 1.0 },  duration = 0.075  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0017.png", colour = { 1, 1, 1, 1.0 },  duration = 0.075  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0018.png", colour = { 1, 1, 1, 1.0 },  duration = 0.075  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0019.png", colour = { 1, 1, 1, 1.0 },  duration = 0.075  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0020.png", colour = { 1, 1, 1, 1.0 },  duration = 0.075  },
                                        { texture = path .. "/effects/ExplosionBig1/Normal/0021.png", colour = { 1, 1, 1, 1.0 },  duration = 0.075  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0022.png", colour = { 1, 1, 1, 1.0 },  duration = 0.075  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0023.png", colour = { 1, 1, 1, 1.0 },  duration = 0.1  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0024.png", colour = { 1, 1, 1, 1.0 },  duration = 0.1  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0025.png", colour = { 1, 1, 1, 1.0 },  duration = 0.1  },
                                        { texture = path .. "/effects/ExplosionBig1/Normal/0026.png", colour = { 1, 1, 1, 1.0 },  duration = 0.1  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0027.png", colour = { 1, 1, 1, 1.0 },  duration = 0.1  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0028.png", colour = { 1, 1, 1, 1.0 },  duration = 0.1  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0029.png", colour = { 1, 1, 1, 1.0 },  duration = 0.1  },
                                        { texture = path .. "/effects/ExplosionBig1/Normal/0030.png", colour = { 1, 1, 1, 1.0 },  duration = 0.15  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0031.png", colour = { 1, 1, 1, 1.0 },  duration = 0.15  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0032.png", colour = { 1, 1, 1, 1.0 },  duration = 0.15  },
                                        { texture = path .. "/effects/ExplosionBig1/Normal/0033.png", colour = { 1, 1, 1, 1.0 },  duration = 0.15  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0034.png", colour = { 1, 1, 1, 1.0 },  duration = 0.15  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0035.png", colour = { 1, 1, 1, 1.0 },  duration = 0.2  },
                                        { texture = path .. "/effects/ExplosionBig1/Normal/0036.png", colour = { 1, 1, 1, 1.0 },  duration = 0.2  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0037.png", colour = { 1, 1, 1, 1.0 },  duration = 0.2  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0038.png", colour = { 1, 1, 1, 1.0 },  duration = 0.2  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0039.png", colour = { 1, 1, 1, 1.0 },  duration = 0.2  },
					{ texture = path .. "/effects/ExplosionBig1/Normal/0040.png", colour = { 1, 1, 1, 1.0 },  duration = 10  },
					--{ texture = path .. "/effects/media/mortar04.dds", colour = { 1, 1, 1, 0.0 }, duration = 2 }, -- just makes a blank frame long enough to last the rest of the effect

					duration = 1.0,
					blendColour = false,
					blendCoordinates = false,
				},
				--RandomPlayLength = 2,
				NextState = "Normal",
			},
		},
	},  
        {
		Name = "ExplosionBig1AH",

		States =
		{
			Normal =
			{
				Frames =
				{
					{ texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0001.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0002.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0003.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0004.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0005.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0006.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0007.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0008.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0009.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0010.png" },
                                        { texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0011.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0012.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0013.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0014.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/High/AdditsHigh0015.png", duration = 10 },
					--{ texture = path .. "/effects/media/mortar04.dds", colour = { 1, 1, 1, 0.0 }, duration = 2 }, -- just makes a blank frame long enough to last the rest of the effect

					duration = 0.05,
					blendColour = false,
					blendCoordinates = false,
				},
				--RandomPlayLength = 2,
				NextState = "Normal",
			},
		},
	},  
        {
		Name = "ExplosionBig1AL",

		States =
		{
			Normal =
			{
				Frames =
				{
					{ texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0001.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0002.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0003.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0004.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0005.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0006.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0007.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0008.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0009.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0010.png" },
                                        { texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0011.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0012.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0013.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0014.png" },
					{ texture = path .. "/effects/ExplosionBig1/Additive/Low/Addits0015.png", duration = 10  },
					--{ texture = path .. "/effects/media/mortar04.dds", colour = { 1, 1, 1, 0.0 }, duration = 2 }, -- just makes a blank frame long enough to last the rest of the effect

					duration = 0.05,
					blendColour = false,
					blendCoordinates = false,
				},
				--RandomPlayLength = 2,
				NextState = "Normal",
			},
		},
	},  
}

Effects =
{
        {
		Type = "sprite",
		TimeToTrigger = 0,
		LocalPosition = { x = 0, y = 0, z = 0 },
		LocalVelocity = { x = 0, y = 0, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0.0,
		Sprite = "ExplosionBig1",
		Additive = false,
		AngleMaxDeviation = 3600,
		Angle = 0,
		TimeToLive = 10,
		InitialSize = EffectSize,
		ExpansionRate = 150,
		AngularVelocity = 0,
		RandomAngularVelocityMagnitude = 0,
		Colour1 = { 255, 255, 255, 255 },
		Colour2 = { 255, 255, 255, 255 },
	},
        {
		Type = "sprite",
		TimeToTrigger = 0,
		LocalPosition = { x = 0, y = 0, z = -1000 },
		LocalVelocity = { x = 0, y = 0, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0.0,
		Sprite = "ExplosionBig1AH",
		Additive = true,
		AngleMaxDeviation = 360,
		Angle = 0,
		TimeToLive = 5,
		InitialSize = EffectSize,
		ExpansionRate = 1,
		AngularVelocity = 0,
		RandomAngularVelocityMagnitude = 0,
		Colour1 = { 255, 255, 255, 128 },
		Colour2 = { 255, 255, 255, 0 },
	},
        {
		Type = "sprite",
		TimeToTrigger = 0,
		LocalPosition = { x = 0, y = 0, z = 0 },
		LocalVelocity = { x = 0, y = 0, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0.0,
		Sprite = "ExplosionBig1AL",
		Additive = true,
		AngleMaxDeviation = 360,
		Angle = 0,
		TimeToLive = 5,
		InitialSize = EffectSize,
		ExpansionRate = 1,
		AngularVelocity = 0,
		RandomAngularVelocityMagnitude = 0,
		Colour1 = { 255, 255, 255, 128 },
		Colour2 = { 255, 255, 255, 0 },
	},
	{
		Type = "shake",
		PlayForEnemy = true,
		FalloffStart = 1000,
		FalloffEnd = 5000,
		TimeToTrigger = 0.1,
		TimeToLive = 1,
		Magnitude = 50,
	},
        --{
	--	Type = "sound",
	--	TimeToTrigger = 0.0,
	--	LocalPosition = { x = 0, y = 0, z = 0 },
	--	Sound = "shock_impact",
	--	Volume = 0.8,
	--	Priority = 192,
	--},
        
}

FireSounds =
{
	path .. "/effects/Sounds/ExplosionBig1.mp3",
}

function UpdateEffect(self, effectTime, pos)
	if effectTime == 0 then
		TriggerSound(FireSounds[math.random(#FireSounds)], 5.0, 1, true, true, pos)
                --TriggerSound(Variants[math.random(#Variants)], volume, priority, playForEnemy, is3D, pos)
	end
	
	return self
end