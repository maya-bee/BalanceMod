local PlayerTracker = require("BalanceMod.Utility.PlayerTracker")

-- // Nazar // --

local Nazar = {
    Trinket = Isaac.GetTrinketIdByName("Nazar"),
    EnemiesToRemove = {},
    SwapType = 0,
}

---@param npc EntityNPC
function Nazar:OnNPCSpawn(npc) -- on npc update
    if Nazar.EnemiesToRemove[GetPtrHash(npc)] then
        local pos = npc.Position
        npc:Remove()
        if not npc:Exists() then
            Nazar.EnemiesToRemove[GetPtrHash(npc)] = nil
        end
        
        Game():SpawnParticles(pos, EffectVariant.POOF01, 1, 0)
        return
    end
    if npc.FrameCount == 0 then -- just now spawned
        if npc:IsChampion() then
            local players = Game():GetNumPlayers()
            for i = 0, players - 1 do
                local player = Isaac.GetPlayer(i)
               
                if player:HasTrinket(Nazar.Trinket) then
                    ---@diagnostic disable-next-line: param-type-mismatch
                    Isaac.Spawn(npc.Type, npc.Variant, npc.SubType, npc.Position, npc.Velocity, npc.Parent)
                    Nazar.EnemiesToRemove[GetPtrHash(npc)] = true
                    break
                end
            end
        end
    end
end

-- /////////////////// --

return function (BalanceMod)
    BalanceMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, Nazar.OnNPCSpawn)
end