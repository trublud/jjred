--[[ puser.gold 
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
    ]] 
    local puser = nil
RegisterServerEvent('JJz:updatePlayerStats')
AddEventHandler("JJz:updatePlayerStats", function(source) 
                    local player = exports.redem_roleplay:getPlayerFromId(source)
                    puser=player
    local license = GetIdentifier(player, 'license')
  
    MySQL.ready(function()
        MySQL.Async.fetchAll(
            'SELECT killed, murders, lossed, deaths, pvpkills, pvpdeaths FROM undead WHERE id = @id',
            {['id'] = license}, function(results)
                puser.murders = results.murders
                puser.killed = results.killed
                puser.lossed = results.lossed
                puser.deaths = results.deaths
                puser.pvpdeaths = results.pvpdeaths
                puser.pvpkills = results.pvpkills
                local pbuf = puser.level + (results.killed * 0.1) -
                                 (results.murders * 0.2) -
                                 (results.pvpdeaths * 0.5) +
                                 (results.pvpkills * 0.5)
                if pbuf < 0 then pbuf = 0 end
                puser.pbuff = pbuf
                puser.maxhealth = Config.PlayerBaseHealth + puser.pbuff
                print(puser.pbuff)
            end)
        end)
    end)

--RegisterNetEvent('JJz:reward')
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
AddEventHandler("entityCreated",function(entity)
    TriggerEvent('JJz:rewardme', 2, 2)
end)
AddEventHandler("entityCreating",function(entity)
    TriggerEvent('JJz:rewardme', 3, 3)
 end)

 AddEventHandler("entityRemoved",function(entity)
    TriggerEvent('JJz:rewardme', 4, 4)
 end)


