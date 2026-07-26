-- GameConfig.lua
-- Central game configuration file
-- Change values here to adjust game behavior

local GameConfig = {
    GameName = "+1 Speed Keyboard Escape",
    Version = "1.0.0",
    
    -- Speed System Configuration
    Speed = {
        StartingSpeed = 0,
        SpeedPerStep = 1,
        MaxLevel = 1000,
        MaxRebirth = 21,
        UnlimitedSpeedMultiplier = true,
    },
    
    -- Starting Player Resources
    StartingResources = {
        Wins = 1,
        Lumens = 100,
        Speed = 0,
        Level = 1,
        Rebirth = 0,
        SpeedPerStep = 1,
    },
    
    -- Worlds Configuration
    Worlds = {
        {Name = "Lemon & Lime", Theme = "Indoor", Color = Color3.fromRGB(255, 223, 0)},
        {Name = "Snowy Mountains", Theme = "Snow", Color = Color3.fromRGB(200, 220, 255)},
        {Name = "Beach Paradise", Theme = "Tropical", Color = Color3.fromRGB(255, 200, 100)},
        {Name = "Forest Kingdom", Theme = "Nature", Color = Color3.fromRGB(34, 139, 34)},
    },
    
    -- Mini Worlds & Stages per World
    MiniWorldsPerMainWorld = 4,
    StagesPerMiniWorld = {20, 15, 7, 4},
    TotalStages = 184,
    
    -- Stage Design Parameters
    Stage = {
        TargetSpeedrunTime = 180,
        SpaceBetweenAreas = 500,
        DifficultyScaling = 1.15,
    },
    
    -- Safe Zone Features
    SafeZone = {
        HasWinsPressurePlate = true,
        HasFreeTreadmill = true,
        FreeTreadmillMultiplier = 1,
        HasShop = true,
        HasUpgradeBoard = true,
    },
    
    -- Currency Symbols & Names
    Currency = {
        Wins = {Symbol = "🏆", Name = "Wins"},
        Lumens = {Symbol = "💡", Name = "Lumens"},
    },
    
    -- Shop Categories Enabled
    Shop = {
        PremiumTreadmills = true,
        SpeedMultipliers = true,
        WinsMultipliers = true,
        Trails = true,
        Auras = true,
        KeyboardSoundPacks = true,
        SpeedUpgrades = true,
    },
    
    -- Starting Cosmetic Items
    StartingItems = {
        Trails = 5,
        Auras = 3,
    },
    
    -- Weather System Configuration
    Weather = {
        RandomWeatherCount = 10,
        AdminWeatherCount = 7,
        SpeedMultiplierRange = {2, 5},
        WinsMultiplierRange = {2, 5},
        WeatherDuration = 300,
    },
    
    -- Business Center Configuration
    BusinessCenter = {
        Enabled = true,
        Options = {"Hotel Manager", "Business Manager"},
    },
    
    -- Admin Settings
    Admin = {
        CreatorId = 308782858,
        AdminTreadmills = {
            {Name = "Admin Treadmill x120", Multiplier = 120},
            {Name = "Admin Treadmill x150", Multiplier = 150},
        },
    },
    
    -- Graphics & Visual Settings
    Graphics = {
        UseFutureLighting = true,
        EnableBloom = true,
        EnableAtmosphere = true,
        EnableShadows = true,
        EnableReflections = true,
        ParticleEffects = true,
        AmbientLighting = 1,
    },
    
    -- Keyboard Theme Settings
    Keyboard = {
        KeyboardFloorEnabled = true,
        KeyMovesDown = true,
        KeyMovesDownDistance = 0.3,
        KeyMovesDownDuration = 0.1,
        KeyboardSoundsEnabled = true,
    },
    
    -- DataStore Configuration
    DataStore = {
        Enabled = true,
        StoreVersion = 1,
        AutoSaveInterval = 60,
        BackupInterval = 300,
    },
    
    -- Rebirth Configuration
    Rebirth = {
        MaxRebirths = 21,
        MultiplierPerRebirth = 0.1,
        ResetSpeedOnRebirth = true,
        PreserveWinsOnRebirth = true,
        PreserveLumensOnRebirth = true,
    },
}

return GameConfig
