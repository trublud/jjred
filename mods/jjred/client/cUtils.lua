--cSettingsHud:Notify("hit")
--[[
     Events:Subscribe("ChatMessage", function(args)
    -- store the most recent chat message
    KeyValueStore:Set("MostRecentChatMessage", args.text)

    -- this is how we can retrieve the most recent chat message
    KeyValueStore:Get("MostRecentChatMessage", function(value)
        print("The most recent chat message is:", value)
    end)
end)

local keys_to_get = {"MyKey1", "MyKey2"}
KeyValueStore:Get(keys_to_get, function(values)
    local value1 = values["MyKey1"]
    local value2 = values["MyKey2"]
end)
]]
local icons = {
    "ABIGAIL", "ACTING_UP", "AGENT14", "ALL_PLAYERS_CONF", "AMANDA",
    "AMMUNATION", "ANDREAS", "ANTONIA", "ARTHUR", "ASHLEY", "BANK_BOL",
    "BANK_FLEECA", "BANK_MAZE", "BARRY", "BEVERLY", "BIKESITE", "BLANK_ENTRY",
    "BLIMP", "BLIMP2", "BLOCKED", "BOATSITE", "BOATSITE2", "BROKEN_DOWN_GIRL",
    "BRYONY", "BUGSTARS", "CALL911", "CARSITE", "CARSITE2", "CARSITE3",
    "CARSITE4", "CASINO", "CASINO_MANAGER", "CASTRO", "CHAT_CALL", "CHEF",
    "CHENG", "CHENGSR", "CHOP", "COMIC_STORE", "CRIS", "DAVE", "DEFAULT",
    "DENISE", "DETONATEBOMB", "DETONATEPHONE", "DEVIN", "DIAL_A_SUB", "DOM",
    "DOMESTIC_GIRL", "DREYFUSS", "DR_FRIEDLANDER", "ENGLISH_DAVE", "EPSILON",
    "ESTATE_AGENT", "FACEBOOK", "FILMNOIR", "FLOYD", "FRANKLIN",
    "FRANK_TREV_CONF", "GANGAPP", "GAYMILITARY", "HAO", "HITCHER_GIRL",
    "HUMANDEFAULT", "HUNTER", "JIMMY", "JIMMY_BOSTON", "JOE", "JOSEF", "JOSH",
    "LAMAR", "LAZLOW", "LAZLOW2", "LESTER", "LESTER_DEATHWISH",
    "LEST_FRANK_CONF", "LEST_MIKE_CONF", "LIFEINVADER", "LJT", "LS_CUSTOMS",
    "LS_TOURIST_BOARD", "MALC", "MANUEL", "MARNIE", "MARTIN", "MARY_ANN",
    "MAUDE", "MECHANIC", "MICHAEL", "MIKE_FRANK_CONF", "MIKE_TREV_CONF",
    "MILSITE", "MINOTAUR", "MOLLY", "MP_ARMY_CONTACT", "MP_BIKER_BOSS",
    "MP_BIKER_MECHANIC", "MP_BRUCIE"
}
local arr = { "standard", "standard_long",  "advanced", "advanced_long" }
local types = { "success", "warning", "danger" }
local jTrains = {
    'NORTHSTEAMER01X',
    'PRIVATESTEAMER01X',
    'WINTERSTEAMER',
    'trolley01x'
}
local Peds = {}
local Vehicles = {}


JJFunc = class()
function JJFunc:__init()

    function EnableEagleeye(player, enable)
        Citizen.InvokeNative(0xA63FCAD3A6FEC6D2, player, enable)
    end
    
    AddEventHandler("playerSpawned", function(spawnInfo)
        EnableEagleeye(PlayerId(), true)
    end)
    
    AddEventHandler("onResourceStop", function(resourceName)
        if GetCurrentResourceName() ~= resourceName then
            return
        end
    
        EnableEagleeye(PlayerId(), false)
    end)
    CreateThread(function()
        while true do
         
            Peds = {}
           
         
            for ped in self.EnumeratePeds() do
                table.insert(Peds, ped)
            end
        --    print ("Peds:"..#Peds)

        Vehicles = {}
            for veh in self.EnumerateVehicles() do
                table.insert(Vehicles, veh)
            end
           
                  --  print ("Vehicles:"..#Vehicles)
                 --cSettingsHud:Notify("hit")
   
           

                -- TriggerEvent('notifications:notify', "first text", random_elem(icons).Thumb, 8000) 
            Wait(7000)
        end 
            
        --[[DrawSprite(
            random_elem(icons).Thumb,
            random_elem(icons).Thumb,
            550, 
            550, 
            220, 
            220, 
            500, 255, 255, 255, 100
        )]]
    end)
    
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

function JJFunc:EnumerateEntities(firstFunc, nextFunc, endFunc)
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

function JJFunc:EnumerateObjects()
	return JJFunc:EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function JJFunc:EnumeratePeds()
	return JJFunc:EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function JJFunc:EnumerateVehicles()
	return JJFunc:EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function JJFunc:IsTrain(entity)
	local model = GetEntityModel(entity)

	for _, train in ipairs(jTrains) do
		if model == GetHashKey(train) then
			return true
		end
	end

	return false
end

function  JJFunc:IsNearby(myPed, entity, distance)
	if not distance then
		return true
	end

	local myCoords = GetEntityCoords(myPed)
	local entityCoords = GetEntityCoords(entity)

	return #(myCoords.xy - entityCoords.xy) <= distance
end
function JJFunc:GetPedsandVehicles()
	return Peds,Vehicles 
end

function JJFunc:GetTrains()
	local jjtrains = nil
    for _, vehicle in ipairs(Vehicles) do
		if IsTrain(vehicle) then
            table.insert(jjtrains, vehicle)
		end
	end
    return jjtrains
end
function random_elem(tb)
    local keys = {}
    for k in pairs(tb) do table.insert(keys, k) end
    return tb[keys[math.random(#keys)]]
end
if JJRedConfig.Plugins.redemrp then
    TriggerEvent('redem_roleplay:NotifyLeft', "first text", "second text",
                 random_elem(icons), "tick", 8000)

    TriggerEvent("redem_roleplay:Tip", 'hi', 'hi', '🛃: xoxo' ) -- , 3000)
    AddEventHandler("redemrp_notification:start", function(text, Interval)
         cSettingsHud:Notify( '🛃: ' .. text ) -- , 3000)
    end)

    AddEventHandler("redem_roleplay:Tip", function(text, Interval)
         cSettingsHud:Notify( '🛃: ' .. text ) -- , 3000)
    end)
end
if JJRedConfig.Plugins.FeedM then
    AddEventHandler("FeedM:showAdvancedNotification",
                    function(Title, Subject, Message, Icon, Interval, Type)
        --  ShowAdvancedNotification(Title, Subject, Message, Icon, Interval, Type)
         cSettingsHud:Notify( '🛃: ' .. Message ) -- , 3000)
    end)
end
AddEventHandler("FeedM:showNotification", function(Message, Interval, Type)
     cSettingsHud:Notify( '🛃: ' .. ' :' .. Message ) -- , 3000)
    --  ShowNotification(Message, Interval, Type)
end)

RegisterNetEvent("JJz:messageerror")
AddEventHandler("JJz:messageerror", function(msg)
  cSettingsHud:Notify(msg)

end)

JJFunc=JJFunc()