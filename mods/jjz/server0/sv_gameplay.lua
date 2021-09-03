--[[ user.gold 
	puser.group 
	puser.firstname 
	puser.lastname 
	puser.xp 
	puser.level
	puser.job 
    puser.jobgrade 
    puser.murders
    puser.killed
    puser.lossed
    puser.deaths
    puser.pvpdeaths
    puser.pvpkills
    ]] local puser = nil
RegisterServerEvent('JJz:updatePlayerStats')
AddEventHandler("JJz:updatePlayerStats", function()
    local _source = source
    local player = nil
    player = exports.redem_roleplay:getPlayerFromId(_source)
    puser = player
    local license = GetIdentifier(_source, 'license')

    MySQL.ready(function()
        MySQL.Async.fetchAll(
            'SELECT killed, murders, lossed, deaths, pvpkills, pvpdeaths FROM undead WHERE id = @id',
            {['id'] = license}, function(results)
                puser = results[1]
                local a1 = nil
                TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
                    if user ~= nil then a1 = user.getLevel() end
                end)
                if a1 ~= nil then
                    local pbuf = a1 + (puser.killed * 0.1) -
                                     (puser.murders * 0.2) -
                                     (puser.pvpdeaths * 0.5) +
                                     (puser.pvpkills * 0.5)
                    if pbuf < 0 then pbuf = 0 end
                    puser.pbuff = pbuf
                    puser.maxhealth = puser.pbuff
                end
                print(puser.maxhealth)
                TriggerClientEvent('JJz:pbuff', -1, puser)
            end)
    end)
end)


AddEventHandler("entityCreated", function(entity) print("$") end)
AddEventHandler("entityCreating", function(entity) print("^") end)

AddEventHandler("entityRemoved", function(entity) print("*") end)


  


-- RegisterNetEvent('JJz:reward')
--[[RegisterServerEvent("JJz:reward")
AddEventHandler("JJz:reward", function(amount, xp)
    local _source = source
    local _amount = tonumber(string.format("%.2f", amount))
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        puser = user
        user.addMoney(_amount)
        user.addXP(xp)
    end)
end)
]]