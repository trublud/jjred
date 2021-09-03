RegisterServerEvent("RegisterUsableItem:bread")
AddEventHandler("RegisterUsableItem:bread", function(source)
    TriggerClientEvent('JJz:sethp', source, 20)
    
    TriggerClientEvent('JJz:messageerror', source, "Yum! ")
end)