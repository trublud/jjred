--[[  puser.id
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
    ]] ---JJz
local Puser = nil

AddEventHandler("redemrp:playerLoaded", function(source, user)
    while true do
        Wait(5000)
        TriggerServerEvent('JJz:updatePlayerStats', source)
    end
end)

AddEventHandler('playerSpawned', function() 
--UpdatePlayerStats()
 end)

function round(x) return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5) end



RegisterNetEvent('JJz:sethp')
AddEventHandler("JJz:sethp", function(m1)
 local hp = m1 + GetEntityHealth(PlayerPedId(), true)

    messagealert(hp)
    if hp >= tonumber(GetEntityMaxHealth(PlayerPedId(), true)) then
        SetEntityMaxHealth(PlayerPedId(), Config.PlayerBaseHealth, 0)
        SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId(), true),  0)
       messagealert(GetEntityHealth(PlayerPedId(), true).." full health!")
                        
    else
   messagealert(GetEntityHealth(PlayerPedId(), true).." / "..GetEntityMaxHealth(PlayerPedId(), true))
   SetPedMaxHealth(PlayerPedId(),GetEntityMaxHealth(PlayerPedId())-Config.PlayerBaseHealth, 0)
   SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId(), true),  0)

      -- SetEntityMaxHealth(PlayerPedId(), Config.PlayerBaseHealth, 0)
     
        messagealert(GetEntityHealth(PlayerPedId(), true).." / "..GetEntityMaxHealth(PlayerPedId(), true))
    end
end)


RegisterNetEvent('JJz:pbuff')
AddEventHandler("JJz:pbuff", function(a1)

    if Puser ~= nil then
        Puser.id = PlayerPedId()

        if tonumber(round(Puser.maxhealth) + 100) ~=
            tonumber(round(GetEntityMaxHealth(PlayerPedId(), true))) then
            --  messageerror(a1.maxhealth)
            --  SetEntityHealth(PlayerPedId(), tonumber(a1.maxhealth), 0)
            SetEntityMaxHealth(PlayerPedId(), tonumber(round(a1.maxhealth)), 1)
            messageerror("Buff adjusting.. " .. a1.pbuff)
            messageerror("Hp buffed to " .. GetEntityHealth(PlayerPedId(), true))
            messageerror("Health buffed to " .. GetEntityMaxHealth(PlayerPedId(), true))

        end

    else
        Puser = a1
    end
end)


