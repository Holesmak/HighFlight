DrawDebug = true

SMARTMISSILE_ALLOWED_PROJECTILES = {2, 3}
SMARTMISSILE_TERRAINFLAGS = TERRAIN_BACKGROUND + TERRAIN_PROJECTILE
SMARTMISSILE_DRAW_TRACKERS = false
SMARTMISSILE_STRUCTURE_RADIUS_MULTIPLIER = 2

SMARTMISSILE_POINTER_MISSILE_PAIRS = {}
SMARTMISSILE_POINTER_MISSILE_PAIRS["HighFlight_verticalMissile1Pointer"] = "HighFlight_verticalMissile1"
SMARTMISSILE_POINTER_MISSILE_PAIRS["SM_PicketA_Pointer"] = "SM_PicketA_Stage-2"

SMARTMISSILE_CONFIG = {}
SMARTMISSILE_CONFIG["rocketemp"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = false,
        targetProjectiles = {2, 3},
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
        targetProjectiles = {2, 3},
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
        targetProjectiles = {2, 3},
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
        targetProjectiles = {2, 3},
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

SMARTMISSILE_CONFIG["missile"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = false,
        targetProjectiles = {2, 3},
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

SMARTMISSILE_CONFIG["HighFlight_antiair1"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = false,
        targetProjectiles = {2, 3},
        ignoreStructures = false,
        predictionType = 3,
        sectorRadius = 50000,
        sectorWidth = 45,
        courseHoldDelay = 1,

        trackingDelay = 2,

        trackerColor = Colour(255, 30, 30, 50),
        trackerGradient = true,
        trackerGradientMin = 1,
        trackerGradientMax = 0,

        relativeVelocity = true,
}

SMARTMISSILE_CONFIG["HighFlight_verticalMissile1"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = false,
        targetProjectiles = {2, 3},
        ignoreStructures = false,
        predictionType = 0, -- 0: No prediction, 1: Velocity, 2: Velocity and Acceleration
        sectorRadius = 100000,
        sectorWidth = 70 * 2,

        trackingDelay = 1,

        trackerColor = Colour(255, 30, 30, 255),
        trackerGradient = false,
        trackerGradientMin = 1,
        trackerGradientMax = 1,

        courseHoldDelay = 0, -- -1 dont set course, 0 set course instantly
        setCourseAgain = true, -- Aim vertical launched missiles at the pointer direction
        setCourseAgainDelay = 0.5,

        verticalLaunchOffset = Vec3(200, 0), -- Y (positive UP), X (positive RIGHT)
        verticalLaunchVelocity = Vec3(1000, 0),

        pointerVelocityAffects = 2, -- 1: Launch velocity, 2: CourseAgainDelay, 3: Both

        ballisticTrajectory = true,
        ballisticPMultiplier = 100000,
        ballisticTrajectoryMultiplier = 3,

        --onSpawnEffect
        --effectRelativeRot --Projectile, Global, Device

        relativeVelocity = true,
}

SMARTMISSILE_CONFIG["HighFlight_verticalMissile1_StageNoFuel"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = true,
        targetProjectiles = {2, 3},
        ignoreStructures = false,
        predictionType = 3,
        sectorRadius = 700000,
        sectorWidth = 180,
        --TrackingDelay would be cool

        trackerColor = Colour(255, 30, 30, 255),
        trackerGradient = false,
        trackerGradientMin = 1,
        trackerGradientMax = 0,

        courseHoldDelay = 0, -- -1 dont set course, 0 set course instantly
        setCourseAgain = true, -- Aim vertical launched missiles at the pointer direction
        setCourseAgainDelay = 0.5,

        verticalLaunchOffset = Vec3(200, 0), -- Y (positive UP), X (positive RIGHT)
        verticalLaunchVelocity = Vec3(1000, 0),

        pointerVelocityAffects = 2, -- 1: Launch velocity, 2: CourseAgainDelay, 3: Both

        ballisticTrajectory = true,
        ballisticPMultiplier = 100000,
        ballisticTrajectoryMultiplier = 3,

        relativeVelocity = true,

        --onSpawnEffect
        --effectRelativeRot --Projectile, Global, Device
}

SMARTMISSILE_CONFIG["SM_PicketA_Stage-2"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = true,
        targetProjectiles = {},
        ignoreStructures = true,
        predictionType = 0, -- 0: No prediction, 1: Velocity, 2: Velocity and Acceleration
        sectorRadius = 0,
        sectorWidth = 0,

        trackingDelay = 0,

        trackerColor = Colour(255, 30, 30, 255),
        trackerGradient = false,
        trackerGradientMin = 1,
        trackerGradientMax = 1,

        courseHoldDelay = 0, -- -1 dont set course, 0 set course instantly
        setCourseAgain = true, -- Aim vertical launched missiles at the pointer direction
        setCourseAgainDelay = 0.25,

        verticalLaunchOffset = Vec3(200, 0), -- Y (positive UP), X (positive RIGHT)
        verticalLaunchVelocity = Vec3(1500, 0),

        pointerVelocityAffects = 0, -- 1: Launch velocity, 2: CourseAgainDelay, 3: Both

        relativeVelocity = true,
}

SMARTMISSILE_CONFIG["SM_PicketA_Stage-1"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = true,
        targetProjectiles = {},
        ignoreStructures = true,
        predictionType = 0, -- 0: No prediction, 1: Velocity, 2: Velocity and Acceleration
        sectorRadius = 0,
        sectorWidth = 0,

        trackingDelay = 0,

        trackerColor = Colour(255, 30, 30, 255),
        trackerGradient = false,
        trackerGradientMin = 1,
        trackerGradientMax = 1,

        courseHoldDelay = -1, -- -1 dont set course, 0 set course instantly
        setCourseAgain = false, -- Aim vertical launched missiles at the pointer direction
        setCourseAgainDelay = 0.25,

        verticalLaunchOffset = Vec3(200, 0), -- Y (positive UP), X (positive RIGHT)
        verticalLaunchVelocity = Vec3(3000, 0),

        pointerVelocityAffects = 0, -- 1: Launch velocity, 2: CourseAgainDelay, 3: Both

        relativeVelocity = false,
}

SMARTMISSILE_CONFIG["SM_PicketA_Stage0"] = {
        ignoreNeutrals = true,
        ignoreProjectiles = false,
        targetProjectiles = {2, 3},
        ignoreStructures = false,
        predictionType = 0, -- 0: No prediction, 1: Velocity, 2: Velocity and Acceleration
        sectorRadius = 100000,
        sectorWidth = 70 * 2,

        trackingDelay = 1,

        trackerColor = Colour(255, 30, 30, 255),
        trackerGradient = false,
        trackerGradientMin = 1,
        trackerGradientMax = 1,

        courseHoldDelay = -1, -- -1 dont set course, 0 set course instantly
        setCourseAgain = true, -- Aim vertical launched missiles at the pointer direction
        setCourseAgainDelay = 0.5,

        verticalLaunchOffset = Vec3(200, 0), -- Y (positive UP), X (positive RIGHT)
        verticalLaunchVelocity = Vec3(1000, 0),

        pointerVelocityAffects = 2, -- 1: Launch velocity, 2: CourseAgainDelay, 3: Both

        ballisticTrajectory = true,
        ballisticPMultiplier = 100000,
        ballisticTrajectoryMultiplier = 3,

        --onSpawnEffect
        --effectRelativeRot --Projectile, Global, Device

        relativeVelocity = true,
}

function InnitialiseAdditionalConfig()
        --CAddNoFuelStage("HighFlight_verticalMissile1")
end

function CAddStageName(missileSaveName, stageSufix)
        local newConf = DeepCopy(SMARTMISSILE_CONFIG[missileSaveName])
        newConf.courseHoldDelay = -1
        newConf.setCourseAgain = false
        SMARTMISSILE_CONFIG[missileSaveName .. stageSufix] = newConf
end

function CAddStage(missileSaveName, stageNumber)
        local newConf = DeepCopy(SMARTMISSILE_CONFIG[missileSaveName])
        newConf.courseHoldDelay = -1
        newConf.setCourseAgain = false
        SMARTMISSILE_CONFIG[missileSaveName .. "_Stage" .. stageNumber] = newConf
end

function CAddNoFuelStage(missileSaveName)
        local newConf = DeepCopy(SMARTMISSILE_CONFIG[missileSaveName])
        newConf.courseHoldDelay = -1
        newConf.setCourseAgain = false
        SMARTMISSILE_CONFIG[missileSaveName .. "_StageNoFuel"] = newConf
end