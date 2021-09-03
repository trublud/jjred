local Zpeds0 = {}

local checking = false

function MakeTPed(ped)
    Zpeds0[ped].ptype = "townfolk"
    RemoveAllPedWeapons(ped, true, true)

    local randit = math.random(10)
    if randit < 7 then GiveRandomMeleeWep(ped) end
    if randit == 7 then GiveRandomThrowWep(ped) end
    if randit == 8 then GiveRandomPistolWep(ped) end
    if randit == 9 then GiveRandomRifleWep(ped) end
    if randit == 10 then GiveRandomSniperWep(ped) end

    SetEntityMaxHealth(ped, tonumber(Config.TownfolkBaseHealth))
    SetEntityHealth(ped, tonumber(Config.TownfolkBaseHealth), 0)
    --   SetPedCombatAttributes(ped, 46, 1)
    --	SetPedCombatAttributes(ped, 5, 1)	
    SetPedCombatMovement(ped, 3)
    SetPedAsCop(ped, true)

    SetAiMeleeWeaponDamageModifier(ped, Config.TownfolkDamage)
    SetPedHearingRange(ped, Config.MaxAttackRangeTownfolk)
    SetPedSeeingRange(ped, Config.MaxAttackRangeTownfolk)
    SetPedRelationshipGroupDefaultHash(ped, 'notdead')

    SetPedRelationshipGroupHash(ped, 'notdead')

    SetRelationshipBetweenGroups(6, 'undead', 'notdead')
    SetRelationshipBetweenGroups(6, 'notdead', 'undead')
    SetRelationshipBetweenGroups(6, 'undead', PLAYER)
    SetRelationshipBetweenGroups(6, PLAYER, 'undead')
    SetRelationshipBetweenGroups(0, 'notdead', PLAYER)
    SetRelationshipBetweenGroups(0, PLAYER, 'notdead')
    SetPedAccuracy(ped, SetTownfolkAccuracy)
    --  SetAmbientVoiceName(ped, "ALIENS")
    DisablePedPainAudio(ped, true)
    SetPedCanRagdoll(ped, true)
    SetPedPathCanUseClimbovers(ped, false)
    SetPedPathCanUseLadders(ped, false)
    SetPedPathAvoidFire(ped, false)
    --      SetPedIsDrunk(ped, true)
end
function MakeZPed(ped)
    messagealert(ped)
    Zpeds0[ped].ptype = "zombie"
    local cped = GetEntityCoords(ped)
    cani = GetNearbyPeds(ped, cped.x, cped.y, cped.z, 90)
    messagealert("making ped")
    if cani > 15 then
        --   messagealert(cani)
        AddUndeadSpawn(spawns, ped)
    end
end

function MakePed(ped)
    local howmanyp = 0
    local howmanyz = 0
    for k, v in pairs(Zpeds0) do
        messagealert("test")
        if k == 'ptype' then
            if v == "townfolk" then
                howmanyp = howmanyp + 1
            elseif v == "zombie" then
                howmanyz = howmanyz + 1
            end

        end

        if InRangeofPlayer(ped, Config.InRangeofPlayer) then
            Zpeds0[ped].inrange = true

            if howmanyp < Config.MaxTownfolk then MakeTPed(ped) end
            if howmanyz < Config.MaxZombies then
                MakeZPed(ped)

                --   Zpeds0[ped].ptype = true
            end
        else
            Zpeds0[ped].inrange = false
        end
    end

end

function CheckLives(ped)
    local thisplayer = PlayerPedId()
    if IsPedDeadOrDying(ped) then
        local killer = GetPedSourceOfDeath(ped)
        if ped == thisplayer then
            -- player dying
        else

            if Zpeds0[ped] then
                Zpeds0[ped].dead = true
                Zpeds0[ped].lasthp = 0
                Zpeds0[ped].lasthp = 0
                Zpeds0[ped].attacker = killer
            else
                -- HOW??
            end

            if killer == thisplayer then -- you killed something
                if Zpeds0[ped].type == "townfolk" then

                    if not Disposal[ped] then
                        TriggerServerEvent('JJz:playerKilledInnocent')
                        messagealert("Killed a townfolk!!")
                        removeafter(ped, 30000)
                        Disposal[ped] = ped

                    end
                elseif Zpeds0[ped].type == "zombie" then

                    if not Disposal[ped] then
                        TriggerServerEvent('JJz:playerKilledUndead')
                        messagealert("Killed a  Z!!")
                        removeafter(ped, 30000)
                        Disposal[ped] = ped

                    end
                elseif isPlayerPed(ped) then
                    TriggerServerEvent('JJz:playerKilledPvp')
                    messagealert("Killed a Player!!!")

                end

            else -- not by you
                if Zpeds0[killer].type == "zombie" then
                    if Zpeds0[ped].type == "townfolk" then

                        if not Disposal[ped] then
                            --     TriggerServerEvent('JJz:playerKilledInnocent')
                            messagealert("Zombie a townfolk!!")
                            removeafter(ped, 30000)
                            Disposal[ped] = ped

                        end
                    elseif Zpeds0[ped].type == "zombie" then

                        if not Disposal[ped] then
                            --   TriggerServerEvent('JJz:playerKilledUndead')
                            messagealert("Z V Z!!")
                            removeafter(ped, 30000)
                            Disposal[ped] = ped

                        end
                    elseif isPlayerPed(ped) then
                        --  TriggerServerEvent('JJz:playerKilledPvp')
                        messagealert("Zombie Killed a Player!!!")

                    end
                elseif Zpeds0[killer].type == "townfolk" then
                    if Zpeds0[ped].type == "zombie" then
                        if not Disposal[ped] then
                            --     TriggerServerEvent('JJz:playerKilledInnocent')
                            messagealert("Townfolk a Zombie!!")
                            removeafter(ped, 30000)
                            Disposal[ped] = ped

                        end
                    elseif Zpeds0[ped].type == "townfolk" then

                        if not Disposal[ped] then
                            --   TriggerServerEvent('JJz:playerKilledUndead')
                            messagealert("Townfolk V Townfolk!!")
                            removeafter(ped, 30000)
                            Disposal[ped] = ped

                        end
                    elseif isPlayerPed(ped) then
                        --   TriggerServerEvent('JJz:playerKilledPvp')
                        messagealert("Townfolk Killed a Player!!!")

                    end

                end
            end
        end

        --  Undead[ped] = nil
        SetPedAsNoLongerNeeded(ped)

    else
        if Zpeds0[ped] ~= nil then
            if GetEntityHealth(ped) < Zpeds0[ped].lasthp or
                HasEntityBeenDamagedByAnyPed(ped) then
                -- PED DAMAGED!
                -- HasEntityBeenDamagedByEntity(ped,attacker)
                for k, v in pairs(Zpeds0) do
                    if k == "pedid" then
                        if HasEntityBeenDamagedByEntity(ped, v) and
                            not Zpeds0[ped].attacker == ped then
                            -- found attacker  v
                            Zpeds0[ped].attacker = ped
                            messagealert(v .. " attacked" .. ped)
                        end
                    end

                end
                Zpeds0[ped].lasthp = GetEntityHealth(ped)
            end
        end
    end
end

function CheckPeds()
    checking = true
    for ped in EnumeratePeds() do
        if IsPedAPlayer(ped) then CheckLives(ped) end
        --     if  Zpeds0[ped] ~= nil then print(Zpeds0[ped] ) end  
        if Zpeds0[ped] ~= nil then
            table.insert(Zpeds0, pedid)
            table.insert(Zpeds0, {Ped = true, pedid = ped});

        end

        if InRangeofPlayer(ped, Config.InRangeofPlayer) then
            for k, v in pairs(Zpeds0) do messagealert(k) end

            messagealert(ped)

            CheckLives(ped)
            if Zpeds0[ped].ptype == "none" then MakePed(ped) end

        end

    end
    checking = false
end

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

function EnumerateEntities(firstFunc, nextFunc, endFunc)
    return coroutine.wrap(function()
        local iter, id = firstFunc()

        if not id or id == 0 then
            endFunc(iter)
            return
        end

        local enum = {handle = iter, destructor = endFunc}
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
            coroutine.yield(id)
            next, id = nextFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        endFunc(iter)
    end)
end

function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if not checking then
            Wait(1000)
      --      CheckPeds()
        end

    end
end)

function AddUndeadSpawn(spawns, ped)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local h = GetEntityHeading(ped)
    local hasLos = HasAnyPlayerLos(ped)

    if IsPedInAnyVehicle(ped, false) then
        local veh = GetVehiclePedIsIn(ped, false)
        local model = GetEntityModel(veh)

        if not IsThisModelATrain(model) and not IsThisModelABoat(model) then
            DelEnt(veh)
        end
    end

    if IsPedOnMount(ped) then DelEnt(GetMount(ped)) end

    Wait(0)

    table.insert(spawns,
                 {ped = ped, x = x, y = y, z = z, h = h, hasLos = hasLos})

    DelEnt(ped)
end
