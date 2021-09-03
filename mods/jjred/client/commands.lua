 cooldown = 0
RegisterCommand('jjsettings', function()
   -- TriggerEvent("jjred:notify", "Move me around!", 30000)
    TriggerServerEvent("jjred:addme")
    TriggerEvent("jjred:showhud")
    TriggerEvent("jjred:open")
end, false)
TriggerEvent('chat:addSuggestion', '/jjsettings', 'CoolHud Settings Menu',
             { --[[   { name="paramName1", help="param description 1" },    { name="paramName2", help="param description 2" }]] })




RegisterCommand('jjpowers', function(source, args)
    local player = source
  if args[3]~=nil then player = args[3] end
        if cooldown <= 0 then
      
            if args[1] == 'flee' then
                  Citizen.InvokeNative(0xE705309B8C6445A4, player, args[2])
            elseif args[1] == 'trainspeed' then  
                for veh in EnumerateVehicles() do
                    local modell = GetEntityModel(veh)
                    if IsThisModelATrain(GettHashKey(modell)  ) then
                        SetTrainSpeed(     veh ,      args[2] )
                    end
                end
                
            elseif args[1] == 'ignoreme' then  SetEveryoneIgnorePlayer(player, args[2])
            elseif args[1] == 'SetMaxWantedLevel' then     SetMaxWantedLevel (player, args[2])
            elseif args[1] == 'SetMaxWantedLevel2' then     SetMaxWantedLevel2 (player, args[2])
            elseif args[1] == 'SetWantedLevelMultiplier' then     SetWantedLevelMultiplier (player, args[2])
            elseif args[1] == 'SetPlayerWantedLevel' then   
               
                Citizen.InvokeNative(0xA80FF73F772ACF6A,  player --[[ Player ]],            args[2])
                Citizen.InvokeNative(0xD4958E8CF0DE0DD0,3)
                print(GetPlayerWantedLevel(player))  
                  SetPlayerWantedLevel(player, args[2], false)
            elseif args[1] == 'deadeye' then 
                 for i = 1,100,1 
                do 
                    print(i)
                    Citizen.InvokeNative(0xD4958E8CF0DE0DD0,i)
                    Citizen.InvokeNative(0x2797B8D66DD0EBB8, 
                        player --[[ Player ]], 
                        i --[[ integer ]], 
                        true --[[ boolean ]]
                    ) 
                end
                Citizen.InvokeNative(0xF0FE8E790BFEB5BB,player ,  args[2]  )
            elseif args[1] == 'slowmo' then
        TriggerEvent("jjsslowmo:slowmoMe")
        cooldown=(JJRedConfig.slowmopowertime * 100) + (JJRedConfig.powercooldown*100)
    elseif args[1] == 'heat' then
        TriggerEvent("jjsslowmo:heatvisionPlayer")
        cooldown=(JJRedConfig.heatvisiontime * 100) + (JJRedConfig.powercooldown*100)
    elseif args[1] == 'night' then
        TriggerEvent("jjsslowmo:nightvisionPlayer")
        cooldown=(JJRedConfig.nightvisiontime * 100) + (JJRedConfig.powercooldown*100)
    end

    Citizen.CreateThread(function()
        while cooldown > 0  do
            Citizen.Wait(0)
            cooldown = cooldown - 1
        end
    end)
else
    TriggerEvent("jjred:notify", "Power still cooling down! "..cooldown .." left", 3000)
 
end

end, false)
TriggerEvent('chat:addSuggestion', '/jjpowers', 'JJs Powers', {
    {name = "heat", help = "heat vision"},
    {name = "night", help = "night vision"},
    {name = "slowmo", help = "slow motion"}
})
--[[
RegisterKeyMapping('jjsettings', 'Open CoolHud Settings', 'keyboard', 'k')

RegisterKeyMapping('jjsettings', 'Open CoolHud Settings', 'keyboard', JJRedConfig.Keys.SettingsKey)
RegisterKeyMapping('jjpowers heat', 'Heat Vision', 'keyboard', JJRedConfig.Keys.HeatVision)
RegisterKeyMapping('jjpowers night', 'Night Vision', 'keyboard', JJRedConfig.Keys.NightVision)
RegisterKeyMapping('jjpowers slowmo', 'Slow Motion', 'keyboard', JJRedConfig.Keys.SlowMo)
]]
--[[RegisterKeyMapping('say hi', 'Say hi', 'keyboard', 'o') 
RegisterCommand('+handsup', function()
    handsUp = true
end, false)
RegisterCommand('-handsup', function()
    handsUp = false
end, false)
local handsUp = false
CreateThread(function()
    while true do
        Wait(0)
        if handsUp then
            TaskHandsUp(PlayerPedId(), 250, PlayerPedId(), -1, true)
        end
    end
end)]]
