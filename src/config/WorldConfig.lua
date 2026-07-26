-- WorldConfig.lua
-- Configuration for all 4 worlds, 16 mini worlds, and stage progression

local WorldConfig = {
    -- World 1: Lemon & Lime (Indoor Theme)
    {
        Id = 1,
        Name = "Lemon & Lime",
        Theme = "Indoor",
        Color = Color3.fromRGB(255, 223, 0),
        Music = "rbxassetid://REPLACE_WITH_ID",
        Atmosphere = "Warm",
        Description = "A cozy indoor world with golden halls and lime caves.",
        MiniWorlds = {
            {Name = "Golden Hall", Order = 1, Stages = 20, Difficulty = 1},
            {Name = "Lime Caves", Order = 2, Stages = 15, Difficulty = 1.3},
            {Name = "Lemon Factory", Order = 3, Stages = 7, Difficulty = 1.7},
            {Name = "Citrus Temple", Order = 4, Stages = 4, Difficulty = 2.2},
        },
    },
    -- World 2: Snowy Mountains
    {
        Id = 2,
        Name = "Snowy Mountains",
        Theme = "Snow",
        Color = Color3.fromRGB(200, 220, 255),
        Music = "rbxassetid://REPLACE_WITH_ID",
        Atmosphere = "Cold",
        Description = "Frozen peaks and icy valleys covered in eternal snow.",
        MiniWorlds = {
            {Name = "Frostpeak", Order = 1, Stages = 20, Difficulty = 1.2},
            {Name = "Glacial Valley", Order = 2, Stages = 15, Difficulty = 1.5},
            {Name = "Icefall Canyon", Order = 3, Stages = 7, Difficulty = 1.9},
            {Name = "Avalanche Summit", Order = 4, Stages = 4, Difficulty = 2.4},
        },
    },
    -- World 3: Beach Paradise
    {
        Id = 3,
        Name = "Beach Paradise",
        Theme = "Tropical",
        Color = Color3.fromRGB(255, 200, 100),
        Music = "rbxassetid://REPLACE_WITH_ID",
        Atmosphere = "Sunny",
        Description = "Tropical islands with sandy shores and crystal waters.",
        MiniWorlds = {
            {Name = "Sandy Shores", Order = 1, Stages = 20, Difficulty = 1.1},
            {Name = "Coral Reef", Order = 2, Stages = 15, Difficulty = 1.4},
            {Name = "Tropical Jungle", Order = 3, Stages = 7, Difficulty = 1.8},
            {Name = "Paradise Island", Order = 4, Stages = 4, Difficulty = 2.3},
        },
    },
    -- World 4: Forest Kingdom
    {
        Id = 4,
        Name = "Forest Kingdom",
        Theme = "Nature",
        Color = Color3.fromRGB(34, 139, 34),
        Music = "rbxassetid://REPLACE_WITH_ID",
        Atmosphere = "Natural",
        Description = "Ancient forests with mystical groves and sacred trees.",
        MiniWorlds = {
            {Name = "Ancient Forest", Order = 1, Stages = 20, Difficulty = 1.3},
            {Name = "Mystic Grove", Order = 2, Stages = 15, Difficulty = 1.6},
            {Name = "Elven Woodland", Order = 3, Stages = 7, Difficulty = 2.0},
            {Name = "Sacred Tree", Order = 4, Stages = 4, Difficulty = 2.5},
        },
    },
}

return WorldConfig
