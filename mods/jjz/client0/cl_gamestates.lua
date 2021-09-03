CreateThread(function()
    while true do
        DoorSystemSetDoorState("p_door_val_bank00_lx", true)
        DoorSystemSetDoorState("p_door_val_bank00_rx", true)
        DoorSystemSetDoorState("p_door_val_bank01", true)
        DoorSystemSetDoorState("p_door_val_bank02", true)
        DoorSystemSetDoorState("p_door_val_bankvault", true)
        -- DisplayHud(true)
        -- DisplayCash(false)

        SetDispatchIdealSpawnDistance(30)
        TriggerEvent("pNotify:SetQueueMax", "left", 6)
        SetPlayerHealthRechargeMultiplier(PlayerPedId(), Config.PlayerHealthRegen)
        SetAiWeaponDamageModifier(Config.AiWeaponDamageModifier)
        SetAiMeleeWeaponDamageModifier(Config.AiMeleeWeaponDamageModifier)
        SetPlayerMeleeWeaponDamageModifier(Config.PlayerMeleeWeaponDamageModifier)
        --SetPlayerMeleeWeaponDefenseModifier(Config.PlayerMeleeWeaponDefenseModifier)
        Wait(0)
        local i = 0
        while i < 15 do
            i = i + 1
            EnableDispatchService(i, true)
        end
        --  DisplayRadar(true)
        
        --  SetRandomTrains(true)

        Citizen.Wait(1)
       --[[ for veh in EnumerateVehicles() do
            Citizen.Wait(1)
            if IsThisModelATrain(GetEntityModel(veh)) then
                local train = veh
                BlipAddForEntity2(4044460928, train, 0.1)
                --   local blip = BlipAddForCoord(4044460928, GetEntityCoords(train))
                SetBlipNameFromPlayerString(blip, "Train") -- Name of the Blip
                -- SetBlipScale(blip, 0.2) -- Scale of the Blip
                blip = RemoveBlip()
                Citizen.Wait(5)
            end
        end]]
        SetEntityMaxHealth(PlayerPedId(), Config.PlayerBaseHealth, 0)
    end
end)
