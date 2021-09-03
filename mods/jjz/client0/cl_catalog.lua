local isOpen = false
local doOpen = false
local doClose = true
local active = false
local currentweapons = {}
local prop = {}
local code = nil
local store
local section = "foliage"

local gunstores = {
    [1] = {x = 2947.246, y = 1319.698, z = 44.88, h = 72.38},
    [2] = {x = 2716.972, y = -1286.010, z = 49.686, h = 40.09},
    [3] = {x = -281.255, y = 780.033, z = 119.553, h = 5.86},
    [4] = {x = 1323.141, y = -1322.304, z = 77.939, h = 343.25},
    [5] = {x = -5507.428, y = -2964.109, z = -0.578, h = 115.78}
}

local catalogue = {
    [1] = {x = 2947.246, y = 1319.698, z = 44.88, h = 72.38},
    [2] = {x = 2716.972, y = -1286.010, z = 49.686, h = 40.09},
    [3] = {x = -281.255, y = 780.033, z = 119.553, h = 5.86},
    [4] = {x = 1323.141, y = -1322.304, z = 77.939, h = 343.25},
    [5] = {x = -5507.428, y = -2964.109, z = -0.578, h = 115.78}
}

local weapons = {'P_12MOONSHINECRATE01', 'P_2NDFLRFRAME10X'}

RegisterNetEvent('JJzpp::SendCode')
AddEventHandler('JJzpp::SendCode', function(code1) code = code1 end)

Citizen.CreateThread(function()
    --[[  StorePrompt()
    while true do
        local sleep = 7
        local ped = PlayerPedId()
        local pedcoords = GetEntityCoords(ped)
        for i = 1, #gunstores do
        local distance = #(vector3(gunstores[i].x, gunstores[i].y, gunstores[i].z)-vector3(pedcoords["x"], pedcoords["y"], pedcoords["z"]))
            if distance < 100 then
                if distance < 2 then
                    sleep = 5
                    if PromptIsValid(store) and not active then
                        PromptSetVisible(store, true)
                        PromptSetEnabled(store, true)
                    end                   
                    if PromptHasHoldModeCompleted(store) then
                        PromptSetEnabled(store, false)
                        PromptSetVisible(store, false)
                        active = true
                        OpenUI()
                        FreezeEntityPosition(PlayerPedId(), true)
                    end
                else
                        if PromptIsValid(store) then
                            sleep = 50
                            PromptSetEnabled(store, false)
                            PromptSetVisible(store, false)
                        end                 
                    sleep = 1200
                end
            end
        end
        Citizen.Wait(sleep)
    end
    ]]
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        --     PromptSetEnabled(store, false)
        --     PromptSetVisible(store, false)
        FreezeEntityPosition(PlayerPedId(), false)
    end
end)

function StorePrompt()
    --   Citizen.CreateThread(function()
    --     store = PromptRegisterBegin()
    --   PromptSetControlAction(store, 0x5E723D8C)
    -- PromptSetText(store, CreateVarString(10, "LITERAL_STRING", "Browse the gun store"))
    --        PromptSetEnabled(store, 1)
    --      PromptSetVisible(store, 1)
    --    PromptSetHoldMode(store, 1)
    --  PromptRegisterEnd(store)
    --     PromptSetGroup(store,0,1)       
    --  end)
end

--[[
Citizen.CreateThread(function () 
    local book = GetHashKey("mp001_s_mp_catalogue01x")
    local pcoords = GetEntityCoords(PlayerPedId())
    RequestModel(book)
    while not HasModelLoaded(book) do
        Citizen.Wait(0)
    end
    
    for i=1,#catalogue do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, catalogue[i].x, catalogue[i].y, catalogue[i].z)
        SetBlipSprite(blip, -145868367, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Gun store")
    end

    for i=1,#catalogue do
        prop[i] = CreateObjectNoOffset(book, catalogue[i].x, catalogue[i].y, catalogue[i].z, false, false, false, false)
        SetEntityHeading(prop[i], catalogue[i].h)
        FreezeEntityPosition(prop[i], true)
    end
end)
]]
local ppages = {}

function startup()
    isOpen = false
    SetNuiFocus(isOpen, isOpen)
    SendNUIMessage({type = "OpenBookGui", value = false, pages = ppages})
end
function Purchase(data)
    --  TriggerServerEvent('JJzpp::getCode')
    Wait(200)
    --   messagealert(data.weapon)
    ExecuteCommand("JJpropp " .. data.weapon)
    CloseUI()
    --  TriggerServerEvent('JJzpp::Purchase',data.weapon,code)
end
function SpawnIt(data)
    --  TriggerServerEvent('JJzpp::getCode')
    Wait(200)
    --   messagealert(data.weapon)
    ExecuteCommand("JJpropit " .. data.weapon)
    CloseUI()
    --  TriggerServerEvent('JJzpp::Purchase',data.weapon,code)
end
function OpenUI(section2)
    local pi = 0
    isOpen = true
    local pppages = {}
    SetNuiFocus(isOpen, isOpen)
    local pagehtml =
        "<div class=\"ProductPurchaseButtons__buttons__14Q7z\"> <div class=\"ProductPurchaseButtons__button__1Vwwn\" tabindex=\"0\">  "
    local pagehtml0 =
        "<div class=\"ProductPurchaseButtons__buttons__14Q7z\"> <div class=\"ProductPurchaseButtons__button__1Vwwn\" tabindex=\"0\">  "
    local pagehtml2 = pagehtml0
    local pagehtml3 = pagehtml0
    local pagehtml4 = pagehtml0
    local pagehtml5 = pagehtml0
    local pagehtml6 = pagehtml0
    local pagehtml7 = pagehtml0
    if section2 == "foliage" then
        for k, pitem in pairs(JJ_objectMODELSfoliage) do
            pi = pi + 1
            if pi >= 1 and pi < 80 then
                pagehtml = pagehtml ..
                               " <button class=\"Button__btn__1bc-t Button__black__h0BRc\" data-ui-name=\"buyNow\" on,.=\"Buy('" ..
                               pitem ..
                               "',0)\" type=\"button\">    <span class=\"Button__text__2C2ug\">" ..
                               pitem .. "</span> </button>   "
                ppages[1] = {
                    ['content'] = pagehtml,
                    ['background'] = "",
                    ['backgroundColor'] = "#f2f2f2",
                    ['color'] = "white"
                }
            end

            if pi >= 80 and pi < 160 then
                pagehtml2 = pagehtml2 ..
                                " <button class=\"Button__btn__1bc-t Button__black__h0BRc\" data-ui-name=\"buyNow\" onclick=\"Buy('" ..
                                pitem ..
                                "',0)\" type=\"button\">    <span class=\"Button__text__2C2ug\">" ..
                                pitem .. "</span> </button>   "

                ppages[2] = {
                    ['content'] = pagehtml2,
                    ['background'] = "",
                    ['backgroundColor'] = "#f2f2f2",
                    ['color'] = "white"
                }
            end

            if pi >= 160 and pi < 240 then
                pagehtml3 = pagehtml3 ..
                                " <button class=\"Button__btn__1bc-t Button__black__h0BRc\" data-ui-name=\"buyNow\" onclick=\"Buy('" ..
                                pitem ..
                                "',0)\" type=\"button\">    <span class=\"Button__text__2C2ug\">" ..
                                pitem .. "</span> </button>   "

                ppages[3] = {
                    ['content'] = pagehtml3,
                    ['background'] = "",
                    ['backgroundColor'] = "#f2f2f2",
                    ['color'] = "white"
                }
            end

            if pi >= 240 and pi < 323 then
                pagehtml4 = pagehtml4 ..
                                " <button class=\"Button__btn__1bc-t Button__black__h0BRc\" data-ui-name=\"buyNow\" onclick=\"Buy('" ..
                                pitem ..
                                "',0)\" type=\"button\">    <span class=\"Button__text__2C2ug\">" ..
                                pitem .. "</span> </button>   "

                ppages[4] = {
                    ['content'] = pagehtml4,
                    ['background'] = "",
                    ['backgroundColor'] = "#f2f2f2",
                    ['color'] = "white"
                }
            end

            if pi >= 323 and pi < 407 then
                pagehtml5 = pagehtml5 ..
                                " <button class=\"Button__btn__1bc-t Button__black__h0BRc\" data-ui-name=\"buyNow\" onclick=\"Buy('" ..
                                pitem ..
                                "',0)\" type=\"button\">    <span class=\"Button__text__2C2ug\">" ..
                                pitem .. "</span> </button>   "

                ppages[5] = {
                    ['content'] = pagehtml5,
                    ['background'] = "",
                    ['backgroundColor'] = "#f2f2f2",
                    ['color'] = "white"
                }
            end

        end

    end

    SendNUIMessage({type = "OpenBookGui2", value = true, pages = ppages})
end

function OpenSearchUI(searchstr, section2)
    local f = false
    local str = searchstr
    str = str:upper()
    local strtbl = HASH_objectMODELS
    local tbl = HASH_objectMODELS
   
    local qpagehtml2 = nil
    local qpagehtml3 = nil
    local qpagehtml4 = nil
    local qpagehtml5 = nil
    local qpagehtml6 = nil
    local qpagehtml7 = nil
   
  

    if section2 ~= nil then
        --   local sName = string.format( "NAME%02d", i )
        --    tTbl[sName] 
        --     tbl[tostring(JJ_objectMODELS)..section2] = HASH_objectMODELS
        --   messageerror(tbl)
    end
    local pi = 0
    isOpen = true
   
    SetNuiFocus(isOpen, isOpen)
    local qpagehtml =
        "<div class=\"ProductPurchaseButtons__buttons__14Q7z\"> <div class=\"ProductPurchaseButtons__button__1Vwwn\" tabindex=\"0\">  "
    local qpagehtml0 =
        "<div class=\"ProductPurchaseButtons__buttons__14Q7z\"> <div class=\"ProductPurchaseButtons__button__1Vwwn\" tabindex=\"0\">  "
     qpagehtml2 = qpagehtml0
     qpagehtml3 = qpagehtml0
     qpagehtml4 = qpagehtml0
     qpagehtml5 = qpagehtml0
     qpagehtml6 = qpagehtml0
     qpagehtml7 = qpagehtml0

    for k, pitem in pairs(tbl) do
        if string.match(pitem, '.*' .. str .. '.*') then
            pi = pi + 1
            if pi >= 1 and pi < 80 then
                qpagehtml = qpagehtml ..
                               " <button class=\"Button__btn__1bc-t Button__black__h0BRc\" data-ui-name=\"buyNow\" onclick=\"SPAWNit('" ..
                               pitem ..
                               "',0)\" type=\"button\">    <span class=\"Button__text__2C2ug\">" ..
                               pitem .. "</span> </button> - "
                ppages[1] = {
                    ['content'] = qpagehtml,
                    ['background'] = "",
                    ['backgroundColor'] = "#f2f2f2",
                    ['color'] = "white"
                }
            end
            if pi >= 80 and pi < 160 then
                qpagehtml2 = qpagehtml2 ..
                                " <button class=\"Button__btn__1bc-t Button__black__h0BRc\" data-ui-name=\"buyNow\" onclick=\"SPAWNit('" ..
                                pitem ..
                                "',0)\" type=\"button\">    <span class=\"Button__text__2C2ug\">" ..
                                pitem .. "</span> </button>   "

                ppages[2] = {
                    ['content'] = qpagehtml2,
                    ['background'] = "",
                    ['backgroundColor'] = "#f2f2f2",
                    ['color'] = "white"
                }
            end

            if pi >= 160 and pi < 240 then
                qpagehtml3 = qpagehtml3 ..
                                " <button class=\"Button__btn__1bc-t Button__black__h0BRc\" data-ui-name=\"buyNow\" onclick=\"SPAWNit('" ..
                                pitem ..
                                "',0)\" type=\"button\">    <span class=\"Button__text__2C2ug\">" ..
                                pitem .. "</span> </button>   "

                ppages[3] = {
                    ['content'] = qpagehtml3,
                    ['background'] = "",
                    ['backgroundColor'] = "#f2f2f2",
                    ['color'] = "white"
                }
            end

            if pi >= 240 and pi < 323 then
                qpagehtml4 = qpagehtml4 ..
                                " <button class=\"Button__btn__1bc-t Button__black__h0BRc\" data-ui-name=\"buyNow\" onclick=\"SPAWNit('" ..
                                pitem ..
                                "',0)\" type=\"button\">    <span class=\"Button__text__2C2ug\">" ..
                                pitem .. "</span> </button>   "

                ppages[4] = {
                    ['content'] = qpagehtml4,
                    ['background'] = "",
                    ['backgroundColor'] = "#f2f2f2",
                    ['color'] = "white"
                }
            end

            if pi >= 323 and pi < 407 then
                qpagehtml5 = qpagehtml5 ..
                                " <button class=\"Button__btn__1bc-t Button__black__h0BRc\" data-ui-name=\"buyNow\" onclick=\"SPAWNit('" ..
                                pitem ..
                                "',0)\" type=\"button\">    <span class=\"Button__text__2C2ug\">" ..
                                pitem .. "</span> </button>   "

                ppages[5] = {
                    ['content'] = qpagehtml5,
                    ['background'] = "",
                    ['backgroundColor'] = "#f2f2f2",
                    ['color'] = "white"
                }
            end
            if pi >= 407 and pi < 485 then
                qpagehtml6 = qpagehtml6 ..
                                " <button class=\"Button__btn__1bc-t Button__black__h0BRc\" data-ui-name=\"buyNow\" onclick=\"SPAWNit('" ..
                                pitem ..
                                "',0)\" type=\"button\">    <span class=\"Button__text__2C2ug\">" ..
                                pitem .. "</span> </button>   "

                ppages[6] = {
                    ['content'] = qpagehtml6,
                    ['background'] = "",
                    ['backgroundColor'] = "#f2f2f2",
                    ['color'] = "white"
                }
            end
            if pi >= 485 and pi < 564 then
                qpagehtml7 = qpagehtml7 ..
                                " <button class=\"Button__btn__1bc-t Button__black__h0BRc\" data-ui-name=\"buyNow\" onclick=\"SPAWNit('" ..
                                pitem ..
                                "',0)\" type=\"button\">    <span class=\"Button__text__2C2ug\">" ..
                                pitem .. "</span> </button>   "

                ppages[7] = {
                    ['content'] = qpagehtml7,
                    ['background'] = "",
                    ['backgroundColor'] = "#f2f2f2",
                    ['color'] = "white"
                }
            end
            --   PropPlacer(pitem)
            --  break;

        end

    end

    SendNUIMessage({type = "OpenBookGui2", value = true, pages = ppages})
end

function CloseUI()
    isOpen = false
    SetNuiFocus(isOpen, isOpen)
    active = false
    FreezeEntityPosition(PlayerPedId(), false)
    SendNUIMessage({type = "OpenBookGui2", value = false})
end

Citizen.CreateThread(function(...)
    while true do
        Citizen.Wait(5)

        if doOpen then
            doOpen = false
            OpenUI(section)
        elseif doClose then
            doClose = false
            CloseUI()
        end
    end
end)

RegisterNetEvent('JJzpp::giveammo')
AddEventHandler('JJzpp::giveammo', function(type, code1)
    TriggerServerEvent('JJzpp::getCode')
    Wait(200)
    if code == code1 then
        local ammotype = GetPedAmmoTypeFromWeapon(PlayerPedId(), type) -- dont even ask how or why this works.
        local ammo = GetPedAmmoByType(PlayerPedId(), ammotype) -- If you have a better way please do a push request and save me from this shit -steady
        local ammo = ammo + 10
        SetPedAmmo(PlayerPedId(), GetHashKey(type), ammo)
    end
end)

RegisterCommand('openui', function(...)

    active = true
    OpenUI(section)
end)

RegisterCommand('JJpropsearcher', function(source, args, rawCommand)

    active = true
    OpenSearchUI(args[1], args[2])
end)

RegisterCommand('closeui', function(...) doClose = true; end)
RegisterNUICallback('Spawnit', SpawnIt)
RegisterNUICallback('close', CloseUI)

