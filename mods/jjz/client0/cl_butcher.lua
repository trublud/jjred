local ButcherPrompt
local hasAlreadyEnteredMarker
local currentZone = nil

local PromptGorup = GetRandomIntInRange(0, 0xffffff)

function SetupButcherPrompt()
    
    for k = 1, #Config.shops do
       
        local blip = N_0x554d9d53f696d002(1664425300, Config.shops[k]["coords"].x, Config.shops[k]["coords"].y, Config.shops[k]["coords"].z)
        SetBlipSprite(blip, 1475879922, 1)
        SetBlipScale(blip, 0.1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Butcher Shop")

   -- Citizen.InvokeNative(0x45F13B7E0A15C880, 693035517, Config.shops[k]["coords"].x, Config.shops[k]["coords"].y, Config.shops[k]["coords"].z, 1)
    end
          
    Citizen.CreateThread(function()
        local str = 'Sell Item'
        ButcherPrompt = PromptRegisterBegin()
        PromptSetControlAction(ButcherPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ButcherPrompt, str)
        PromptSetEnabled(ButcherPrompt, true)
        PromptSetVisible(ButcherPrompt, true)
        PromptSetHoldMode(ButcherPrompt, true)
        PromptSetGroup(ButcherPrompt, PromptGorup)
        PromptRegisterEnd(ButcherPrompt)
    end)
end

Citizen.CreateThread(function()
    SetupButcherPrompt()
	while true do
		Wait(500)
		local isInMarker, tempZone = false
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for _,v in pairs(Config.shops) do 
            local distance = #(coords - v.coords)
            if distance < 1.5 then
                local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
                if holding ~= false then
                    isInMarker  = true
                    tempZone = 'butcher'
                end
            end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			currentZone = tempZone
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			currentZone = nil
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

        if currentZone then
            local label  = CreateVarString(10, 'LITERAL_STRING', "Butcher")
            PromptSetActiveGroupThisFrame(PromptGorup, label)
            if PromptHasHoldModeCompleted(ButcherPrompt) then
                Selltobutcher()
				currentZone = nil
			end
        else
			Citizen.Wait(500)
		end
	end
end)

function DeleteThis(holding)
    NetworkRequestControlOfEntity(holding)
    SetEntityAsMissionEntity(holding, true, true)
    Wait(100)
    DeleteEntity(holding)
    Wait(500)
    local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
    local holdingcheck = GetPedType(entitycheck)
    if holdingcheck == 0 then
        return true
    else
        return false
    end
end

function Selltobutcher()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    for k = 1, #Config.shops do 
        local distance = #(Config.shops[k]["coords"] - coords)
        
         
        if distance < 3.0 then
            local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
            local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
            local model = GetEntityModel(holding)
            local type = GetPedType(holding)
            if holding ~= false then
                for i, row in pairs(Config.Animal) do
                    if type == 28 then
                        if model == Config.Animal[i]["model"] then
                            local reward = Config.shops[k]["gain"] * Config.Animal[i]["reward"]
                            local level = Config.shops[k]["gain"] * Config.Animal[i]["xp"]

                            local deleted = DeleteThis(holding)
            
                            if deleted then
                                TriggerServerEvent("cryptos_butcher:giveitem", Config.Animal[i]["item"], 1)
                                TriggerServerEvent("cryptos_butcher:reward", reward, level)
                                TriggerEvent("redemrp_notification:start", "You earned $" .. reward .. ", " .. level .. " xp and " .. Config.Animal[i]["item"] .. ' Meat', 5, "success")
                            else
                                TriggerEvent("redemrp_notification:start", "DELETE ENTITY NATIVE IS SCUFFED - RELOG PLZ", 2, "success")
                            end

                        end
                    end
                    if quality ~= false then
                        if quality == Config.Animal[i]["poor"] then

                            local rewardresult = Config.shops[k]["gain"] * Config.Animal[i]["reward"]
                            local levelresult = Config.shops[k]["gain"] * Config.Animal[i]["xp"]
                            local reward = rewardresult * 0.5
                            local level = levelresult * 0.5

                            local deleted = DeleteThis(holding)
            
                            if deleted then
                                TriggerServerEvent("cryptos_butcher:reward", reward, level)
                                TriggerEvent("redemrp_notification:start", "You earned $" .. reward .. " and " .. level .. " xp", 5, "success")
                            else
                                TriggerEvent("redemrp_notification:start", "DELETE ENTITY NATIVE IS SCUFFED - RELOG PLZ", 2, "success")
                            end

                        elseif quality == Config.Animal[i]["good"] then

                            local rewardresult = Config.shops[k]["gain"] * Config.Animal[i]["reward"]
                            local levelresult = Config.shops[k]["gain"] * Config.Animal[i]["xp"]
                            local reward = rewardresult * 0.75
                            local level = levelresult * 0.75

                            local deleted = DeleteThis(holding)
            
                            if deleted then
                                TriggerServerEvent("cryptos_butcher:reward", reward, level)
                                TriggerEvent("redemrp_notification:start", "You earned $" .. reward .. " and " .. level .. " xp", 5, "success")
                            else
                                TriggerEvent("redemrp_notification:start", "DELETE ENTITY NATIVE IS SCUFFED - RELOG PLZ", 2, "success")
                            end

                        elseif quality == Config.Animal[i]["perfect"] then

                            local reward = Config.shops[k]["gain"] * Config.Animal[i]["reward"]
                            local level = Config.shops[k]["gain"] * Config.Animal[i]["xp"]

                            local deleted = DeleteThis(holding)
            
                            if deleted then
                                TriggerServerEvent("cryptos_butcher:reward", reward, level)
                                TriggerEvent("redemrp_notification:start", "You earned $" .. reward .. " and " .. level .. " xp", 5, "success")
                            else
                                TriggerEvent("redemrp_notification:start", "DELETE ENTITY NATIVE IS SCUFFED - RELOG PLZ", 2, "success")
                            end

                        end
                    end
                end
            else
                TriggerEvent("redemrp_notification:start", "Not Holding Anything", 2, "error")
            end
        end
    end
end
