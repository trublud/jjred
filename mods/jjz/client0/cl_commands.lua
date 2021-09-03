local ScoreboardIsOpen = false
RegisterCommand('JJui', function(source, args, raw)
    ScoreboardIsOpen = not ScoreboardIsOpen

    SendNUIMessage({type = 'toggleScoreboard'})
end, false)
RegisterCommand("JJbg", function(source, args, rawCommand) -- bodyguard
    TriggerEvent("JJz:createGuard")
end, false)

RegisterCommand('JJ?', function(source, args, rawCommand)
     messageerror("Hp buffed to " .. GetEntityHealth(PlayerPedId(), true))   
end)

RegisterCommand('JJhp', function(source, args, rawCommand)
    SetEntityMaxHealth(PlayerPedId(),tonumber(104), 0)
    SetEntityHealth(PlayerPedId(), tonumber(66),true )
end)

RegisterCommand('JJdie', function(source, args, rawCommand)
    SetEntityHealth(PlayerPedId(), 0)
end)

RegisterCommand('tp', function(source, args)
    SetEntityCoords(PlayerPedId(), args[1], args[2], args[3], 0,0,0, false)
    Citizen.InvokeNative(0x74E2261D2A66849A,true)
    Citizen.InvokeNative(0xE8770EE02AEE45C2,1)
    Citizen.InvokeNative(0xA657EC9DBC6CC900,GetHashKey("guarma"))
end, restricted)
RegisterCommand("ptp", function(source, args)
    TriggerEvent("redemrp_properties:adminTeleport", source, tonumber(args[1]))
end, false)
RegisterCommand("fix", function(source, args)
    TriggerEvent("redemrp_properties_kitchenHeal:getOwnership")
end, false)
