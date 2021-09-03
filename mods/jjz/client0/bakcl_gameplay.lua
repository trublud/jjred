--[[  
	puser.gold 
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
    Puser = nil

AddEventHandler("redemrp:playerLoaded",function(source, user)
                    UpdatePlayerStats()
                 end)

function UpdatePlayerStats()

    local player = source
    local license = GetIdentifier(player, 'license')
    TriggerServerEvent('JJz:updatePlayerStats', player)
    print(Puser.pbuff)
    TriggerEvent('JJz:rewardme', 1, 1)
end

RegisterNetEvent('JJz:rewardme')
--RegisterServerEvent("JJz:reward")
AddEventHandler("JJz:rewardme", function(amount, xp)
messagealert("Daily reward given!")
    local _amount = tonumber(string.format("%.2f", amount))
        Puser = user
        Puser.addMoney(_amount)
        Puser.addXP(xp)
    end)


CreateThread(function()
    DoorSystemSetDoorState("p_door_val_bank00_lx", true)
    DoorSystemSetDoorState("p_door_val_bank00_rx", true)
    DoorSystemSetDoorState("p_door_val_bank01", true)
    DoorSystemSetDoorState("p_door_val_bank02", true)
    DoorSystemSetDoorState("p_door_val_bankvault", true)
    while true do
        Wait(5000)
        updatecounts()
    end
end)
