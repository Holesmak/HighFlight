SMARTMISSILE_SAVENAMES = {
        --"rocketemp",
        --"missile2",
        --"rocket",
        --"rocketmi24",
        "HighFlight_antiair1"
}

SMARTMISSILE_CONFIG = {}
SMARTMISSILE_CONFIG["rocketemp"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = false,
        ignoreStructures = false,
        predictionType = 1,
        sectorRadius = 2500,
        sectorWidth = 30,
}

SMARTMISSILE_CONFIG["rocketmi24"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = false,
        ignoreStructures = true,
        predictionType = 1,
        sectorRadius = 4000,
        sectorWidth = 45,
}

SMARTMISSILE_CONFIG["missile2"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = true,
        ignoreStructures = false,
        predictionType = 1,
        sectorRadius = 2500,
        sectorWidth = 30,
}

SMARTMISSILE_CONFIG["HighFlight_antiair1"] = {
        ignoreNeutrals = false,
        ignoreProjectiles = false,
        ignoreStructures = false,
        predictionType = 2,
        sectorRadius = 7000,
        sectorWidth = 30,
        courseHoldDelay = 1,
}