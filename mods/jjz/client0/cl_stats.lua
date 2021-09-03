
    local update = true
    Citizen.CreateThread(function()
        
        while  not IsPedDeadOrDying(PlayerPedId()) and update  do
         
            
            if Config.PlayerInfStamina then
                RestorePlayerStamina(PlayerId(), 1.0)
           --     messagealert("me stamn")
            end
            if Config.HorseInfStamina then
             --   messagealert("HORSE")
                local horser = GetMount(PlayerPedId())
              
        
                -- get core values
                local health = Citizen.InvokeNative(0x36731AC041289BB1, horser, 0, Citizen.ResultAsInteger())
                local stamina = Citizen.InvokeNative(0x36731AC041289BB1, horser, 1, Citizen.ResultAsInteger())        
        
                -- set core values
                Citizen.InvokeNative(0xC6258F41D86676E0, horser, 0, math.clamp(health + 76, 0, 100))
                Citizen.InvokeNative(0xC6258F41D86676E0, horser, 1, math.clamp(stamina + 76, 0, 100))
             --   messagealert(stamina)
                
            end
          --  Citizen.InvokeNative("0xCB5D11F9508A928D", 1, a2, a3,
         --                        GetHashKey("UPGRADE_STAMINA_TANK_1"), 1084182731,
           --                      10, 752097756)
    --        Citizen.InvokeNative("0xCB5D11F9508A928D", 1, a2, a3, GetHashKey("UPGRADE_HEALTH_TANK_1"), 1084182731,  10, 752097756)
         --   Citizen.InvokeNative("0xCB5D11F9508A928D", 1, a2, a3, -1845241476,
          --                       1084182731, 10, 752097756)
          Citizen.Wait(100)
        end

AddEventHandler("playerSpawned", function()
    --update = true  
end)

end)
function SetGuarmaWorldhorizonActive(toggle)
    Citizen.InvokeNative(0x74E2261D2A66849A, toggle)
end

function SetWorldWaterType(waterType)
    Citizen.InvokeNative(0xE8770EE02AEE45C2, waterType)
end

function IsInGuarma()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    return x >= 0 and y <= -4096
end

local GuarmaMode = false

CreateThread(function()
    while true do
        Wait(500)

        if IsInGuarma() then
            if not GuarmaMode then
                SetGuarmaWorldhorizonActive(true);
                SetWorldWaterType(1);
                GuarmaMode = true
            end
        else
            if GuarmaMode then
                SetGuarmaWorldhorizonActive(false);
                SetWorldWaterType(0);
                GuarmaMode = false
            end
        end
    end
end)

