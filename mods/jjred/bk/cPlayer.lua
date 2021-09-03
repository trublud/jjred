PlayerStats = class()
function PlayerStats:__init(vdeaths, vkills, vmurders, vmissed, vpvpkills, vpvpdeaths)
    getter_setter(self, "deaths")
    getter_setter(self, "kills")
    getter_setter(self, "murders")
    getter_setter(self, "missed")
    getter_setter(self, "pvpkills")
    getter_setter(self, "pvpdeaths")
    self:SetDeaths(vdeaths)
   self:SetKills(vkills)
   self:SetMurders(vmurders)
   self:SetMissed(vmissed)
   self:SetPvpkills(vpvpkills)
   self:SetPvpdeaths(vpvpdeaths)

end

function PlayerStats:pGetdeaths()
    self:SetDeaths(self:Getdeaths() + 1)
    print(string.format(" Total deaths: %d", self:Getdeaths()))
end

function PlayerStats:pGetkills(amount)
    self:SetKills(self:Getkills() + amount)
    print(string.format(" kills! You now have %d total.", amount, self:Getkills()))
end
function PlayerStats:pGetmurders()
    self:SetMurders(self:Getmurders() + 1)
    print(string.format(" Total murders: %d", self:Getmurders()))
end
function PlayerStats:pGetmissed()
    self:SetMissed(self:Getmissed() + 1)
    print(string.format(" Total missed: %d", self:Getmissed()))
end
function PlayerStats:pGetpvpkills()
    self:SetPvpkills(self:Getpvpkills() + 1)
    print(string.format(" Total pvpkills: %d", self:Getpvpkills()))
end
function PlayerStats:pGetpvpdeaths()
    self:SetPvpdeaths(self:Getpvpdeaths() + 1)
    print(string.format(" Total pvpdeaths: %d", self:Getpvpdeaths()))
end
PlayerStats = PlayerStats('0',0,0,0,0,0)




PlayerPowers = class()
function PlayerPowers:__init(slowmo, superjump, attack, defense, life, stamina)
    getter_setter(self, "slowmo")
    getter_setter(self, "superjump")
    self:SetSlowmo(slowmo)
    self:SetSuperjump(superjump)
    self.jjstats = {
        stamina = false,
        superjump = false,
        statshud = false,
        popups = true,
        devtools = false
    }

    Citizen.CreateThread(function()
        local flashSpeed = JJRedConfig.flashspeed
        local veh2 = 999
        local ped = PlayerPedId()
        local crazysled = true
        while true do
    
            if self.jjstats.devtools then
                SetEveryoneIgnorePlayer(PlayerId(), true)
    
            else
                if not self.jjstats.devtools then
                    SetEveryoneIgnorePlayer(PlayerId(), false)
                end
            end
            if self.jjstats.stamina then
                SetSwimMultiplierForPlayer(self.superjumpplayer, 1.49)
                RestorePlayerStamina(self.superjumpplayer, 1.0)
                SetPedMoveRateOverride(GetPlayerPed(self.superjumpplayer), 1.15)
    
                Citizen.InvokeNative(N_0x88e32db8c1a4aa4b, self.superjumpplayer, 10)
                N_0x88e32db8c1a4aa4b(self.superjumpplayer, 10)
                if IsControlJustPressed(0, 0xD9D0E1C0) then
                   SetPlayerInvincible(player, crazysled)
                    crazysled = not crazysled
                    veh2 = -1
                    veh = -1
                   
                end
                if crazysled then
                    if IsPedDeadOrDying(ped, true) then
                        veh2 = -1
                        veh = -1
                        DeleteEntity(veh)
                        DeleteEntity(veh2)
                    else
                        if DoesEntityExist(veh2) then
                            --  TaskWarpPedIntoVehicle(ped , veh2  ,  -1  )
                            SetVehicleAutomaticallyAttaches(
                                veh2 --[[ Vehicle ]], 
                                true --[[ boolean ]], 
                                1 --[[ Any ]]
                            )
                            SetPedIntoVehicle(ped --[[ Ped ]] , veh2 --[[ Vehicle ]] ,
                                              -1 --[[ integer ]] )
                        end
                        local veh = GetVehiclePedIsUsing(ped)
                        if veh ~= 0 then
    
                            if veh2 ~= veh then
                                veh2 = veh
                            
                                SetVehicleCanBreak(
        veh --[[ Vehicle ]], 
        false --[[ boolean ]]
    )
    SetVehicleGravityAmount(
        veh --[[ Vehicle ]], 
        0 --[[ number ]]
    )
    
    SetEntityHasGravity(
        veh --[[ Entity ]], 
        false --[[ boolean ]]
    )
                                SetVehicleWheelieState(veh, 129)
                            end
                            --  TaskWarpPedIntoVehicle(ped --[[ Ped ]] , veh --[[ Vehicle ]] , -1 --[[ integer ]] )
                            SetPedIntoVehicle(ped --[[ Ped ]] , veh --[[ Vehicle ]] ,
                                              -1 --[[ integer ]] )
                            ModifyVehicleTopSpeed(veh, 44.49)
                            SetPedCanBeKnockedOffVehicle(ped --[[ Ped ]] , 1 --[[ integer ]] )
    
                            SetVehicleWheelsCanBreak(veh --[[ Vehicle ]] , false --[[ boolean ]] )
                            SetVehicleHasStrongAxles(veh --[[ Vehicle ]] , true --[[ boolean ]] )
                            SetVehicleJetEngineOn(veh --[[ Vehicle ]] , true --[[ boolean ]] )
                            SetVehicleCanBreak(veh --[[ Vehicle ]] , false --[[ boolean ]] )
                            SetAirDragMultiplierForPlayersVehicle(PlayerId() --[[ Player ]] ,
                                                                  1.0 --[[ number ]] )
                            SetVehicleForwardSpeed(veh, 44.49)
                            SetTrainSpeed(veh, 44.49)
                        end
    
                    end
                else
    
                end
    
            end
            if self.jjstats.superjump then setSuperjump(self.superjumpplayer) end
            if self.slowmo and not self.forcedslowmo and JJRedConfig.slowmopower then
                SetPedMoveRateOverride(GetPlayerPed(self.slowmoplayer), flashSpeed)
                RestorePlayerStamina(self.slowmoplayer, 1.0)
            else
                --   SetPedMoveRateOverride(GetPlayerPed(self.slowmoplayer), 1.0)
            end
    
            Citizen.Wait(0)
        end
    end)
    

end



function PlayerPowers:PlayerGetsuperjump()
    self:SetSuperjump(true)
    print("You got superjump! ")
end

function PlayerPowers:PlayerGetslowmo()
    self:SetSlowmo(true)
    print("You gotslowmo! ")
end

PlayerPowers = PlayerPowers(false, false)
