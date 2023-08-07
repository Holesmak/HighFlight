dofile("ui/uihelper.lua")

-- ICONS START

-- ICONS END
-- SPRITES START
table.insert(Sprites,
{
    Name = "test",
    States =
    {
        Normal =
        {
            Frames =
            {
                -- durations must add up to 1 for the damage keying to work properly
                -- anything beyond 1 will never show
                { texture = path .. "/materials/test/bridge1", duration = 0.4 },
                { texture = path .. "/materials/test/bridge2", duration = 0.3 },
                { texture = path .. "/materials/test/bridge3", duration = 0.3 },
                mipmap = true,
                repeatS = true,
            },
        },
    },
})
table.insert(Sprites,
{
    Name = "testbg",
    States =
    {
        Normal =
        {
            Frames =
            {
                -- durations must add up to 1 for the damage keying to work properly
                -- anything beyond 1 will never show
                { texture = path .. "/materials/test/bridgebg1", duration = 0.4 },
                { texture = path .. "/materials/test/bridgebg2", duration = 0.3 },
                { texture = path .. "/materials/test/bridgebg3", duration = 0.3 },
                mipmap = true,
                repeatS = true,
            },
        },
    },
})

--SPRITES END


local test1 = FindMaterial("backbracing")
if test1 then
	test1.Sprite = "testbg"
end

local test2 = FindMaterial("bracing")
if test2 then
	test2.Sprite = "test"
end

for k, v in pairs(Sprites) do 
	if v.Name == "cladding" then
		table.remove(Sprites, k)
	end
end

table.insert(Sprites, 

	{
		
		Name = "cladding",
		CalculateChecksum = true,
		States =
		{
			Foreground =
			{
				Frames =
				{
					-- durations must add up to 1 for the damage keying to work properly
					-- anything beyond 1 will never show
					{ texture = path .. "/materials/test/testclad1.png", duration = 0.4 },
					{ texture = path .. "/materials/test/testclad2.png", duration = 0.3 },
					{ texture = path .. "/materials/test/testclad3.png", duration = 0.3 },
					mipmap = true,
					repeatS = true,
					repeatT = true,
				},
			},
			Background =
			{
				Frames =
				{
					-- durations must add up to 1 for the damage keying to work properly
					-- anything beyond 1 will never show
					{ texture = path .. "/materials/test/testcladbg1.png", duration = 0.4 },
					{ texture = path .. "/materials/test/testcladbg2.png", duration = 0.3 },
					{ texture = path .. "/materials/test/testcladbg3.png", duration = 0.3 },
					mipmap = true,
					repeatS = true,
					repeatT = true,
				},
			},
		},
	}
)