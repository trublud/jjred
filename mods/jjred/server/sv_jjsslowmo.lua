sPower = class()
serverwideslowmo = false
slowmo = false
spawnhost = nil
function sPower:__init()

Network:Subscribe("setSuperJump", function(args)
    Network:Send('superjumpPlayer', args[1], args[2])
end)


end
RegisterNetEvent('jjsslowmo:setSpawnHost')
AddEventHandler('jjsslowmo:setSpawnHost', function(shost)
    if shost ~= nil then
        spawnhost = shost
        Network:Send('updateSpawnHost', spawnhost)
        TriggerClientEvent('jjsslowmo:updateSpawnHost', -1, spawnhost)
        --   TriggerClientEvent('Cyber:UpdateDeads', -1, deadPlayers)
    end
end)
RegisterNetEvent('jjsslowmo:getSpawnHost')
AddEventHandler('jjsslowmo:getSpawnHost', function()
     
    return spawnhost
end)

RegisterNetEvent('jjsslowmo:setSuperJump')
AddEventHandler('jjsslowmo:setSuperJump', function(p, enabled)
    if p ~= nil then
        Network:Send('superjumpPlayer', p, enabled)
        TriggerClientEvent('jjsslowmo:superjumpPlayer', p, enabled)
      
    end
end)