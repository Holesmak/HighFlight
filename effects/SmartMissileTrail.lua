
--  age (in seconds) at which the explosion actor deletes itself
--  make sure this exceedes the age of all effects
LifeSpan = 5.0

Effects =
{
	{
		Type = "trail",
		Texture = path .. "/effects/Trails/trail.dds",
		LocalPosition = { x = 0, y = 0, z = 9.0 },
		Width = 90,
		Length = 5,
		Keyframes = 100,
		KeyframePeriod = 0.05,
		RepeatRate = 0.001,
		ScrollRate = 0.1,
		FattenRate = 40,
	}
}
