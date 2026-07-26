-- InventorySystem.lua
-- Manages player inventory (trails, auras, items)

local InventorySystem = {}
local playerInventories = {}

-- Initialize player inventory
function InventorySystem:InitializePlayer(player)
    local userId = player.UserId
    playerInventories[userId] = {
        Trails = {},
        Auras = {},
        Treadmills = {},
        Multipliers = {},
        SoundPacks = {},
        Other = {},
    }
    
    -- Add starting items
    self:AddItem(player, "Trail", "Default", true)
    self:AddItem(player, "Aura", "Default", true)
end

-- Add item to inventory
function InventorySystem:AddItem(player, itemType, itemName, equip)
    local userId = player.UserId
    if not playerInventories[userId] then
        self:InitializePlayer(player)
    end
    
    local category = self:GetCategory(itemType)
    if not category then return false end
    
    table.insert(playerInventories[userId][category], {
        Name = itemName,
        Type = itemType,
        Equipped = equip or false,
        AddedAt = tick(),
    })
    
    return true
end

-- Remove item from inventory
function InventorySystem:RemoveItem(player, itemType, itemName)
    local userId = player.UserId
    if not playerInventories[userId] then return false end
    
    local category = self:GetCategory(itemType)
    if not category then return false end
    
    for i, item in ipairs(playerInventories[userId][category]) do
        if item.Name == itemName then
            table.remove(playerInventories[userId][category], i)
            return true
        end
    end
    
    return false
end

-- Get category for item type
function InventorySystem:GetCategory(itemType)
    local categories = {
        ["Trail"] = "Trails",
        ["Aura"] = "Auras",
        ["Treadmill"] = "Treadmills",
        ["Multiplier"] = "Multipliers",
        ["SoundPack"] = "SoundPacks",
    }
    return categories[itemType]
end

-- Equip item
function InventorySystem:EquipItem(player, itemType, itemName)
    local userId = player.UserId
    if not playerInventories[userId] then return false end
    
    local category = self:GetCategory(itemType)
    if not category then return false end
    
    -- Unequip all items of this type
    for _, item in ipairs(playerInventories[userId][category]) do
        item.Equipped = false
    end
    
    -- Equip the selected item
    for _, item in ipairs(playerInventories[userId][category]) do
        if item.Name == itemName then
            item.Equipped = true
            return true
        end
    end
    
    return false
end

-- Get equipped item
function InventorySystem:GetEquippedItem(player, itemType)
    local userId = player.UserId
    if not playerInventories[userId] then return nil end
    
    local category = self:GetCategory(itemType)
    if not category then return nil end
    
    for _, item in ipairs(playerInventories[userId][category]) do
        if item.Equipped then
            return item
        end
    end
    
    return nil
end

-- Get all items of type
function InventorySystem:GetItems(player, itemType)
    local userId = player.UserId
    if not playerInventories[userId] then return {} end
    
    local category = self:GetCategory(itemType)
    if not category then return {} end
    
    return playerInventories[userId][category] or {}
end

-- Get full inventory
function InventorySystem:GetInventory(player)
    local userId = player.UserId
    return playerInventories[userId] or {}
end

-- Check if player has item
function InventorySystem:HasItem(player, itemType, itemName)
    local userId = player.UserId
    if not playerInventories[userId] then return false end
    
    local category = self:GetCategory(itemType)
    if not category then return false end
    
    for _, item in ipairs(playerInventories[userId][category]) do
        if item.Name == itemName then
            return true
        end
    end
    
    return false
end

return InventorySystem
