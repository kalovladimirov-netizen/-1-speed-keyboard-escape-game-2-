-- ShopSystem.lua
-- Manages game shop and purchases

local ShopSystem = {}

local ShopItems = {
    {
        Id = 1,
        Name = "Speed Treadmill x2",
        Type = "Treadmill",
        Price = 100,
        Currency = "Wins",
        Multiplier = 2,
        Description = "Doubles your speed gain",
    },
    {
        Id = 2,
        Name = "Speed Treadmill x5",
        Type = "Treadmill",
        Price = 500,
        Currency = "Wins",
        Multiplier = 5,
        Description = "5x speed multiplier",
    },
    {
        Id = 3,
        Name = "Speed Treadmill x10",
        Type = "Treadmill",
        Price = 2000,
        Currency = "Wins",
        Multiplier = 10,
        Description = "10x speed multiplier",
    },
    {
        Id = 4,
        Name = "Wins Multiplier x2",
        Type = "Multiplier",
        Price = 250,
        Currency = "Lumens",
        Multiplier = 2,
        Description = "Double wins earned",
        Duration = 3600,
    },
    {
        Id = 5,
        Name = "Lumens Multiplier x3",
        Type = "Multiplier",
        Price = 500,
        Currency = "Lumens",
        Multiplier = 3,
        Description = "Triple lumens earned",
        Duration = 3600,
    },
    {
        Id = 6,
        Name = "Red Trail",
        Type = "Trail",
        Price = 50,
        Currency = "Wins",
        Description = "Red particle trail",
    },
    {
        Id = 7,
        Name = "Blue Aura",
        Type = "Aura",
        Price = 75,
        Currency = "Wins",
        Description = "Blue glowing aura",
    },
}

-- Get all shop items
function ShopSystem:GetShopItems()
    return ShopItems
end

-- Get item by ID
function ShopSystem:GetItem(itemId)
    for _, item in ipairs(ShopItems) do
        if item.Id == itemId then
            return item
        end
    end
    return nil
end

-- Get items by type
function ShopSystem:GetItemsByType(itemType)
    local items = {}
    for _, item in ipairs(ShopItems) do
        if item.Type == itemType then
            table.insert(items, item)
        end
    end
    return items
end

-- Check if player can afford item
function ShopSystem:CanAfford(player, itemId, getBalance)
    local item = self:GetItem(itemId)
    if not item then return false end
    
    local balance = getBalance(item.Currency)
    return balance >= item.Price
end

-- Purchase item
function ShopSystem:PurchaseItem(player, itemId, spend, addItem)
    local item = self:GetItem(itemId)
    if not item then return false, "Item not found" end
    
    local success, remaining = spend(item.Currency, item.Price)
    if not success then return false, "Not enough currency" end
    
    addItem(item)
    return true, "Purchased " .. item.Name
end

return ShopSystem
