cPowers = class()
local spawnhost = nil
function cPowers:__init()
  
  --  getter_setter(self, "money")
   -- getter_setter(self, "gold")
   -- self:SetMoney(starting_money)
   -- self:SetGold(starting_gold)
  -- self:vuser = nil
  -- self:vident = nil
  -- self:vgroup = nil
  -- self:VORPCore = {}
   self.slowmo = false
   self.forcedslowmo = false
   self.allowedhost = nil
   self.slowmo_key = Control.SpecialAbility 
   -- First tell KeyPress to look for this key being pressed
   for k,switzkeys in pairs(Control) do
    KeyPress:Subscribe(switzkeys)
   end

   KeyPress:Subscribe(self.slowmo_key)
   Events:Subscribe('KeyUp', function(args) print (args.key) self:KeyUp(args) end)


   function cPowers:KeyUp(args)
   print("key pressed "..args.key)
    -- Hide welcome message when key is pressed. You can also do this just in JavaScript, but we are showing more API here. :)
    if args.key == self.slowmo_key then
        self.SlowMo(LocalPlayer:GetPlayerId())
  -- print("key pressed!!")
    end
end


   Events:Subscribe("updateAllowedHost", function(args)
    if args ~= nil then allowedhost = args end
end)
    Citizen.CreateThread(function()
        local flashSpeed = JJRedConfig.flashspeed
        local veh2 = 999
        local ped = PlayerPedId()
        local crazysled = true
        while true do
    
            if jjstats.devtools then
                SetEveryoneIgnorePlayer(LocalPlayer:GetPlayerId(), true)
                SetPedWetnessEnabledThisFrame(
                    LocalPlayer:GetPedId() --[[ Ped ]]
                )
            else
                if not jjstats.devtools then
                    SetEveryoneIgnorePlayer(LocalPlayer:GetPlayerId(), false)
                end
            end
            if jjstats.stamina then
                SetSwimMultiplierForPlayer(LocalPlayer:GetPlayerId(), 1.49)
                RestorePlayerStamina(LocalPlayer:GetPlayerId(), 1.0)
                SetPedMoveRateOverride(GetPlayerPed(LocalPlayer:GetPlayerId()), 1.15)
    
                Citizen.InvokeNative(N_0x88e32db8c1a4aa4b, LocalPlayer:GetPlayerId(), 10)
                N_0x88e32db8c1a4aa4b(LocalPlayer:GetPlayerId(), 10)
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
                            SetAirDragMultiplierForPlayersVehicle(LocalPlayer:GetPlayerId() --[[ Player ]] ,
                                                                  1.0 --[[ number ]] )
                            SetVehicleForwardSpeed(veh, 44.49)
                            SetTrainSpeed(veh, 44.49)
                        end
    
                    end
                else
    
                end
    
            end
            if jjstats.superjump then 
               
                SetSuperJumpThisFrame(LocalPlayer:GetPlayerId()) 
               end
            if slowmo and not forcedslowmo and JJRedConfig.slowmopower then
                SetPedMoveRateOverride(GetPlayerPed(LocalPlayer:GetPlayerId()), flashSpeed)
                RestorePlayerStamina(LocalPlayer:GetPlayerId(), 1.0)
            else
                --   SetPedMoveRateOverride(GetPlayerPed(slowmoplayer), 1.0)
            end
          
            Citizen.Wait(0)
        end
end)
Events:Subscribe("sjump", function(args)
  
    jjstats.superjump = args
end)
Events:Subscribe("pstamina", function(args)
    jjstats.stamina = args
end)
Events:Subscribe("closedata", function(args)
  --  print (args)
    SetNuiFocus(false, false)

    open = 0
    for k, v in pairs(args) do jjstats[k] = v end
    for k, v in pairs(jjstats) do
   --     print(k)
   --     print(v)
    end
    SendNUIMessage({action = "hidenotify"})
    if not statshud then SendNUIMessage({action = "hidehud"}) end
end)


Events:Subscribe("slowmoMe", function()
    CreateThread(function()
        local i = 0
        SlowMo(LocalPlayer:GetPlayerId())
        TriggerEvent("jjred:showmehud")
        while i < JJRedConfig.slowmopowertime * 100 do
            slowmo, forcedslowmo = true, true
            Wait(0)
            i = i + 1
            TriggerServerEvent("jjred:addme", false, LocalPlayer:GetPlayerId(), "poof",
                               "invisible for " ..
                                   (JJRedConfig.slowmopowertime * 100 - i))

        end
        TriggerEvent("jjred:hidemehud")
        slowmo, forcedslowmo = true, true
        SlowMo(LocalPlayer:GetPlayerId())
    end)
    
end)


Events:Subscribe("heatvisionPlayer", function()
    
end)


Events:Subscribe("nightvisionPlayer", function()
    -- Nightvision()
end)



Events:Subscribe("updateSpawnHost", function(args)
    if args ~= nil then spawnhost = args end 
end)

 
end
function cPowers:ForceSlowMo(p, pspeed, pinvis, stime, sspeed)
    if not slowmo and not forcedslowmo then
        forcedslowmo, slowmo = true, true
        if pspeed then
            --    SetRunSprintMultiplierForPlayer(p, 3.0)
            SetPedMoveRateOverride(GetPlayerPed(p), 1.15)
            SetPedDesiredMoveBlendRatio(GetPlayerPed(p), 3.0)
        end
        SetTimeScale(sspeed)
        if pinvis then SetEntityVisible(GetPlayerPed(p), false, false) end
    else
        if pspeed then
            --     SetRunSprintMultiplierForPlayer(p, 0.89)

            SetPedMoveRateOverride(GetPlayerPed(p), 0.3)
            SetPedDesiredMoveBlendRatio(GetPlayerPed(p), 0.8)
        end
        SetTimeScale(1.0)
        if pinvis then SetEntityVisible(GetPlayerPed(p), true, true) end
        forcedslowmo, slowmo = false, false
    end
end
local slowmo = false
function cPowers:hudmessage(vis, data003, data004)
    local data = {}
    local value = 0
    local src = LocalPlayer:GetPlayerId()
    local visibley = vis
    local namer = GetPlayerName(LocalPlayer:GetPlayerId())
    local data01 = '🛡️: 0' --.. GetPedArmour(LocalPlayer:GetPedId())
    local data03 = data003
    local data04 = data004

    table.insert(data, {
        name = namer,
        visible = visibley,
        life = GetEntityHealth(LocalPlayer:GetPedId()),
        data10 = data03,
        data9 = data04
    })
    cSettingsHud.ui:CallEvent("jjmessage", {action = "paddme",data=   data})

   -- TriggerClientEvent("jjred:updateme", -1, data)
  --  SendNUIMessage({action = "paddme", data = data})
end
function cPowers:SlowMo(p)
    CreateThread(function()
        if not slowmo then
        local i = 0


       
            --SetPedScale(LocalPlayer:GetPedId(), 2)
            slowmo = true
            --  SetRunSprintMultiplierForPlayer(p, 3.0)
          --  SetPedMoveRateOverride(LocalPlayer:GetPedId(), 1.15)
         --   SetPedMinMoveBlendRatio(LocalPlayer:GetPedId(), 4.0)
         --   SetPedDesiredMoveBlendRatio(LocalPlayer:GetPedId(), 4.0)
            SetTimeScale(JJRedConfig.slowmospeed)
            if JJRedConfig.slowmoinvis then
                SetEntityVisible(GetPlayerPed(p), false, false)
            end
            Events:Fire("NOTIFY","Poof! your gone!")
            SetPedGravity(LocalPlayer:GetPedId(), false)
            while i < JJRedConfig.slowmopowertime * 100 do
              
                Wait(0)
                i = i + 1
               
                slowmo, forcedslowmo = true, true
                cPowers:hudmessage(slowmo, "Invisible for", (JJRedConfig.slowmopowertime * 100 - i))             
                 --  TriggerServerEvent("jjred:addme", false, LocalPlayer:GetPlayerId(), "poof",
                   --                "invisible for " ..
                     --                  (JJRedConfig.slowmopowertime * 100 - i))
    
                                      
            end
         Events:Fire("NOTIFY", "Your Back!")
          
                                       --   SetRunSprintMultiplierForPlayer(p, 0.89)
                                       SetTimeScale(1.0)
                                    --   SetPedMoveRateOverride(LocalPlayer:GetPedId(), 1.0)
                                     -- Citizen.InvokeNative(0xA5950E16B8F31052,LocalPlayer:GetPedId(), true, 10)
                                    -- SetPedMinMoveBlendRatio(LocalPlayer:GetPedId(), 3.0)
                                    -- SetPedDesiredMoveBlendRatio(LocalPlayer:GetPedId(), 3.0)
                                    
                                    --   SetPedDesiredMoveBlendRatio(LocalPlayer:GetPedId(), 0.8)
                                       if JJRedConfig.slowmoinvis then
                                           SetEntityVisible(GetPlayerPed(p), true, true)
                                       end
                                       slowmo = false
        elseif  slowmo then
      --  TriggerEvent("jjred:hidemehud")
     
      --  SlowMo(LocalPlayer:GetPlayerId())
      
      Events:Fire("NOTIFY", "EXHAUSTED!!")
          
      --   SetRunSprintMultiplierForPlayer(p, 0.89)
      SetTimeScale(1.0)
   --   SetPedMoveRateOverride(LocalPlayer:GetPedId(), 1.0)
    -- Citizen.InvokeNative(0xA5950E16B8F31052,LocalPlayer:GetPedId(), true, 10)
   -- SetPedMinMoveBlendRatio(LocalPlayer:GetPedId(), 3.0)
   -- SetPedDesiredMoveBlendRatio(LocalPlayer:GetPedId(), 3.0)
   
   --   SetPedDesiredMoveBlendRatio(LocalPlayer:GetPedId(), 0.8)
      if JJRedConfig.slowmoinvis then
          SetEntityVisible(GetPlayerPed(p), true, true)
      end
    --  slowmo = false
    end
    end) 
   
end
-- module.exports = {"100":"💯","1234":"🔢","interrobang":"⁉️","tm":"™️","information_source":"ℹ️","left_right_arrow":"↔️","arrow_up_down":"↕️","arrow_upper_left":"↖️","arrow_upper_right":"↗️","arrow_lower_right":"↘️","arrow_lower_left":"↙️","keyboard":"⌨","sunny":"☀️","cloud":"☁️","umbrella":"☔️","showman":"☃","comet":"☄","ballot_box_with_check":"☑️","coffee":"☕️","shamrock":"☘","skull_and_crossbones":"☠","radioactive_sign":"☢","biohazard_sign":"☣","orthodox_cross":"☦","wheel_of_dharma":"☸","white_frowning_face":"☹","aries":"♈️","taurus":"♉️","sagittarius":"♐️","capricorn":"♑️","aquarius":"♒️","pisces":"♓️","spades":"♠️","clubs":"♣️","hearts":"♥️","diamonds":"♦️","hotsprings":"♨️","hammer_and_pick":"⚒","anchor":"⚓️","crossed_swords":"⚔","scales":"⚖","alembic":"⚗","gear":"⚙","scissors":"✂️","white_check_mark":"✅","airplane":"✈️","email":"✉️","envelope":"✉️","black_nib":"✒️","heavy_check_mark":"✔️","heavy_multiplication_x":"✖️","star_of_david":"✡","sparkles":"✨","eight_spoked_asterisk":"✳️","eight_pointed_black_star":"✴️","snowflake":"❄️","sparkle":"❇️","question":"❓","grey_question":"❔","grey_exclamation":"❕","exclamation":"❗️","heavy_exclamation_mark":"❗️","heavy_heart_exclamation_mark_ornament":"❣","heart":"❤️","heavy_plus_sign":"➕","heavy_minus_sign":"➖","heavy_division_sign":"➗","arrow_heading_up":"⤴️","arrow_heading_down":"⤵️","wavy_dash":"〰️","congratulations":"㊗️","secret":"㊙️","copyright":"©️","registered":"®️","bangbang":"‼️","leftwards_arrow_with_hook":"↩️","arrow_right_hook":"↪️","watch":"⌚️","hourglass":"⌛️","fast_forward":"⏩","rewind":"⏪","arrow_double_up":"⏫","arrow_double_down":"⏬","black_right_pointing_double_triangle_with_vertical_bar":"⏭","black_left_pointing_double_triangle_with_vertical_bar":"⏮","black_right_pointing_triangle_with_double_vertical_bar":"⏯","alarm_clock":"⏰","stopwatch":"⏱","timer_clock":"⏲","hourglass_flowing_sand":"⏳","double_vertical_bar":"⏸","black_square_for_stop":"⏹","black_circle_for_record":"⏺","m":"Ⓜ️","black_small_square":"▪️","white_small_square":"▫️","arrow_forward":"▶️","arrow_backward":"◀️","white_medium_square":"◻️","black_medium_square":"◼️","white_medium_small_square":"◽️","black_medium_small_square":"◾️","phone":"☎️","telephone":"☎️","point_up":"☝️","star_and_crescent":"☪","peace_symbol":"☮","yin_yang":"☯","relaxed":"☺️","gemini":"♊️","cancer":"♋️","leo":"♌️","virgo":"♍️","libra":"♎️","scorpius":"♏️","recycle":"♻️","wheelchair":"♿️","atom_symbol":"⚛","fleur_de_lis":"⚜","warning":"⚠️","zap":"⚡️","white_circle":"⚪️","black_circle":"⚫️","coffin":"⚰","funeral_urn":"⚱","soccer":"⚽️","baseball":"⚾️","snowman":"⛄️","partly_sunny":"⛅️","thunder_cloud_and_rain":"⛈","ophiuchus":"⛎","pick":"⛏","helmet_with_white_cross":"⛑","chains":"⛓","no_entry":"⛔️","shinto_shrine":"⛩","church":"⛪️","mountain":"⛰","umbrella_on_ground":"⛱","fountain":"⛲️","golf":"⛳️","ferry":"⛴","boat":"⛵️","sailboat":"⛵️","skier":"⛷","ice_skate":"⛸","person_with_ball":"⛹","tent":"⛺️","fuelpump":"⛽️","fist":"✊","hand":"✋","raised_hand":"✋","v":"✌️","writing_hand":"✍","pencil2":"✏️","latin_cross":"✝","x":"❌","negative_squared_cross_mark":"❎","arrow_right":"➡️","curly_loop":"➰","loop":"➿","arrow_left":"⬅️","arrow_up":"⬆️","arrow_down":"⬇️","black_large_square":"⬛️","white_large_square":"⬜️","star":"⭐️","o":"⭕️","part_alternation_mark":"〽️","mahjong":"🀄️","black_joker":"🃏","a":"🅰️","b":"🅱️","o2":"🅾️","parking":"🅿️","ab":"🆎","cl":"🆑","cool":"🆒","free":"🆓","id":"🆔","new":"🆕","ng":"🆖","ok":"🆗","sos":"🆘","up":"🆙","vs":"🆚","koko":"🈁","sa":"🈂️","u7121":"🈚️","u6307":"🈯️","u7981":"🈲","u7a7a":"🈳","u5408":"🈴","u6e80":"🈵","u6709":"🈶","u6708":"🈷️","u7533":"🈸","u5272":"🈹","u55b6":"🈺","ideograph_advantage":"🉐","accept":"🉑","cyclone":"🌀","foggy":"🌁","closed_umbrella":"🌂","night_with_stars":"🌃","sunrise_over_mountains":"🌄","sunrise":"🌅","city_sunset":"🌆","city_sunrise":"🌇","rainbow":"🌈","bridge_at_night":"🌉","ocean":"🌊","volcano":"🌋","milky_way":"🌌","earth_africa":"🌍","earth_americas":"🌎","earth_asia":"🌏","globe_with_meridians":"🌐","new_moon":"🌑","waxing_crescent_moon":"🌒","first_quarter_moon":"🌓","moon":"🌔","waxing_gibbous_moon":"🌔","full_moon":"🌕","waning_gibbous_moon":"🌖","last_quarter_moon":"🌗","waning_crescent_moon":"🌘","crescent_moon":"🌙","new_moon_with_face":"🌚","first_quarter_moon_with_face":"🌛","last_quarter_moon_with_face":"🌜","full_moon_with_face":"🌝","sun_with_face":"🌞","star2":"🌟","stars":"🌠","thermometer":"🌡","mostly_sunny":"🌤","sun_small_cloud":"🌤","barely_sunny":"🌥","sun_behind_cloud":"🌥","partly_sunny_rain":"🌦","sun_behind_rain_cloud":"🌦","rain_cloud":"🌧","snow_cloud":"🌨","lightning":"🌩","lightning_cloud":"🌩","tornado":"🌪","tornado_cloud":"🌪","fog":"🌫","wind_blowing_face":"🌬","hotdog":"🌭","taco":"🌮","burrito":"🌯","chestnut":"🌰","seedling":"🌱","evergreen_tree":"🌲","deciduous_tree":"🌳","palm_tree":"🌴","cactus":"🌵","hot_pepper":"🌶","tulip":"🌷","cherry_blossom":"🌸","rose":"🌹","hibiscus":"🌺","sunflower":"🌻","blossom":"🌼","corn":"🌽","ear_of_rice":"🌾","herb":"🌿","four_leaf_clover":"🍀","maple_leaf":"🍁","fallen_leaf":"🍂","leaves":"🍃","mushroom":"🍄","tomato":"🍅","eggplant":"🍆","grapes":"🍇","melon":"🍈","watermelon":"🍉","tangerine":"🍊","lemon":"🍋","banana":"🍌","pineapple":"🍍","apple":"🍎","green_apple":"🍏","pear":"🍐","peach":"🍑","cherries":"🍒","strawberry":"🍓","hamburger":"🍔","pizza":"🍕","meat_on_bone":"🍖","poultry_leg":"🍗","rice_cracker":"🍘","rice_ball":"🍙","rice":"🍚","curry":"🍛","ramen":"🍜","spaghetti":"🍝","bread":"🍞","fries":"🍟","sweet_potato":"🍠","dango":"🍡","oden":"🍢","sushi":"🍣","fried_shrimp":"🍤","fish_cake":"🍥","icecream":"🍦","shaved_ice":"🍧","ice_cream":"🍨","doughnut":"🍩","cookie":"🍪","chocolate_bar":"🍫","candy":"🍬","lollipop":"🍭","custard":"🍮","honey_pot":"🍯","cake":"🍰","bento":"🍱","stew":"🍲","egg":"🍳","fork_and_knife":"🍴","tea":"🍵","sake":"🍶","wine_glass":"🍷","cocktail":"🍸","tropical_drink":"🍹","beer":"🍺","beers":"🍻","baby_bottle":"🍼","knife_fork_plate":"🍽","champagne":"🍾","popcorn":"🍿","ribbon":"🎀","gift":"🎁","birthday":"🎂","jack_o_lantern":"🎃","christmas_tree":"🎄","santa":"🎅","fireworks":"🎆","sparkler":"🎇","balloon":"🎈","tada":"🎉","confetti_ball":"🎊","tanabata_tree":"🎋","crossed_flags":"🎌","bamboo":"🎍","dolls":"🎎","flags":"🎏","wind_chime":"🎐","rice_scene":"🎑","school_satchel":"🎒","mortar_board":"🎓","medal":"🎖","reminder_ribbon":"🎗","studio_microphone":"🎙","level_slider":"🎚","control_knobs":"🎛","film_frames":"🎞","admission_tickets":"🎟","carousel_horse":"🎠","ferris_wheel":"🎡","roller_coaster":"🎢","fishing_pole_and_fish":"🎣","microphone":"🎤","movie_camera":"🎥","cinema":"🎦","headphones":"🎧","art":"🎨","tophat":"🎩","circus_tent":"🎪","ticket":"🎫","clapper":"🎬","performing_arts":"🎭","video_game":"🎮","dart":"🎯","slot_machine":"🎰","8ball":"🎱","game_die":"🎲","bowling":"🎳","flower_playing_cards":"🎴","musical_note":"🎵","notes":"🎶","saxophone":"🎷","guitar":"🎸","musical_keyboard":"🎹","trumpet":"🎺","violin":"🎻","musical_score":"🎼","running_shirt_with_sash":"🎽","tennis":"🎾","ski":"🎿","basketball":"🏀","checkered_flag":"🏁","snowboarder":"🏂","runner":"🏃","running":"🏃","surfer":"🏄","sports_medal":"🏅","trophy":"🏆","horse_racing":"🏇","football":"🏈","rugby_football":"🏉","swimmer":"🏊","weight_lifter":"🏋","golfer":"🏌","racing_motorcycle":"🏍","racing_car":"🏎","cricket_bat_and_ball":"🏏","volleyball":"🏐","field_hockey_stick_and_ball":"🏑","ice_hockey_stick_and_puck":"🏒","table_tennis_paddle_and_ball":"🏓","snow_capped_mountain":"🏔","camping":"🏕","beach_with_umbrella":"🏖","building_construction":"🏗","house_buildings":"🏘","cityscape":"🏙","derelict_house_building":"🏚","classical_building":"🏛","desert":"🏜","desert_island":"🏝","national_park":"🏞","stadium":"🏟","house":"🏠","house_with_garden":"🏡","office":"🏢","post_office":"🏣","european_post_office":"🏤","hospital":"🏥","bank":"🏦","atm":"🏧","hotel":"🏨","love_hotel":"🏩","convenience_store":"🏪","school":"🏫","department_store":"🏬","factory":"🏭","izakaya_lantern":"🏮","lantern":"🏮","japanese_castle":"🏯","european_castle":"🏰","waving_white_flag":"🏳","waving_black_flag":"🏴","rosette":"🏵","label":"🏷","badminton_racquet_and_shuttlecock":"🏸","bow_and_arrow":"🏹","amphora":"🏺","skin-tone-2":"🏻","skin-tone-3":"🏼","skin-tone-4":"🏽","skin-tone-5":"🏾","skin-tone-6":"🏿","rat":"🐀","mouse2":"🐁","ox":"🐂","water_buffalo":"🐃","cow2":"🐄","tiger2":"🐅","leopard":"🐆","rabbit2":"🐇","cat2":"🐈","dragon":"🐉","crocodile":"🐊","whale2":"🐋","snail":"🐌","snake":"🐍","racehorse":"🐎","ram":"🐏","goat":"🐐","sheep":"🐑","monkey":"🐒","rooster":"🐓","chicken":"🐔","dog2":"🐕","pig2":"🐖","boar":"🐗","elephant":"🐘","octopus":"🐙","shell":"🐚","bug":"🐛","ant":"🐜","bee":"🐝","honeybee":"🐝","beetle":"🐞","fish":"🐟","tropical_fish":"🐠","blowfish":"🐡","turtle":"🐢","hatching_chick":"🐣","baby_chick":"🐤","hatched_chick":"🐥","bird":"🐦","penguin":"🐧","koala":"🐨","poodle":"🐩","dromedary_camel":"🐪","camel":"🐫","dolphin":"🐬","flipper":"🐬","mouse":"🐭","cow":"🐮","tiger":"🐯","rabbit":"🐰","cat":"🐱","dragon_face":"🐲","whale":"🐳","horse":"🐴","monkey_face":"🐵","dog":"🐶","pig":"🐷","frog":"🐸","hamster":"🐹","wolf":"🐺","bear":"🐻","panda_face":"🐼","pig_nose":"🐽","feet":"🐾","paw_prints":"🐾","chipmunk":"🐿","eyes":"👀","eye":"👁","ear":"👂","nose":"👃","lips":"👄","tongue":"👅","point_up_2":"👆","point_down":"👇","point_left":"👈","point_right":"👉","facepunch":"👊","punch":"👊","wave":"👋","ok_hand":"👌","+1":"👍","thumbsup":"👍","-1":"👎","thumbsdown":"👎","clap":"👏","open_hands":"👐","crown":"👑","womans_hat":"👒","eyeglasses":"👓","necktie":"👔","shirt":"👕","tshirt":"👕","jeans":"👖","dress":"👗","kimono":"👘","bikini":"👙","womans_clothes":"👚","purse":"👛","handbag":"👜","
-- pouch":"👝","mans_shoe":"👞","shoe":"👞","athletic_shoe":"👟","high_heel":"👠


if JJRedConfig.Plugins.VORP then
    RegisterNetEvent('jjred:gotVorp')
    AddEventHandler('jjred:gotVorp', function(vorp) VORPCore = vorp end)
    TriggerServerEvent("jjred:getVorp")
    if VORPCore ~= nil then print("JJ loaded Vorp Core successfully!") end

    AddEventHandler("playerSpawned", function(spawn)
        if JJRedConfig.Plugins.VORP then
            local _source = source
            while VORPCore.getCharacter == nil do Citizen.Wait(100) end
            vuser = VORPCore.getCharacter(_source)
            vgroup = user.group
            vident = user.identifier
            local model = args[1]
            print(ident)
        end
    end)

    AddEventHandler('vorp_skinPed:setSkinPed', function(clientId, model)
        local _source = source
        while VORPCore.getCharacter == nil do Citizen.Wait(100) end
        local user = VORPCore.getCharacter(_source)
        local group = user.group
        local ident = user.identifier
        local model = args[1]
        print(ident)

    end)
end


--[[
Citizen.CreateThread(function()
    local pressed = false
    while true do
        Citizen.Wait(1)
        cooldown = cooldown - 1
        if cooldown <= 0 then

            if JJRedConfig.Keys.RequireAiming then
                if IsControlPressed(0, 25) and
                    IsControlJustReleased(0, JJRedConfig.Keys.SlowMo) then
                    pressed = true

                end
            else
                pressed = true

            end
            if pressed and IsControlJustReleased(0, JJRedConfig.Keys.SlowMo) and
                JJRedConfig.slowmopower then
                cooldown = JJRedConfig.powercooldown * 500
                CreateThread(function()
                    local i = 0
                    SlowMo(PlayerId())
                    TriggerEvent("jjred:showmehud")
                    while i < JJRedConfig.slowmopowertime * 100 do
                        Wait(0)
                        i = i + 1
                        TriggerServerEvent("jjred:addme", false,
                                           PlayerId(), "poof",
                                           "invisible for " ..
                                               (JJRedConfig.slowmopowertime * 100 - i))

                    end
                    TriggerEvent("jjred:hidemehud")

                    SlowMo(PlayerId())
                end)
            end
        else

        end
    end
end)
]]
function cPowers:ForceSlowMo(p, pspeed, pinvis, stime, sspeed)
    print("sloooowwwer..")
    if not slowmo and not forcedslowmo then
        forcedslowmo, slowmo = true, true
        if pspeed then
            --    SetRunSprintMultiplierForPlayer(p, 3.0)
            SetPedMoveRateOverride(GetPlayerPed(p), 1.15)
            SetPedDesiredMoveBlendRatio(GetPlayerPed(p), 3.0)
        end
        SetTimeScale(sspeed)
        if pinvis then SetEntityVisible(GetPlayerPed(p), false, false) end
    else
        if pspeed then
            --     SetRunSprintMultiplierForPlayer(p, 0.89)

            SetPedMoveRateOverride(GetPlayerPed(p), 0.3)
            SetPedDesiredMoveBlendRatio(GetPlayerPed(p), 0.8)
        end
        SetTimeScale(1.0)
        if pinvis then SetEntityVisible(GetPlayerPed(p), true, true) end
        forcedslowmo, slowmo = false, false
    end
end

--[[
Citizen.CreateThread(function()
    local pressed = false
    while true do
        Citizen.Wait(1)
        cooldown = cooldown - 1
        if cooldown <= 0 then

            if JJRedConfig.Keys.RequireAiming then
                if IsControlPressed(0, 25) and
                    IsControlJustReleased(0, jKeys[JJRedConfig.Keys.HeatVision]) then
                    pressed = true

                end
            else
                pressed = true

            end
            if pressed and IsControlJustReleased(0, jKeys[JJRedConfig.Keys.HeatVision]) and
                JJRedConfig.heatvisionpower then
                HeatVision()
                cooldown = JJRedConfig.powercooldown * 500
            end
        else

        end
    end
end)
]]
function HeatVision()

    CreateThread(function()
        local i = 0
        SetSeethrough(true)
        TriggerEvent("jjred:showmehud")
        while i < JJRedConfig.heatvisiontime * 100 do
            Wait(0)
            i = i + 1
            TriggerServerEvent("jjred:addme", true, PlayerId(), "poof",
                               "heat vision for " ..
                                   (JJRedConfig.heatvisiontime * 100 - i))

        end
        TriggerEvent("jjred:hidemehud")

        --     SetSeethrough(false)
    end)

end
--[[
Citizen.CreateThread(function()
    local pressed = false
    while true do
        Citizen.Wait(1)
        cooldown = cooldown - 1
        if cooldown <= 0 then

            if JJRedConfig.Keys.RequireAiming then
                if IsControlPressed(0, 25) and
                    IsControlJustReleased(0, jKeys[JJRedConfig.Keys.NightVision]) then
                    pressed = true
                end
            else
                pressed = true

            end
            if pressed and IsControlJustReleased(0, jKeys[JJRedConfig.Keys.NightVision]) and
                JJRedConfig.nightvisionpower then
                Nightvision()
                cooldown = JJRedConfig.powercooldown * 500
            end
        else

        end
    end
end)
]]
function Nightvision()

    CreateThread(function()
        local i = 0
        SetNightvision(true)
        TriggerEvent("jjred:showmehud")
        while i < JJRedConfig.nightvisiontime * 100 do
            Wait(0)
            i = i + 1

            TriggerServerEvent("jjred:addme", true, PlayerId(), "poof",
                               "night vision for " ..
                                   (JJRedConfig.nightvisiontime * 100 - i))

        end
        TriggerEvent("jjred:hidemehud")

        SetNightvision(false)

    end)

end

function setSuperjump(p)

    if p ~= nil then if jjstats.superjump then SetSuperJumpThisFrame(p) end end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        --  if JJRedConfig.Blips == true then
        --    for k,v in pairs(JJRedConfig.Shacks) do
        --        RemoveBlip(blip[k])
        --   end
        -- end
    end
end)

RegisterNUICallback("sjumpon", function(data, cb)
    jjstats.superjump = true
    cb('ok')
end)

RegisterNUICallback("sjumpoff", function(data, cb)
    jjstats.superjump = false
    cb('ok')
end)
RegisterNUICallback("pstaminaon", function(data, cb)
    jjstats.stamina = true
    cb('ok')
end)
RegisterNUICallback("pstaminaoff", function(data, cb)
    jjstats.stamina = false
    cb('ok')
end)

jjstats = {
    stamina = false,
    superjump = false,
    statshud = false,
    popups = true,
    devtools = false
}

RegisterNUICallback("closedata", function(data, cb)
    SetNuiFocus(false, false)

    open = 0
    for k, v in pairs(data) do jjstats[k] = v end
    for k, v in pairs(jjstats) do
        print(k)
        print(v)
    end
    SendNUIMessage({action = "hidenotify"})
    if not statshud then SendNUIMessage({action = "hidehud"}) end
    cb('ok')

end)
local zombiedecor = "zombiedecor"
local special = "special"

function drawtxt(txt, txt2, isz, isspecial)

    local iszs = tostring(isz)
    local isspecials = tostring(isspecial)
    SetTextScale(0.35, 0.35)
    SetTextColor(255, 0, 0, 255) -- r,g,b,a
    SetTextCentre(true) -- true,false
    SetTextDropshadow(1, 0, 0, 0, 200) -- distance,r,g,b,a
    SetTextFontForCurrentCommand(0)
    DisplayText(CreateVarString(10, "LITERAL_STRING",
                                'Entity Type: ' .. tostring(txt) .. " Group: " ..
                                    txt2 .. " " .. isspecials .. " " .. iszs),
                0.5, 0.5) -- text,x,y

end

Citizen.CreateThread(function()
    --   jjstats.devtools = true
    --  SetEveryoneIgnorePlayer(PlayerId(), true)
    while jjstats.devtools do
        DecorRegister("zombiedecor", 2)
        DecorRegister("special", 2)
        local zombiedecor --[[ const char ]] =
            DecorRegister(0 --[[ integer ]] --[[ boolean ]] )

        Citizen.Wait(3000)
        local isdecorregged --[[ boolean ]] , zombiedecor --[[ const char ]] =
            DecorIsRegisteredAsType(0 --[[ integer ]] )
        print(isdecorregged)
        local zombiedecor --[[ const char ]] =
            DecorRegister(0 --[[ integer ]] --[[ boolean ]] )

        Citizen.Wait(3000)
        local isdecorregged --[[ boolean ]] , zombiedecor --[[ const char ]] =
            DecorIsRegisteredAsType(0 --[[ integer ]] )
        print(isdecorregged)
    end

end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(17)
        if not jjstats.devtools then
            SetEveryoneIgnorePlayer(PlayerId(), false)
        else
            SetEveryoneIgnorePlayer(PlayerId(), true)
            local retval, target = GetEntityPlayerIsFreeAimingAt(PlayerId())
            -- retval, target =  GetPlayerTargetEntity(PlayerId())
            --  print(target)
            local str3 = tostring(GetPedRelationshipGroupDefaultHash(target))
            local coords = GetEntityCoords(target, true, true)
            local etype = GetEntityType(target)
            local isspecial, special = DecorExistOn(target)
            local isz, zombie2 = DecorExistOn(target)
            local str2 = etype
            if str2 ~= nil then
                if str2 > 0 then
                    drawtxt(str2, str3, isz, isspecial)
                end
            end
        end
    end
end)

cPowers = cPowers()