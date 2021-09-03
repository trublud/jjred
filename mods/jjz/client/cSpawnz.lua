cSpawnz = class()
SpawnZ = {}
SpawnPed = {}
SpawnTown = {}
SpawnGuard = {}
spawns ={}
function cSpawnz:__init()

    CreateThread(function()
        if IsControlPressed(0, 0xAC4BD4F1) then
            DisableControlAction(0, 0x9CC7A1A4, true)
            DisableControlAction(0, 0xD9D0E1C0, true)
            DisableControlAction(0, 0xD51B784F, true)
        end
        AddRelationshipGroup('undead')
        AddRelationshipGroup('notdead')
        SetPedRelationshipGroupDefaultHash(PlayerPedId(), 'notdead')
        SetPedRelationshipGroupHash(PlayerPedId(), 'notdead')

        SetRelationshipBetweenGroups(6, 'undead', 'notdead')
        SetRelationshipBetweenGroups(6, 'notdead', 'undead')
        SetRelationshipBetweenGroups(6, 'undead', PLAYER)
        SetRelationshipBetweenGroups(6, PLAYER, 'undead')
        SetRelationshipBetweenGroups(0, 'notdead', PLAYER)
        SetRelationshipBetweenGroups(0, PLAYER, 'notdead')

        -- ExecuteCommand("JJui")
        -- TriggerServerEvent('JJz:newPlayer')

     --   cSpawnz:updatecounts()
      --  cSpawnz:CheckDead()
      --  cSpawnz:CheckAi()
        --   if CurrentZone then
        -- Log("error", "yup", "nopr")

        while (true) do
            Citizen.Wait(6000)
            cSpawnz:GetPeds()
            spawns = cSpawnz:CreateUndeadSpawns()

            cSpawnz:SpawnUndead(spawns)
        end

    end)

end
function cSpawnz:GetPeds()
    SpawnPed = {}
    for epd in cSpawnz:EnumeratePeds() do 
        table.insert(SpawnPed, {ped = epd}) 
      --  SpawnPed[epd]=true
    end
 --   cPowers:hudmessage(true, #SpawnPed, #SpawnTown)   
end
function cSpawnz:IsUndead(ped)
    local model = GetEntityModel(ped)

    for _, undead in ipairs(UndeadPeds) do
        if model == GetHashKey(undead.model) then return true end
    end

    return false
end
function cSpawnz:CreateUndeadSpawns()

    print("-------")
                     
    print("-------")
    print("#Peds:")
    print(#SpawnPed)
    
    
    
    print("-------")
    print("#SpawnTown:")
    print(#SpawnTown)
    
    print("-------")
    
    print("#SpawnZ:")
    print(#SpawnZ)
       for pped,v in pairs(SpawnPed) do
   
       
        if not IsPedAPlayer(pped) then
        --    print("not player:")
            if cSpawnz:InRangeofPlayer(PlayerPedId(), pped, Config.SpawnDistance) then
         

                if cSpawnz:IsUndead(pped) then
                    print("is undead:")
                    self.UpdateUndead(pped)

                elseif cSpawnz:ShouldBecomeUndead(pped) then
                     
        
                   
               
                   -- print(Config.MaxTownfolk)
                 --   print(SpawnPed[pped] == pped)
                    --  if #self.Zs > Config.MaxZombies or #SpawnPed < 25 then
                    if not SpawnTown[pped] and #SpawnTown <
                        Config.MaxTownfolk then
                       -- self.AddUndeadSpawn(spawns, pped)
                        --   local cped = GetEntityCoords(ped)
                        --    cani = GetNearbyPeds(ped, cped.x,cped.y,cped.z, 70 )
           
                        --  if cani > 15 then 
                        RemoveAllPedWeapons(pped, true, true)
                       
                        local randit = math.random(10)
                        if randit < 7 then
                            cSpawnz:GiveRandomMeleeWep(pped)
                        end
                        if randit == 7 then
                            cSpawnz:GiveRandomThrowWep(pped)
                        end
                        if randit == 8 then
                            cSpawnz:GiveRandomPistolWep(pped)
                        end
                        if randit == 9 then
                            cSpawnz:GiveRandomRifleWep(pped)
                        end
                        if randit == 10 then
                            cSpawnz:GiveRandomSniperWep(pped)
                        end

                        SetEntityMaxHealth(pped,
                                           tonumber(Config.TownfolkBaseHealth))
                        SetEntityHealth(pped,
                                        tonumber(Config.TownfolkBaseHealth), 0)
                        --   SetPedCombatAttributes(pped, 46, 1)
                        --	SetPedCombatAttributes(pped, 5, 1)	
                        SetPedCombatMovement(pped, 3)
                        SetPedAsCop(pped, true)

                        SetAiMeleeWeaponDamageModifier(pped,
                                                       Config.TownfolkDamage)
                        SetPedHearingRange(pped, Config.MaxAttackRangeTownfolk)
                        SetPedSeeingRange(pped, Config.MaxAttackRangeTownfolk)
                        SetPedRelationshipGroupDefaultHash(pped, 'notdead')

                        SetPedRelationshipGroupHash(pped, 'notdead')

                        SetRelationshipBetweenGroups(6, 'undead', 'notdead')
                        SetRelationshipBetweenGroups(6, 'notdead', 'undead')
                        SetRelationshipBetweenGroups(6, 'undead', PLAYER)
                        SetRelationshipBetweenGroups(6, PLAYER, 'undead')
                        SetRelationshipBetweenGroups(0, 'notdead', PLAYER)
                        SetRelationshipBetweenGroups(0, PLAYER, 'notdead')
                        SetPedAccuracy(pped, SetTownfolkAccuracy)

                        SetBlockingOfNonTemporaryEvents(pped, true)
                        --  SetAmbientVoiceName(pped, "ALIENS")
                        DisablePedPainAudio(pped, true)
                        SetPedCanRagdoll(pped, true)
                        SetPedPathCanUseClimbovers(pped, false)
                        SetPedPathCanUseLadders(pped, false)
                        SetPedPathAvoidFire(pped, false)
                        
                        table.insert(SpawnTown, {
                            ped = pped,
                            pedid = pped,
                            target = 0,
                            attacker = 0,
                            boss = false,
                            busy = false,
                            type = "town",
                            inrange = false,
                            dead = false,
                            lasthp = Config.TownfolkBaseHealth
                        })
                        
                   
                       
                        --      SetPedIsDrunk(pped, true)

                        --   if Config.ShowBlips then
                        --      BlipAddForEntity2(Config.TownfolkBlipSprite, pped, 0.01)

                        --    end
                        --    messagealert(cani)

                        -- end
                    else
                      --  self.AddUndeadSpawn(SpawnZ, pped)
                        if not SpawnZ[pped] and #SpawnZ < Config.MaxZombies then
                            local cped = GetEntityCoords(pped)
                            cani = cSpawnz:GetNearbyPeds(pped, cped.x, cped.y,
                                                         cped.z, 30)

                            if cani > 15 then
                                --   messagealert(cani)
                                self.AddUndeadSpawn(SpawnZ, pped)
                               
                            end

                        end
                      
                    end
             --   end
           -- end  
         
        end
    end
    Wait(50)
    end
end
    return SpawnZ
end
function cSpawnz:removeafter(ped, time)
    Citizen.CreateThread(function()
        if time < 1 then time = 15000 end
        Citizen.Wait(time)
        cSpawnz:DelEnt(ped)

    end)
end


function cSpawnz:AddUndeadSpawn(spawns2, ped)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local h = GetEntityHeading(ped)
    local hasLos = cSpawnz:HasAnyPlayerLos(ped)

    if IsPedInAnyVehicle(ped, false) then
        local veh = GetVehiclePedIsIn(ped, false)
        local model = GetEntityModel(veh)

        if not IsThisModelATrain(model) and not IsThisModelABoat(model) then
            cSpawnz:DelEnt(veh)
        end
    end

    if IsPedOnMount(ped) then cSpawnz:DelEnt(GetMount(ped)) end

    Wait(0)
  --  table.insert(SpawnZ,
   -- {ped = ped, x = x, y = y, z = z, h = h, hasLos = hasLos})
    table.insert(spawns2,
                 {ped = ped, x = x, y = y, z = z, h = h, hasLos = hasLos})
             --    SpawnTown[ped]=true
    cSpawnz:DelEnt(ped)
end
function cSpawnz:ShouldBecomeUndead(ped)
    local shouldbe = false
    local ped1Coords = GetEntityCoords(ped)

    --if IsPedInGroup(ped) or GetPedRelationshipGroupHash(ped) == GetHashKey('notdead') or not
    if IsPedHuman(ped) or cSpawnz:GetNearbyPeds(ped, ped1Coords.x, ped1Coords.y, ped1Coords.z, 4) >
        2 then
        return false
    end
    
    return true
end

function cSpawnz:IsInZone(ped, zone)
    if not zone then return false end

    if not zone.radius then return true end

    local coords = GetEntityCoords(ped)

    return #(coords - vector3(zone.x, zone.y, coords.z)) <= zone.radius
end

function cSpawnz:ClearPedsInZone(zone)
    for ped in cSpawnz:EnumeratePeds() do

        if not IsPedAPlayer(ped) and cSpawnz:IsInZone(ped, zone) then
            cSpawnz:DelEnt(ped)
        end
    end
end
function cSpawnz:GetNearbyPeds(target, X, Y, Z, Radius)
    local NearbyPeds = {}
    if tonumber(X) and tonumber(Y) and tonumber(Z) then
        if tonumber(Radius) then
            for Ped in cSpawnz:EnumeratePeds() do
                if not IsPedAPlayer(target) and Ped ~= target then
                    if DoesEntityExist(Ped) then
                        local PedPosition = GetEntityCoords(Ped, false)
                        if Vdist(X, Y, Z, PedPosition.x, PedPosition.y,
                                 PedPosition.z) <= Radius then
                            return Vdist(X, Y, Z, PedPosition.x,
                                         PedPosition.y, PedPosition.z)
                            --	table.insert(NearbyPeds, Ped)
                        end
                    end
                end
                return 0
            end
            return 0
        else
            return 0

        end
    else
        return 0

    end
    return 0
end

function cSpawnz:SpawnUndead(spawnsz)
    for _, spawn in ipairs(spawnsz) do

        --     if self.Disposal[spawn.ped] then return end
        if not DoesEntityExist(spawn.ped) and not spawn.hasLos then

            local undead = UndeadPeds[math.random(#UndeadPeds)]
            local model = GetHashKey(undead.model)

            RequestModel(model)
            while not HasModelLoaded(model) do Wait(0) end

            local ped = self.CreatePed_2(model, spawn.x, spawn.y, spawn.z,
                                    spawn.h, true, false, false, false)
            SetModelAsNoLongerNeeded(model)

            SetPedOutfitPreset(ped, undead.outfit)

            if Config.ShowBlips then
                --self.BlipAddForEntity3(Config.UndeadBlipSprite, ped, 0.01)
              --  cSpawnz:BlipAddForEntity2(0x19365607, ped, 0.01)
            end

            local walkingStyle = Config.WalkingStyles[math.random(
                                     #Config.WalkingStyles)]
            Citizen.InvokeNative(0x923583741DC87BCE, ped, walkingStyle[1])
            Citizen.InvokeNative(0x89F5E7ADECCCB49C, ped, walkingStyle[2])

            Citizen.InvokeNative(0x923583741DC87BCE, ped, walkingStyle[1])

            SetEntityMaxHealth(ped, tonumber(Config.UndeadBaseHealth))
            SetEntityHealth(ped, tonumber(Config.UndeadBaseHealth), 0)
            SetPedRelationshipGroupDefaultHash(ped, 'undead')
            SetPedRelationshipGroupHash(ped, 'undead')
            SetRelationshipBetweenGroups(6, 'undead', 'notdead')
            SetRelationshipBetweenGroups(6, 'notdead', 'undead')
            SetRelationshipBetweenGroups(6, 'undead', PLAYER)
            SetRelationshipBetweenGroups(6, PLAYER, 'undead')
            SetPedCombatAttributes(ped, 46, true)
            SetPedFleeAttributes(ped, 0, false)
           -- SetEntityCanBeDamaged(PlayerPedId(), true)
            SetEntityCanBeDamaged(ped, true)
            SetPedAccuracy(ped, SetZombieAccuracy)
            local randit = math.random(10)
            if randit < 7 then self.GiveRandomMeleeWep(ped) end
            if randit == 7 then self.GiveRandomThrowWep(ped) end
            if randit == 8 then self.GiveRandomPistolWep(ped) end
            if randit == 9 then self.GiveRandomRifleWep(ped) end
            if randit == 10 then self.GiveRandomSniperWep(ped) end

            --	SetPedAmmo(ped, 0x63F46DE6, 20) -- springfield
            SetPedHearingRange(ped, Config.MaxAttackRangeZombies)
            SetPedSeeingRange(ped, Config.MaxAttackRangeZombies)
            TaskWanderStandard(ped, 10.0, 10)
            table.insert(SpawnZ, {
                [ped] = ped,
                pedid = ped,
                target = 0,
                attacker = 0,
                boss = false,
                busy = false
            })

      --SpawnZ[ped] = true

        end
    end
end

function cSpawnz:InRangeofPlayer(pl, ped, distance)
    local ped1Coords = GetEntityCoords(ped)
    local ped2Coords = GetEntityCoords(PlayerPedId())
 if #(ped1Coords - ped2Coords) <= distance then return true end

    return false
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

function cSpawnz:EnumerateEntities(firstFunc, nextFunc, endFunc)
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

function cSpawnz:EnumerateObjects()
    return cSpawnz:EnumerateEntities(FindFirstObject, FindNextObject,
                                     EndFindObject)
end

function cSpawnz:EnumeratePeds()
    return cSpawnz:EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function cSpawnz:EnumerateVehicles()
    return cSpawnz:EnumerateEntities(FindFirstVehicle, FindNextVehicle,
                                     EndFindVehicle)
end

function cSpawnz:GiveRandomPistolWep(ped)
    hash = GetHashKey(WeaponsPISTOL[math.random(#WeaponsPISTOL)])
    GiveWeaponToPed_2(ped, tonumber(hash), 1, true, true, 1, false, 0.5,
                      1.0, false, 0)
    for i, ammohash in ipairs(ammolist) do
        SetPedAmmoByType(ped, GetHashKey(ammohash), 10000)
    end
end
function cSpawnz:GiveRandomRifleWep(ped)
    hash = GetHashKey(WeaponsRIFLE[math.random(#WeaponsRIFLE)])
    GiveWeaponToPed_2(ped, tonumber(hash), 1, true, true, 1, false, 0.5,
                      1.0, false, 0)
    for i, ammohash in ipairs(ammolist) do
        SetPedAmmoByType(ped, GetHashKey(ammohash), 10000)
    end
end
function cSpawnz:GiveRandomSniperWep(ped)
    hash = GetHashKey(WeaponsSNIPER[math.random(#WeaponsSNIPER)])
    GiveWeaponToPed_2(ped, tonumber(hash), 1, true, true, 1, false, 0.5,
                      1.0, false, 0)
    for i, ammohash in ipairs(ammolist) do
        SetPedAmmoByType(ped, GetHashKey(ammohash), 10000)
    end
end
function cSpawnz:GiveRandomThrowWep(ped)
    hash = GetHashKey(WeaponsTHROW[math.random(#WeaponsTHROW)])
    GiveWeaponToPed_2(ped, tonumber(hash), 1, true, true, 1, false, 0.5,
                      1.0, false, 0)
    for i, ammohash in ipairs(ammolist) do
        SetPedAmmoByType(ped, GetHashKey(ammohash), 10000)
    end
end
function cSpawnz:GiveRandomMeleeWep(ped)
    hash = GetHashKey(WeaponsMELEE[math.random(#WeaponsMELEE)])
    GiveWeaponToPed_2(ped, tonumber(hash), 1, true, true, 1, false, 0.5,
                      1.0, false, 0)
    for i, ammohash in ipairs(ammolist) do
        SetPedAmmoByType(ped, GetHashKey(ammohash), 10000)
    end
end
function cSpawnz:CreatePed_2(modelHash, x, y, z, heading, isNetwork,
    thisScriptCheck, p7, p8)
return Citizen.InvokeNative(0xD49F9B0955C367DE, modelHash, x, y, z,
         heading, isNetwork, thisScriptCheck, p7, p8)
end

function cSpawnz:HasAnyPlayerLos(ped)
    for _, player in ipairs(GetActivePlayers()) do
        local playerPed = GetPlayerPed(player)

        if HasEntityClearLosToEntity(playerPed, ped, 1) then
            return true
        end
    end

    return false
end
function cSpawnz:removefromTable(tab, val)
    local index = nil
    for i, v in ipairs(tab) do 
        print(i)
        if v then index = i end end
    if index == nil then
    else
        table.remove(tab, index)
    end
end

function cSpawnz:DelEnt(entity)
    
    
    cSpawnz:removefromTable(SpawnZ, entity)
    cSpawnz:removefromTable(SpawnPed, entity)
    cSpawnz:removefromTable(SpawnTown, entity)
    cSpawnz:removefromTable(SpawnGuard, entity)
    SetEntityAsMissionEntity(entity, true, true)
    DeleteEntity(entity)
    SetEntityAsNoLongerNeeded(entity)

end

UndeadPeds = {
    {model = 'CS_MrAdler', outfit = 1}, {model = 'CS_ODProstitute', outfit = 0},
    {model = 'CS_SwampFreak', outfit = 0}, {model = 'CS_Vampire', outfit = 0},
    {model = 'CS_ChelonianMaster', outfit = 0},
    {model = 'RE_Voice_Females_01', outfit = 0},
    {model = 'RE_SavageAftermath_Males_01', outfit = 0},
    {model = 'RE_SavageAftermath_Males_01', outfit = 1},
    {model = 'RE_SavageAftermath_Males_01', outfit = 2},
    {model = 'RE_SavageWarning_Males_01', outfit = 3},
    {model = 'RE_SavageWarning_Males_01', outfit = 4},
    {model = 'RE_SavageWarning_Males_01', outfit = 5},
    {model = 'RE_SavageWarning_Males_01', outfit = 6},
    {model = 'RE_SavageAftermath_Males_01', outfit = 3},
    {model = 'RE_SavageAftermath_Males_01', outfit = 4},
    {model = 'RE_SavageAftermath_Females_01', outfit = 0},
    {model = 'RE_SavageAftermath_Females_01', outfit = 1},
    {model = 'RE_CorpseCart_Males_01', outfit = 0},
    {model = 'RE_CorpseCart_Males_01', outfit = 1},
    {model = 'RE_CorpseCart_Males_01', outfit = 2},
    {model = 'RE_LostFriend_Males_01', outfit = 0},
    {model = 'RE_LostFriend_Males_01', outfit = 1},
    {model = 'RE_LostFriend_Males_01', outfit = 2},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 0},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 1},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 2},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 3},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 4},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 5},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 6},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 7},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 8},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 9},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 10},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 11},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 12},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 13},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 14},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 15},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 16},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 17},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 18},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 19},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 20},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 21},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 22},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 23},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 24},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 25},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 26},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 27},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 28},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 29},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 30},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 31},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 32},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 33},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 34},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 35},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 36},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 37},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 38},
    {model = 'A_F_M_ArmCholeraCorpse_01', outfit = 39},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 0},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 1},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 2},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 3},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 4},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 5},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 6},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 7},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 8},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 9},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 10},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 11},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 12},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 14},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 15},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 16},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 17},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 18},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 19},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 20},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 21},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 22},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 23},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 24},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 25},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 28},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 29},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 30},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 34},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 35},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 36},
    {model = 'A_M_M_ArmCholeraCorpse_01', outfit = 37},
    {model = 'U_M_M_CircusWagon_01', outfit = 0},
    {model = 'A_M_M_UniCorpse_01', outfit = 0},
    {model = 'A_M_M_UniCorpse_01', outfit = 3},
    {model = 'A_M_M_UniCorpse_01', outfit = 4},
    {model = 'A_M_M_UniCorpse_01', outfit = 5},
    {model = 'A_M_M_UniCorpse_01', outfit = 8},
    {model = 'A_M_M_UniCorpse_01', outfit = 15},
    {model = 'A_M_M_UniCorpse_01', outfit = 16},
    {model = 'A_M_M_UniCorpse_01', outfit = 17},
    {model = 'A_M_M_UniCorpse_01', outfit = 18},
    {model = 'A_M_M_UniCorpse_01', outfit = 19},
    {model = 'A_M_M_UniCorpse_01', outfit = 20},
    {model = 'A_M_M_UniCorpse_01', outfit = 21},
    {model = 'A_M_M_UniCorpse_01', outfit = 22},
    {model = 'A_M_M_UniCorpse_01', outfit = 23},
    {model = 'A_M_M_UniCorpse_01', outfit = 24},
    {model = 'A_M_M_UniCorpse_01', outfit = 25},
    {model = 'A_M_M_UniCorpse_01', outfit = 30},
    {model = 'A_M_M_UniCorpse_01', outfit = 31},
    {model = 'A_M_M_UniCorpse_01', outfit = 33},
    {model = 'A_M_M_UniCorpse_01', outfit = 34},
    {model = 'A_M_M_UniCorpse_01', outfit = 35},
    {model = 'A_M_M_UniCorpse_01', outfit = 36},
    {model = 'A_M_M_UniCorpse_01', outfit = 37},
    {model = 'A_M_M_UniCorpse_01', outfit = 41},
    {model = 'A_M_M_UniCorpse_01', outfit = 45},
    {model = 'A_M_M_UniCorpse_01', outfit = 46},
    {model = 'A_M_M_UniCorpse_01', outfit = 47},
    {model = 'A_M_M_UniCorpse_01', outfit = 48},
    {model = 'A_M_M_UniCorpse_01', outfit = 49},
    {model = 'A_M_M_UniCorpse_01', outfit = 50},
    {model = 'A_M_M_UniCorpse_01', outfit = 52},
    {model = 'A_M_M_UniCorpse_01', outfit = 53},
    {model = 'A_M_M_UniCorpse_01', outfit = 54},
    {model = 'A_M_M_UniCorpse_01', outfit = 55},
    {model = 'A_M_M_UniCorpse_01', outfit = 56},
    {model = 'A_M_M_UniCorpse_01', outfit = 59},
    {model = 'A_M_M_UniCorpse_01', outfit = 67},
    {model = 'A_M_M_UniCorpse_01', outfit = 68},
    {model = 'A_M_M_UniCorpse_01', outfit = 69},
    {model = 'A_M_M_UniCorpse_01', outfit = 72},
    {model = 'A_M_M_UniCorpse_01', outfit = 73},
    {model = 'A_M_M_UniCorpse_01', outfit = 74},
    {model = 'A_M_M_UniCorpse_01', outfit = 81},
    {model = 'A_M_M_UniCorpse_01', outfit = 82},
    {model = 'A_M_M_UniCorpse_01', outfit = 83},
    {model = 'A_M_M_UniCorpse_01', outfit = 85},
    {model = 'A_M_M_UniCorpse_01', outfit = 86},
    {model = 'A_M_M_UniCorpse_01', outfit = 88},
    {model = 'A_M_M_UniCorpse_01', outfit = 89},
    {model = 'A_M_M_UniCorpse_01', outfit = 90},
    {model = 'A_M_M_UniCorpse_01', outfit = 91},
    {model = 'A_M_M_UniCorpse_01', outfit = 92},
    {model = 'A_M_M_UniCorpse_01', outfit = 93},
    {model = 'A_M_M_UniCorpse_01', outfit = 94},
    {model = 'A_M_M_UniCorpse_01', outfit = 95},
    {model = 'A_M_M_UniCorpse_01', outfit = 96},
    {model = 'A_M_M_UniCorpse_01', outfit = 97},
    {model = 'A_M_M_UniCorpse_01', outfit = 98},
    {model = 'A_M_M_UniCorpse_01', outfit = 99},
    {model = 'A_M_M_UniCorpse_01', outfit = 100},
    {model = 'A_M_M_UniCorpse_01', outfit = 101},
    {model = 'A_M_M_UniCorpse_01', outfit = 102},
    {model = 'A_M_M_UniCorpse_01', outfit = 103},
    {model = 'A_M_M_UniCorpse_01', outfit = 104},
    {model = 'A_M_M_UniCorpse_01', outfit = 107},
    {model = 'A_M_M_UniCorpse_01', outfit = 108},
    {model = 'A_M_M_UniCorpse_01', outfit = 110},
    {model = 'A_M_M_UniCorpse_01', outfit = 111},
    {model = 'A_M_M_UniCorpse_01', outfit = 112},
    {model = 'A_M_M_UniCorpse_01', outfit = 113},
    {model = 'A_M_M_UniCorpse_01', outfit = 114},
    {model = 'A_M_M_UniCorpse_01', outfit = 115},
    {model = 'A_M_M_UniCorpse_01', outfit = 116},
    {model = 'A_M_M_UniCorpse_01', outfit = 117},
    {model = 'A_M_M_UniCorpse_01', outfit = 118},
    {model = 'A_M_M_UniCorpse_01', outfit = 120},
    {model = 'A_M_M_UniCorpse_01', outfit = 122},
    {model = 'A_M_M_UniCorpse_01', outfit = 125},
    {model = 'A_M_M_UniCorpse_01', outfit = 126},
    {model = 'A_M_M_UniCorpse_01', outfit = 127},
    {model = 'A_M_M_UniCorpse_01', outfit = 128},
    {model = 'A_M_M_UniCorpse_01', outfit = 130},
    {model = 'A_M_M_UniCorpse_01', outfit = 131},
    {model = 'A_M_M_UniCorpse_01', outfit = 132},
    {model = 'A_M_M_UniCorpse_01', outfit = 133},
    {model = 'A_M_M_UniCorpse_01', outfit = 134},
    {model = 'A_M_M_UniCorpse_01', outfit = 136},
    {model = 'A_M_M_UniCorpse_01', outfit = 137},
    {model = 'A_M_M_UniCorpse_01', outfit = 138},
    {model = 'A_M_M_UniCorpse_01', outfit = 139},
    {model = 'A_M_M_UniCorpse_01', outfit = 141},
    {model = 'A_M_M_UniCorpse_01', outfit = 142},
    {model = 'A_M_M_UniCorpse_01', outfit = 143},
    {model = 'A_M_M_UniCorpse_01', outfit = 148},
    {model = 'A_M_M_UniCorpse_01', outfit = 149},
    {model = 'A_M_M_UniCorpse_01', outfit = 158},
    {model = 'A_M_M_UniCorpse_01', outfit = 159},
    {model = 'A_M_M_UniCorpse_01', outfit = 160},
    {model = 'A_M_M_UniCorpse_01', outfit = 161},
    {model = 'A_M_M_UniCorpse_01', outfit = 162},
    {model = 'A_M_M_UniCorpse_01', outfit = 163},
    {model = 'A_M_M_UniCorpse_01', outfit = 164},
    {model = 'A_M_M_UniCorpse_01', outfit = 165},
    {model = 'A_M_M_UniCorpse_01', outfit = 167},
    {model = 'A_M_M_UniCorpse_01', outfit = 168},
    {model = 'A_M_M_UniCorpse_01', outfit = 170},
    {model = 'A_M_M_UniCorpse_01', outfit = 175},
    {model = 'A_M_M_UniCorpse_01', outfit = 180},
    {model = 'A_F_M_UniCorpse_01', outfit = 0},
    {model = 'A_F_M_UniCorpse_01', outfit = 1},
    {model = 'A_F_M_UniCorpse_01', outfit = 2},
    {model = 'A_F_M_UniCorpse_01', outfit = 4},
    {model = 'A_F_M_UniCorpse_01', outfit = 5},
    {model = 'A_F_M_UniCorpse_01', outfit = 6},
    {model = 'A_F_M_UniCorpse_01', outfit = 7},
    {model = 'A_F_M_UniCorpse_01', outfit = 8},
    {model = 'A_F_M_UniCorpse_01', outfit = 11},
    {model = 'A_F_M_UniCorpse_01', outfit = 12},
    {model = 'A_F_M_UniCorpse_01', outfit = 16},
    {model = 'A_F_M_UniCorpse_01', outfit = 17},
    {model = 'A_F_M_UniCorpse_01', outfit = 18},
    {model = 'A_F_M_UniCorpse_01', outfit = 19},
    {model = 'A_F_M_UniCorpse_01', outfit = 20},
    {model = 'A_F_M_UniCorpse_01', outfit = 21},
    {model = 'A_F_M_UniCorpse_01', outfit = 22},
    {model = 'A_F_M_UniCorpse_01', outfit = 23},
    {model = 'A_F_M_UniCorpse_01', outfit = 24},
    {model = 'A_F_M_UniCorpse_01', outfit = 25},
    {model = 'A_F_M_UniCorpse_01', outfit = 26},
    {model = 'A_F_M_UniCorpse_01', outfit = 37},
    {model = 'A_F_M_UniCorpse_01', outfit = 38},
    {model = 'A_F_M_UniCorpse_01', outfit = 39},
    {model = 'A_F_M_UniCorpse_01', outfit = 40},
    {model = 'A_F_M_UniCorpse_01', outfit = 41},
    {model = 'A_F_M_UniCorpse_01', outfit = 42},
    {model = 'A_F_M_UniCorpse_01', outfit = 43},
    {model = 'A_F_M_UniCorpse_01', outfit = 44},
    {model = 'A_F_M_UniCorpse_01', outfit = 48},
    {model = 'U_M_M_APFDeadMan_01', outfit = 0}
}
cSpawnz = cSpawnz()
