cSettingsHud = class()
--cSettingsHud:Notify("hit")
--Events:Subscribe("jjred:updatestatshud",     function(slot, data) huddata[slot] = data end)
--Network:Subscribe("jjred:updatestatshud", function(slot, data) huddata[slot] = data end)

 
local train_speed = 0

--self.ui:Hide()
local open = false
--[[
RegisterNetEvent('jjred:updatestatshud')
AddEventHandler('jjred:updatestatshud',
                function(slot, data) huddata[slot] = data end)
]]


function cSettingsHud:__init()
  huddata = {
    "1", true, "💰", "👻", "🍀", "👽", "✨", "🤮", "👎", "👍",
    "🧟‍♂️", "🤠", "💪"
}
hdata = {}
    -- Create the UIInstance and store it in our class for easy access
    self.ui = UI:Create({
        name = "welcome_message",
        path = "mods/jjred/client/ui/index.html"
    })

    Events:Subscribe("jjred:updatestatshud",     function(slot, data) huddata[slot] = data end)
    Network:Subscribe("jjred:updatestatshud", function(slot, data) huddata[slot] = data end)

    self.ui:Subscribe("wantedlevel", function(wantedlevel) 
     
      cSettingsHud:Notify(wantedlevel)
    end)
    self.ui:Subscribe("trainspeed", function(trainspeed) 
      train_speed=trainspeed
      TriggerEvent('jjred:settrainspeed',trainspeed)
      cSettingsHud:Notify("Trainspeed:  "..trainspeed)
    end)
    -- Wait until the UI is ready to CallEvent on it. If we CallEvent before it has loaded, it might not work
    self.ui:Subscribe('Ready', function() 
      --  self:UIReady() 
     -- self:ShowSettings()
   end)
   self.ui:Subscribe('sjump', function(data)
   
    Events:Fire("sjump", data)

end)
self.ui:Subscribe('pstamina', function(data)
  Events:Fire("pstamina", data)

end)
self.ui:Subscribe('closedata', function(data)
  Events:Fire("closedata", data)
 
end)
    -- Control.Jump is normally space, so we'll use that here
    self.key_to_hide = Control.Jump
    --self.key_to_settings = Control.GameMenuCancel
    self.key_to_settings = Control.PushToTalk
    -- First tell KeyPress to look for this key being pressed
    KeyPress:Subscribe(self.key_to_hide)
    KeyPress:Subscribe(self.key_to_settings)
    -- Then subscribe to the KeyUp event, which KeyPress will call when the key is pressed and you release it
    Events:Subscribe('KeyUp', function(args) self:KeyUp(args) end)

    self.welcome_message =
        "Hello %s! Welcome to the server! [JUMP] to hide this."
        
CreateThread(function()

  while true do
      Wait(1500)
      if train_speed ~= 0 then 
      SetTrainSpeed(
        train --[[ Vehicle ]], 
        train_speed --[[ number ]]
      )
    end
      self.ui:CallEvent("jjmessage", {action = "addmstatshud",data=       cSettingsHud:getHudData()})
  end
end)
Events:Subscribe("NOTIFY",function(args) 
  print("NOTIFY")
  print(args)
  cSettingsHud:Notify(args) end)
end


function cSettingsHud:Notify(msg)

  
  self.ui:CallEvent("jjmessage", {action = "notify",data= msg})
  if JJRedConfig.Plugins.LRP then
  title = "JJsCoolHud"
            mensagem = msg
            exports['LRP_Notify']:DisplayLeftNotification(title,
            mensagem,
            'HUD_TOASTS',
            'toast_mp_status_change',
            5000) 	 
  end
end
function cSettingsHud:UIReady()
    -- CallEvent on the UI to send the message we want to display
    self.ui:CallEvent("DisplayMessage", {
        message = string.format(self.welcome_message,
                                LocalPlayer:GetPlayer():GetName())
    })
end

function cSettingsHud:KeyUp(args)
    -- Hide welcome message when key is pressed. You can also do this just in JavaScript, but we are showing more API here. :)
    if args.key == self.key_to_settings then
      --  self.ui:Hide()
    
--    elseif args.key == self.key_to_menu then
       
            open = true
            SetNuiFocus(true, true)
               self:ShowSettings() 
        --    self.ui:Show()
      --  self:ShowSettings()
   
    end
end
function cSettingsHud:getHudData()

  table.insert(hdata, {
    name = LocalPlayer:GetPlayer():GetName(),
    visible = 1,
    data1 = '❤️: ' .. GetEntityHealth(LocalPlayer:GetPedId()),
    data2 = huddata[3],
    data3 = huddata[4],
    data4 = huddata[5],
    data5 = huddata[6],
    data6 = huddata[7],
    data7 = huddata[8],
    data8 = huddata[9],
    data9 = huddata[10],
    data10 = huddata[11],
    data11 = huddata[12],
    data12 = huddata[13]
})
return hdata
end
function cSettingsHud:ShowSettings()

 
   
    
    -- CallEvent on the UI to send the message we want to display
   -- print( self.open)
   self.ui:CallEvent("jjmessage", {action = "addmstatshud",data=   self.getHudData()})
   self.ui:CallEvent("jjmessage", {action = "notifysettings",data=  "Move me around!"})
    self.ui:CallEvent("jjmessage", {action = "open"})
  --  self.hud_message = string.format('{action = "addmstatshud", data = %s}',data)
    
    SetNuiFocus(true, true)
end

--RegisterNUICallback("closedata", function(data, cb) open = 0 end)


CreateThread(function()

    while true do
        Wait(5)
        if IsControlPressed(0, 0xAC4BD4F1) then
             DisableControlAction(0, 0x9CC7A1A4, true)
            DisableControlAction(0, 0xD9D0E1C0, true)
           DisableControlAction(0, 0xD51B784F, true)
         --   DisableControlAction(0, 0x9CC7A1A4, true)
        --    DisableControlAction(0, 0xD9D0E1C0, true)
        --    DisableControlAction(0, 0xD51B784F, true)
        end

    end
end)




-- Initialize it as a singleton, because this is essentially a "welcome message manager"
cSettingsHud = cSettingsHud()
