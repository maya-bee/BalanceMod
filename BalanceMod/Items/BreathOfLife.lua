local PlayerTracker = require("BalanceMod.Utility.PlayerTracker")
local ChargeBars = require("BalanceMod.Utility.ChargeBars")

-- // Breath of Life // --

local BreathOfLife = {
    Item = Isaac.GetItemIdByName("Breath of Life"),
    IFrames = 50,
    InvinciblePlayers = {},
    ChargeBarPlayers = {}
}

function BreathOfLife:OnUpdate()
    for _, player in ipairs(PlayerTracker:GetPlayers()) do
        if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == BreathOfLife.Item then
            local playerIndex = PlayerTracker:GetPlayerIndex(player)
            if player:GetActiveCharge() < 1 then -- they are out of charge on  breath of life, give them iframes
                if BreathOfLife.InvinciblePlayers[playerIndex] == nil then
                    BreathOfLife.InvinciblePlayers[playerIndex] = true

                    player:SetMinDamageCooldown(BreathOfLife.IFrames)
                    local sprite = Sprite()
                    sprite:Load(ChargeBars.DefaultSprite, true)
                    local RenderFrames = BreathOfLife.IFrames * 2
                    BreathOfLife.ChargeBarPlayers[playerIndex] = ChargeBars:MakeCustomChargeBar(player, sprite, RenderFrames, RenderFrames, -1)
                end
            else -- its either charged or recharging
                if BreathOfLife.ChargeBarPlayers[playerIndex] ~= nil then
                    ChargeBars:DeleteCustomChargeBar(player, BreathOfLife.ChargeBarPlayers[playerIndex])
                end

                BreathOfLife.InvinciblePlayers[playerIndex] = nil
                BreathOfLife.ChargeBarPlayers[playerIndex] = nil
            end
        end
    end
end

-- /////////////////// --

return function (BalanceMod)
    BalanceMod:AddCallback(ModCallbacks.MC_POST_UPDATE, BreathOfLife.OnUpdate)
    if EID then
        EID:addCollectible(BreathOfLife.Item, "Isaac will become invincible for a short time when his charge is fully depleted#Deplete charge by holding the active item button#{{Warning}} Holding for too long after becoming invincible will deal damage to Isaac every second#Charge will regenerate when active item button not held#Touching enemies while invincible summons a beam of light to damage them") 
    end
end