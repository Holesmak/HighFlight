DrawDebug = true

SMARTMISSILE_SAVENAMES = {
        "rocketemp",
        "missile2",
--        "missile",
        "rocket",
        "rocketmi24",
        "HighFlight_antiair1"
}

SMARTMISSILE_CONFIG = {}
SMARTMISSILE_CONFIG["rocketemp"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = false,
        ignoreStructures = false,
        predictionType = 2,
        sectorRadius = 3500,
        sectorWidth = 30,
        courseHoldDelay = -1,
                        
        trackerColor = Colour(30, 30, 255, 150),
        trackerGradient = true,
        trackerGradientMin = 1,
        trackerGradientMax = 0,
}

SMARTMISSILE_CONFIG["rocket"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = true,
        ignoreStructures = false,
        predictionType = 1,
        sectorRadius = 5000,
        sectorWidth = 20,
        courseHoldDelay = -1,
                
        trackerColor = Colour(255, 30, 30, 100),
        trackerGradient = true,
        trackerGradientMin = 1,
        trackerGradientMax = 0,
}

SMARTMISSILE_CONFIG["rocketmi24"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = false,
        ignoreStructures = false,
        predictionType = 3,
        sectorRadius = 6000,
        sectorWidth = 15,
        courseHoldDelay = 10,

        trackerColor = Colour(255, 30, 30, 50),
        trackerGradient = true,
        trackerGradientMin = 1,
        trackerGradientMax = 0,
}

SMARTMISSILE_CONFIG["missile2"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = true,
        ignoreStructures = false,
        predictionType = 1,
        sectorRadius = 3000,
        sectorWidth = 60,
        courseHoldDelay = 20,
        
        trackerColor = Colour(255, 30, 30, 100),
        trackerGradient = true,
        trackerGradientMin = 1,
        trackerGradientMax = 0,
}

--SMARTMISSILE_CONFIG["missile"] = {
--        ignoreNeutrals = true,
--        ignoreProjectiles = true,
--        ignoreStructures = false,
--        predictionType = 1,
--        sectorRadius = 3000,
--        sectorWidth = 60,
--        courseHoldDelay = 20,
--        
--        trackerColor = Colour(255, 30, 30, 100),
--        trackerGradient = true,
--        trackerGradientMin = 1,
--        trackerGradientMax = 0,
--}

SMARTMISSILE_CONFIG["HighFlight_antiair1"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = false,
        ignoreStructures = false,
        predictionType = 3,
        sectorRadius = 7000,
        sectorWidth = 30,
        courseHoldDelay = 1,

        trackerColor = Colour(255, 30, 30, 150),
        trackerGradient = true,
        trackerGradientMin = 1,
        trackerGradientMax = 0,
}