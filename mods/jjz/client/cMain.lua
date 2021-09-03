cMain = class() 
 spawns = {}
--    exports.redemrp_progressbars:DisplayProgressBar(5000, "Cooking...")
function cMain:__init()
    self.ZPlayer = LocalPlayer:GetPlayer()
    self.ZPlayer.id = LocalPlayer:GetUniqueId()
    self.ZoneBlip = nil
    self.CurrentZone = nil
    self.Undead = {}
    self.Zs = {}
    self.PPeds = {}
    self.Disposal = {}
  

    Network:Send('PedSpawned',
                 {self.ZPlayer, self.ZPlayer.name, self.ZPlayer.id})
    local players = cPlayers:GetPlayers()
    for id, aplayer in pairs(players) do

        local ped = aplayer:GetPed()
        if ped:Exists() then

            --  self:CheckPlayerVisuals(player, ped)
        end

    end

    Network:Subscribe('JJz:setZone', function(zone)
        print("zoned")
        if self.CurrentZone and zone and self.CurrentZone.name == zone.name then
            return
        end

        if self.ZoneBlip then RemoveBlip(self.ZoneBlip) end

     --   cMain:ClearPedsInZone(self.CurrentZone)
       -- cMain:ClearPedsInZone(zone)

        self.CurrentZone = zone

        if not zone then return end

        if zone.radius then
            self.ZoneBlip = cMain:BlipAddForRadius(Config.ZoneBlipSprite,
                                                   zone.x, zone.y, zone.z,
                                                   zone.radius)
            cMain:SetBlipNameFromPlayerString(self.ZoneBlip, CreateVarString(10,
                                                                             'LITERAL_STRING',
                                                                             'Undead Infestation'))
            Events:Fire("NOTIFY",
                        "An undead infestation has appeared in " .. zone.name)
        end
    end)

    self.slowmo_key = Control.SpecialAbility
    -- First tell KeyPress to look for this key being pressed
    for k, switzkeys in pairs(Control) do KeyPress:Subscribe(switzkeys) end

    KeyPress:Subscribe(self.slowmo_key)
    Events:Subscribe('KeyUp', function(args)
        print(args.key)
        self:KeyUp(args)
    end)

    function cMain:KeyUp(args)
        print("key pressed " .. args.key)
        -- Hide welcome message when key is pressed. You can also do this just in JavaScript, but we are showing more API here. :)
        if args.key == self.slowmo_key then
            self.SlowMo(LocalPlayer:GetPlayerId())
            -- print("key pressed!!")
        end
    end

    Network:Subscribe('JJz/createGuard', function() self:createbody() end)
    Network:Subscribe('JJz/updateScoreboard', function(results)
        SendNUIMessage({type = 'updatehp', php = GetEntityHealth(PlayerPedId())})
        SendNUIMessage({type = 'updatezkills', ps = results[1].killed})
        SendNUIMessage({type = 'updatemissed', ps = results[1].lossed})
        SendNUIMessage({type = 'updatemurders', ps = results[1].murders})
        SendNUIMessage({
            type = 'updateScoreboard',
            scores = json.encode(results)
        })
    end)
    Network:Subscribe('JJz/updateTotalUndeadKilled', function(total)
        SendNUIMessage({type = 'updateTotalUndeadKilled', total = total})
    end)
    Network:Subscribe('JJz/messageerror',
                      function(msg) self:messageerror(msg) end)
    Network:Subscribe('JJz/message', function(msg) self:message(msg) end)
    Network:Subscribe('JJz/messagealert',
                      function(msg) self:messagealert(msg) end)

    function cMain:updatecounts()
        SendNUIMessage({
            type = 'updatecount',
            ps = #self.PPeds,
            zs = #self.Zs,
            php = GetEntityHealth(PlayerPedId())
        })
    end

    function cMain:CreatePed_2(modelHash, x, y, z, heading, isNetwork,
                               thisScriptCheck, p7, p8)
        return Citizen.InvokeNative(0xD49F9B0955C367DE, modelHash, x, y, z,
                                    heading, isNetwork, thisScriptCheck, p7, p8)
    end

    function cMain:SetPedDefaultOutfit(ped, p1)
        Citizen.InvokeNative(0x283978A15512B2FE, ped, p1)
    end

    function cMain:SetRandomOutfitVariation(ped, p1)
        Citizen.InvokeNative(0x283978A15512B2FE, ped, p1)
    end

    function cMain:BlipAddForEntity2(blip, entity, scale)
        blippy = Citizen.InvokeNative(0x23f74c2fda6e7c61, blip, entity)
        SetBlipScale(blippy, scale)

        return blippy
        --   return Citizen.InvokeNative(0x23f74c2fda6e7c61, blip, entity)
    end

    function cMain:BlipAddForRadius(blipHash, x, y, z, radius)
        return Citizen.InvokeNative(0x45F13B7E0A15C880, blipHash, x, y, z,
                                    radius)
    end

    function cMain:SetBlipNameFromPlayerString(blip, playerString)
        return Citizen.InvokeNative(0x9CB1A1623062F402, blip, playerString)
    end


 
    function cMain:IsUndead(ped)
        local model = GetEntityModel(ped)

        for _, undead in ipairs(UndeadPeds) do
            if model == GetHashKey(undead.model) then return true end
        end

        return false
    end

    function cMain:ShouldBecomeUndead(ped)
        print("me")
        if IsPedInGroup(ped) then return false end
        print("me1")
        if GetPedRelationshipGroupHash(ped) == GetHashKey('notdead') then
            return false
        end
        print("me2")
        if not IsPedHuman(ped) then return false end
        print("me3")
        local ped1Coords = GetEntityCoords(ped)
        print("me4")
        if cMain:GetNearbyPeds(ped, ped1Coords.x, ped1Coords.y, ped1Coords.z, 4) >
            2 then return false end
        print("me5")
    --    if not cMain:IsInZone(ped, self.CurrentZone) then return false end
        print("Make Z")
        return true
    end

    function cMain:ShouldCleanUp(ped1)
        local ped1Coords = GetEntityCoords(ped1)

        for _, player in ipairs(GetActivePlayers()) do
            local ped2 = GetPlayerPed(player)
            local ped2Coords = GetEntityCoords(ped2)

            if #(ped1Coords - ped2Coords) <= Config.DespawnDistance then
                return false
            end

            if HasEntityClearLosToEntity(ped2, ped1, 1) then
                return false
            end
        end
        cMain:removefromTable(self.PPeds, ped1)
            return true
    end

 

    function cMain:messageerror(msg)
        exports.pNotify:SendNotification(
            {
                text = msg,
                type = "error",
                timeout = math.random(1000, 4000),
                layout = "centerLeft",
                queue = "left"
            })
    end
    function cMain:message(msg)
        exports.pNotify:SendNotification(
            {
                text = msg,
                type = "info",
                timeout = math.random(1000, 4000),
                layout = "topRight",
                queue = "left"
            })
    end
    function cMain:messagealert(msg)
        exports.pNotify:SendNotification(
            {
                text = msg,
                type = "success",
                timeout = math.random(1000, 4000),
                layout = "centerRight",
                queue = "left"
            })
    end

    function cMain:CheckAi()
        for ped in cSpawnz:EnumeratePeds() do
            if cSpawnz:InRangeofPlayer(ped, Config.InRangeofPlayer) then end
        end

    end

    self.playerdead = false
    function cMain:PlayerDead(ped)

        if not self.Disposal[ped] then
            local killer = GetPedSourceOfDeath(ped)
            local thisplayer = PlayerPedId()
            if ped == thisplayer then
                -- this playerdying
                if not playerdead then
                    playerdead = true
                    if killer == thisplayer then
                        TriggerServerEvent('JJz:playerKilledBySelf')
                        messageerror("Died by Suicide!")

                    else -- not by suicide
                        TriggerServerEvent('JJz:playerKilled')
                        messageerror("Died!") -- player died
                    end
                end
            end
            if ped ~= thisplayer then -- other player died
                if killer == thisplayer then

                    TriggerServerEvent('JJz:playerKilledPvp')
                    messageerror("Died by You!")
                    self.Disposal[ped] = ped

                else -- other pelayer died not by you
                    messageerror("Died by something else!") -- other player died
                    TriggerServerEvent('JJz:playerKilled')
                end
            end
        end
    end

    function cMain:PedDead(ped)
        local thisplayer = PlayerPedId()
        local killer = GetPedSourceOfDeath(ped)
        if killer == thisplayer then -- you killed innocent
            if not self.Disposal[ped] then
                TriggerServerEvent('JJz:playerKilledInnocent')

                messagealert("Murderer!!")
                removeafter(ped, 30000)
                self.Disposal[ped] = ped
                -- self.Undead[ped] = true
            end

        else -- not by you

            -- ped died
            if self.Undead[killer] then
                if not self.Disposal[ped] then
                    messagealert("Zombie Killed Townfolk!") -- Z died
                    TriggerServerEvent('JJz:townfolkKilledByUndead')
                    removeafter(ped, 30000)
                    self.Disposal[ped] = ped
                    -- self.Undead[ped] = true
                end
            else
                if not self.Disposal[ped] then
                    messagealert("Townfolk Died!") -- Z died
                    TriggerServerEvent('JJz:townfolkKilled')
                    removeafter(ped, 30000)
                    self.Disposal[ped] = ped
                    -- self.Undead[ped] = true
                end

            end
        end

        if not self.Undead[ped] then self.Undead[ped] = true end
    end

    function cMain:ZDead(ped)
        local thisplayer = PlayerPedId()
        local killer = GetPedSourceOfDeath(ped)
        if killer == thisplayer then -- you killed Z      
            if not self.Disposal[ped] then
                TriggerServerEvent('JJz:playerKilledUndead')
                messagealert("Killed a  Z!!")

                removeafter(ped, 30000)
                self.Disposal[ped] = ped
                self.Undead[ped] = false

            end

        else -- not by you

            if not self.PPeds[killer] then
                if not self.Disposal[ped] then
                    message("Zombie Died!") -- Z died
                    removeafter(ped, 30000)
                    self.Disposal[ped] = ped
                    self.Undead[ped] = false
                end

            else
                if self.Disposal[ped] then
                    message("Townfolk killed a Zombie!") -- Z died
                    removeafter(ped, 30000)
                    self.Disposal[ped] = ped
                    self.Undead[ped] = false
                end

            end

        end
        --  self.Undead[ped] = nil
        SetPedAsNoLongerNeeded(ped)

    end

    function cMain:CheckDead()

        if not IsPedDeadOrDying(PlayerPedId()) then
            playerdead = false
            if self.Disposal[ped] then self.Disposal[ped] = nil end
        end
        local thisplayer = PlayerPedId()
        for ped in cSpawnz:EnumeratePeds() do
            if IsPedHuman(ped) then -- InRangeofPlayer(ped, 200 ) and 
                if not IsPedDeadOrDying(ped) and IsPedAPlayer(ped) then
                    playerdead = false
                    self.Disposal[ped] = nil
                end
                -- if self.Disposal[ped] then return end
                --   if not IsPedDeadOrDying(ped) then return end
                local pedisz = false
                if self.Zs[ped] or cMain:IsUndead(ped) then
                    if not self.Zs[ped] then
                        self.Zs[ped] = ped
                    end
                    pedisz = true
                end
                if IsPedDeadOrDying(ped) then
                    --    message("2")
                    if IsPedAPlayer(ped) then PlayerDead(ped) end
                    if not IsPedAPlayer(ped) then
                        --   message("3")
                        if self.Undead[ped] or pedisz then -- is a Z 
                            self.ZDead(ped)
                        else -- is not a Z 
                            PedDead(ped)
                        end
                        -- PedDead(ped)
                    end
                end
            end
        end
    end

    function cMain:UpdateUndead(ped)

        cMain:CheckDead()
        if IsPedDeadOrDying(ped) then
            if self.Undead[ped] then
                if GetPedSourceOfDeath(ped) == PlayerPedId() then
                    --     TriggerServerEvent('JJz:playerKilledUndead')
                end

                self.Undead[ped] = nil
            end

            SetPedAsNoLongerNeeded(ped)
        elseif not self.Undead[ped] then

            self.Undead[ped] = true

        end
        if cMain:ShouldCleanUp(ped) then
            if self.Disposal[ped] == nil then
                self.Disposal[ped] = ped
            end
            cMain:DelEnt(ped)

        end
    end

 
    function cMain:CheckLives(ped)
        local thisplayer = PlayerPedId()
        if IsPedDeadOrDying(ped) then
            local killer = GetPedSourceOfDeath(ped)
            if ped == thisplayer then
                -- player dying
            else

                if self.PPeds[ped] then
                    self.PPeds[ped].dead = true
                    self.PPeds[ped].lasthp = 0
                    self.PPeds[ped].lasthp = 0
                    self.PPeds[ped].attacker = killer
                else
                    -- HOW??
                end

                if killer == thisplayer then -- you killed something
                    if self.PPeds[ped] ~= nil and self.PPeds[ped].type ==
                        "townfolk" then

                        if not self.Disposal[ped] then
                            TriggerServerEvent('JJz:playerKilledInnocent')
                            messagealert("Killed a townfolk!!")
                            removeafter(ped, 30000)
                            self.Disposal[ped] = ped

                        end
                    elseif self.PPeds[ped] ~= nil and self.PPeds[ped].type ==
                        "zombie" then

                        if not self.Disposal[ped] then
                            TriggerServerEvent('JJz:playerKilledUndead')
                            messagealert("Killed a  Z!!")
                            removeafter(ped, 30000)
                            self.Disposal[ped] = ped

                        end
                    elseif IsPedAPlayer(ped) then
                        TriggerServerEvent('JJz:playerKilledPvp')
                        messagealert("Killed a Player!!!")

                    end

                else -- not by you
                    if self.PPeds[killer] ~= nil and self.PPeds[killer].type ==
                        "zombie" then
                        if self.PPeds[ped].type == "townfolk" then

                            if not self.Disposal[ped] then
                                --     TriggerServerEvent('JJz:playerKilledInnocent')
                                messagealert("Zombie a townfolk!!")
                                removeafter(ped, 30000)
                                self.Disposal[ped] = ped

                            end
                        elseif self.PPeds[ped].type == "zombie" then

                            if not self.Disposal[ped] then
                                --   TriggerServerEvent('JJz:playerKilledUndead')
                                messagealert("Z V Z!!")
                                removeafter(ped, 30000)
                                self.Disposal[ped] = ped

                            end
                        elseif isPlayerPed(ped) then
                            --  TriggerServerEvent('JJz:playerKilledPvp')
                            messagealert("Zombie Killed a Player!!!")

                        end
                    elseif self.PPeds[killer] ~= nil and self.PPeds[killer].type ==
                        "townfolk" then
                        if self.PPeds[ped].type == "zombie" then
                            if not self.Disposal[ped] then
                                --     TriggerServerEvent('JJz:playerKilledInnocent')
                                messagealert("Townfolk a Zombie!!")
                                removeafter(ped, 30000)
                                self.Disposal[ped] = ped

                            end
                        elseif self.PPeds[ped] ~= nil and self.PPeds[ped].type ==
                            "townfolk" then

                            if not self.Disposal[ped] then
                                --   TriggerServerEvent('JJz:playerKilledUndead')
                                messagealert("Townfolk V Townfolk!!")
                                removeafter(ped, 30000)
                                self.Disposal[ped] = ped

                            end
                        elseif isPlayerPed(ped) then
                            --   TriggerServerEvent('JJz:playerKilledPvp')
                            messagealert("Townfolk Killed a Player!!!")

                        end

                    end
                end
            end

            --  self.Undead[ped] = nil
            SetPedAsNoLongerNeeded(ped)

        else
            if self.PPeds[ped] ~= nil then
                if GetEntityHealth(ped) < self.PPeds[ped].lasthp or
                    HasEntityBeenDamagedByAnyPed(ped) then
                    -- PED DAMAGED!
                    -- HasEntityBeenDamagedByEntity(ped,attacker)
                    for k, v in pairs(self.PPeds) do
                        if k == "pedid" then
                            if HasEntityBeenDamagedByEntity(ped, v) and
                                not self.PPeds[ped].attacker == ped then
                                -- found attacker  v
                                self.PPeds[ped].attacker = ped
                                messagealert(v .. " attacked" .. ped)
                            end
                        end

                    end
                    self.PPeds[ped].lasthp = GetEntityHealth(ped)
                end
            end
        end
    end

  

    function cMain:createbody() -- Function to create the ped

        local undead = UndeadPeds[math.random(#UndeadPeds)]
        local model = GetHashKey(undead.model)

        RequestModel(model)
        while not HasModelLoaded(model) do Citizen.Wait(1) end

        ploc = GetEntityCoords(PlayerPedId())
        -- CREATE_PED
        local ped --[[ Ped ]] =
            CreatePed(model --[[ Hash ]] , ploc.x --[[ number ]] , ploc.y --[[ number ]] ,
                      ploc.z --[[ number ]] , 0 --[[ number ]] , true --[[ boolean ]] ,
                      false --[[ boolean ]] , false --[[ boolean ]] , false --[[ boolean ]] )

        SetPedOutfitPreset(ped, undead.outfit)

        if Config.ShowBlips then cMain:BlipAddForEntity2(0x19365607, ped, 0.01) end

        local walkingStyle = Config.WalkingStyles[math.random(
                                 #Config.WalkingStyles)]
        Citizen.InvokeNative(0x923583741DC87BCE, ped, walkingStyle[1])

        SetModelAsNoLongerNeeded(model)

        -- SHOTGUN

        GiveWeaponToPed_2(ped, 0x31B7B9FE, 1000, true, true, 1, false, 0.5, 1.0,
                          1.0, true, 0, 0)
        SetPedAmmo(ped, 0x90083D3B, 2000)

        -- GiveWeaponToPed_2(ped, 0x1086D041, 10, true, true, 1, false, 0.5, 1.0, 1.0,  true, 0, 0) -- JAWBONE KNIFE

        --  GiveWeaponToPed_2(ped, 0x63F46DE6, 1, true, true, 1, false, 0.5, 1.0, 1.0, true, 0, 0)  -- springfield
        --	SetPedAmmo(ped, 0x63F46DE6, 20) -- springfield
        SetPedCombatMovement(ped, 3)
        SetPedAsCop(ped, true)
        SetPedHearingRange(ped, Config.MaxAttackRangeTownfolk)
        SetPedSeeingRange(ped, Config.MaxAttackRangeTownfolk)
        SetPedRelationshipGroupDefaultHash(ped, 'notdead')
        SetPedRelationshipGroupHash(ped, 'notdead')
        SetRelationshipBetweenGroups(6, 'undead', 'notdead')
        SetRelationshipBetweenGroups(6, 'notdead', 'undead')
        SetRelationshipBetweenGroups(6, 'undead', PLAYER)
        SetRelationshipBetweenGroups(6, PLAYER, 'undead')
        SetRelationshipBetweenGroups(1, 'notdead', PLAYER)
        SetRelationshipBetweenGroups(1, PLAYER, 'notdead')
        -- messagealert (GetPedRelationshipGroupHash(ped))
        Citizen.InvokeNative(0x489FFCCCE7392B55, ped, PlayerPedId()) -- Follow

    end
   
  
    function cMain:createPet() -- Function to create the ped

        local undead = UndeadPeds[math.random(#UndeadPeds)]
        local model = GetHashKey(undead.model)

        RequestModel(model)
        while not HasModelLoaded(model) do Citizen.Wait(1) end

        entity = CreatePed(model, x, y, b, heading, 1, 1)

        SET_PED_DEFAULT_OUTFIT(model)
        --	SET_BLIP_TYPE( dogspawn[idOfThedog].model )

        -- | SET_ATTRIBUTE_POINTS | --
        Citizen.InvokeNative(0x09A59688C26D88DF, entity, 0, 1100)
        Citizen.InvokeNative(0x09A59688C26D88DF, entity, 1, 1100)
        Citizen.InvokeNative(0x09A59688C26D88DF, entity, 2, 1100)
        -- | ADD_ATTRIBUTE_POINTS | --
        Citizen.InvokeNative(0x75415EE0CB583760, entity, 0, 1100)
        Citizen.InvokeNative(0x75415EE0CB583760, entity, 1, 1100)
        Citizen.InvokeNative(0x75415EE0CB583760, entity, 2, 1100)
        -- | SET_ATTRIBUTE_BASE_RANK | --
        Citizen.InvokeNative(0x5DA12E025D47D4E5, entity, 0, 10)
        Citizen.InvokeNative(0x5DA12E025D47D4E5, entity, 1, 10)
        Citizen.InvokeNative(0x5DA12E025D47D4E5, entity, 2, 10)
        -- | SET_ATTRIBUTE_BONUS_RANK | --
        Citizen.InvokeNative(0x920F9488BD115EFB, entity, 0, 10)
        Citizen.InvokeNative(0x920F9488BD115EFB, entity, 1, 10)
        Citizen.InvokeNative(0x920F9488BD115EFB, entity, 2, 10)
        -- | SET_ATTRIBUTE_OVERPOWER_AMOUNT | --
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, entity, 0, 5000.0, false)
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, entity, 1, 5000.0, false)
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, entity, 2, 5000.0, false)
        SET_PED_DEFAULT_OUTFIT(dogModel)
        SET_BLIP_TYPE(dogModel)

        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     143493179)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -2040077242)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     1222652248)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     1077299173)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -887307738)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -1998572072)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -661858713)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     1232372459)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -1836932466)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     1878159675)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     1078461828)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -1535431934)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     1862763509)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -1663301869)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -1448293989)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -1201903818)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -886193798)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -1996978098)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     555364152)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -2020052692)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     707888648)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     378397108)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -350651841)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -1538724068)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     1030835986)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -1919885972)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -1976316465)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     841021282)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     889541022)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -1329647920)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -319516747)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -767591988)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -989642646)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     1986610512)
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(dogModel),
                                     -1683752762)
        Citizen.InvokeNative(0x489FFCCCE7392B55, dogModel, PlayerPedId()) -- Follow
        SetPedAsGroupMember(dogModel, GetPedGroupIndex(PlayerPedId()))

        TaskGoToEntity(idOfThedog, player, -1, 7.2, 2.0, 0, 0)

    end

    -- train blips
    Citizen.CreateThread(function()
        --  for ped in EnumeratePeds() do
        --    if not IsPedAPlayer(ped)  then cMain:DelEnt(ped) end
        -- end
        --  SetRandomTrains(true)
        while (true) do
            Citizen.Wait(1)
            for veh in cSpawnz:EnumerateVehicles() do
                Citizen.Wait(1)
                if IsThisModelATrain(GetEntityModel(veh)) then
                    local train = veh
                    cMain:BlipAddForEntity2(4044460928, train, 0.1)
                    --   local blip = BlipAddForCoord(4044460928, GetEntityCoords(train))
                    cMain:SetBlipNameFromPlayerString(blip, "Train") -- Name of the Blip
                    -- SetBlipScale(blip, 0.2) -- Scale of the Blip
                    blip = RemoveBlip()
                    Citizen.Wait(5)
                end
            end
        end
    end)

end

function Chat:LocalPlayerChat(args)
    if args.text == '/jjinfest' then
        for i, v in ipairs(self.Zs) do
            if (v.pedid > 0) then cMain:DelEnt(v.pedid) end
        end
        return false
    elseif args.text == '/jjchoo' then

        return false
    end
end

WeaponsMELEE = {
    "WEAPON_MELEE_KNIFE_BEAR", -- Antler Knife (Bear)
    "WEAPON_MELEE_BROKEN_SWORD", -- Broken Pirate Sword
    "WEAPON_MELEE_KNIFE_CIVIL_WAR", -- Civil War Knife
    "WEAPON_MELEE_CLEAVER", -- Cleaver
    "WEAPON_MELEE_HATCHET_DOUBLE_BIT", -- Double Bit Hatchet
    "WEAPON_MELEE_HATCHET", -- Hatchet
    "WEAPON_MELEE_HATCHET_HEWING", -- Hewing Hatchet
    "WEAPON_MELEE_HATCHET_HUNTER", -- Hunter Hatchet
    "WEAPON_MELEE_KNIFE", -- Hunter Knife
    "WEAPON_MELEE_KNIFE_JAWBONE", -- Jawbone Knife
    "WEAPON_MELEE_KNIFE_JOHN", -- John's Knife
    "WEAPON_MELEE_MACHETE", -- Machete
    "WEAPON_MELEE_KNIFE_VAMPIRE", -- Ornate Dagger (Vampire Knife)
    "WEAPON_MELEE_HATCHET_DOUBLE_BIT_RUSTED", -- Rusted Double Bit Hatchet
    "WEAPON_MELEE_HATCHET_HUNTER_RUSTED", -- Rusted Hunter Hatchet
    "WEAPON_MELEE_ANCIENT_HATCHET", -- Stone Hatchet
    "WEAPON_MELEE_HATCHET_VIKING", -- Viking Hatchet
    "WEAPON_MELEE_KNIFE_MINER" -- Wide-Blade Knife (Miner)
}
WeaponsPISTOL = {
    "WEAPON_REVOLVER_CATTLEMAN", -- Cattleman
    "WEAPON_REVOLVER_CATTLEMAN_JOHN", -- John's Cattleman
    "WEAPON_REVOLVER_CATTLEMAN_MEXICAN", -- Flaco's Cattleman (Mexican)
    "WEAPON_REVOLVER_CATTLEMAN_PIG", -- Granger's Cattleman (Pig)
    "WEAPON_REVOLVER_DOUBLEACTION", -- Double-Action
    "WEAPON_REVOLVER_DOUBLEACTION_EXOTIC", -- Algernon's Double-Action (Exotic)
    "WEAPON_REVOLVER_DOUBLEACTION_GAMBLER", -- High Roller Double-Action (Gambler)
    "WEAPON_REVOLVER_DOUBLEACTION_MICAH", -- Micah's Double-Action
    "WEAPON_REVOLVER_LEMAT", -- LeMat
    "WEAPON_REVOLVER_SCHOFIELD", -- Schofield
    "WEAPON_REVOLVER_SCHOFIELD_CALLOWAY", -- Calloway's Schofield
    "WEAPON_REVOLVER_SCHOFIELD_GOLDEN", -- Otis Miller's Schofield (Golden)
    "WEAPON_PISTOL_M1899", -- M1899
    "WEAPON_PISTOL_MAUSER", -- Mauser
    "WEAPON_PISTOL_MAUSER_DRUNK", -- Midnight's Mauser (Drunk)
    "WEAPON_PISTOL_SEMIAUTO", -- Semi Automatic
    "WEAPON_PISTOL_VOLCANIC" -- Volcanic
}
WeaponsRIFLE = {
    "WEAPON_SHOTGUN_DOUBLEBARREL", -- Double-Barreled
    "WEAPON_SHOTGUN_PUMP", -- Pump Action
    "WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC", -- Rare Double-Barreled (Exotic)
    "WEAPON_SHOTGUN_REPEATING", -- Repeating
    "WEAPON_SHOTGUN_SAWEDOFF", -- Sawed-Off
    "WEAPON_SHOTGUN_SEMIAUTO", -- Semi Automatic
    "WEAPON_RIFLE_BOLTACTION", -- Bolt Action Rifle
    "WEAPON_REPEATER_CARBINE", -- Carbine Repeater
    "WEAPON_REPEATER_EVANS", -- Evans Repeater
    "WEAPON_REPEATER_HENRY", -- Litchfield Repeater (Henry)
    "WEAPON_REPEATER_WINCHESTER", -- Lancaster Repeater (Winchester)
    "WEAPON_RIFLE_SPRINGFIELD", -- Springfield Rifle
    "WEAPON_RIFLE_VARMINT" -- Varmint Rifle
}
WeaponsSNIPER = {
    "WEAPON_SNIPERRIFLE_CARCANO", -- Carcano Sniper Rifle
    "WEAPON_SNIPERRIFLE_ROLLINGBLOCK_EXOTIC", -- Rare Rolling Block Sniper Rifle (Exotic)
    "WEAPON_SNIPERRIFLE_ROLLINGBLOCK" -- Rolling Block Sniper Rifle
}
WeaponsTHROW = {
    "WEAPON_BOW", -- Bow
    "WEAPON_LASSO", "WEAPON_MOONSHINEJUG", -- Moonshine Jug
    "WEAPON_THROWN_TOMAHAWK_ANCIENT", -- Ancient Tomahawk
    "WEAPON_THROWN_DYNAMITE", -- Dynamite
    "WEAPON_THROWN_MOLOTOV", -- Molotov
    "WEAPON_THROWN_THROWING_KNIVES", -- Throwing Knives
    "WEAPON_THROWN_TOMAHAWK" -- Tomahawk
}
ammolist = {
    "AMMO_REVOLVER", -- Revolver
    "AMMO_REVOLVER_EXPRESS", -- Express Revolver
    "AMMO_REVOLVER_EXPRESS_EXPLOSIVE", -- Express Explosive Revolver
    "AMMO_REVOLVER_HIGH_VELOCITY", -- High Velocity Revolver
    "AMMO_REVOLVER_SPLIT_POINT", -- Split Point Revolver
    "AMMO_PISTOL", -- Pistol
    "AMMO_PISTOL_EXPRESS", -- Express Pistol
    "AMMO_PISTOL_EXPRESS_EXPLOSIVE", -- Express Explosive Pistol
    "AMMO_PISTOL_HIGH_VELOCITY", -- High Velocity Pistol
    "AMMO_PISTOL_SPLIT_POINT", -- Split Point Pistol
    "AMMO_SHOTGUN", -- Shotgun
    "AMMO_SHOTGUN_BUCKSHOT_INCENDIARY", -- Shotgun Buckshot Incendiary
    "AMMO_SHOTGUN_EXPRESS_EXPLOSIVE", -- Express Explosive Shotgun
    "AMMO_SHOTGUN_SLUG", -- Shotgun Slug
    "AMMO_RIFLE", -- Rifle
    "AMMO_RIFLE_EXPRESS", -- Express Rifle
    "AMMO_RIFLE_EXPRESS_EXPLOSIVE", -- Express Explosive Rifle
    "AMMO_RIFLE_HIGH_VELOCITY", -- High Velocity Rifle
    "AMMO_RIFLE_SPLIT_POINT", -- Split Point Rifle
    "AMMO_RIFLE_VARMINT", -- Varmint Rifle
    "AMMO_REPEATER", -- Repeater
    "AMMO_REPEATER_EXPRESS", -- Express Repeater
    "AMMO_REPEATER_EXPRESS_EXPLOSIVE", -- Express Explosive Repeater
    "AMMO_REPEATER_HIGH_VELOCITY", -- High Velocity Repeater
    "AMMO_DYNAMITE", -- Dynamite
    "AMMO_DYNAMITE_VOLATILE", -- Volatile Dynamite
    "AMMO_MOLOTOV", -- Molotov
    "AMMO_MOLOTOV_VOLATILE", -- Volatile Molotov
    "AMMO_THROWING_KNIVES", -- Throwing Knife
    "AMMO_THROWING_KNIVES_IMPROVED", -- Improved Throwing Knife
    "AMMO_THROWING_KNIVES_POISON", -- Poison Throwing Knife
    "AMMO_TOMAHAWK", -- Tomahawk
    "AMMO_TOMAHAWK_HOMING", -- Homing Tomahawk
    "AMMO_TOMAHAWK_IMPROVED", -- Improved Tomahawk
    "AMMO_ARROW", -- Arrow
    "AMMO_ARROW_DYNAMITE", -- Dynamite Arrow
    "AMMO_ARROW_FIRE", -- Fire Arrow
    "AMMO_ARROW_IMPROVED", -- Improved Arrow
    "AMMO_ARROW_POISON", -- Poison Arrow
    "AMMO_ARROW_SMALL_GAME" -- Small Game Arrow
}


cMain = cMain()
