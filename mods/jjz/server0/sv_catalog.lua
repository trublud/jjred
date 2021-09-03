local weapons = {
	[1] = { ['weapon'] = 'P_12MOONSHINECRATE01', ["PRICE"] = 13, ['label'] = 'P_12MOONSHINECRATE01', ['AMMOlabel'] = 'revolver ammo', ["AMMOPRICE"] = 10},
	[2] = { ['item'] = 'P_2NDFLRFRAME10X', ["PRICE"] = 15, ['label'] = 'P_2NDFLRFRAME10X', ['AMMOlabel'] = 'revolver ammo', ["AMMOPRICE"] = 10},

}

local Framework = {}
TriggerEvent("redemrp_inventory:getData",function(call)
	Framework = call
end)


local code = math.random(111111,9999999)

RegisterNetEvent("JJzpp::getCode")
AddEventHandler("JJzpp::getCode", function()
	local _source = source
	TriggerClientEvent('JJzpp::SendCode', _source, code)
end)

function weapon2(weapon)
	for i = 1,#weapons do
		if weapons[i]['weapon'] == weapon then
			return weapons[i]
		end
	end
	return false
end

RegisterNetEvent("JJzpp::Purchase")
AddEventHandler("JJzpp::Purchase", function(data,code1)
	local _source = source
	if code == code1 then
		TriggerEvent('redem:getPlayerFromId', _source, function(user) 
			local cash = user.getMoney()
			if tonumber(data.isammo) ~= 1 then
				local weapon2 = weapon2(data.weapon)
				if weapon2 then
					if cash >= weapon2['PRICE'] then
						local ItemData = Framework.getItem(_source, GetHashKey(data.weapon))
						ItemData.AddItem(1)
						TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'success', text = 'Received '..weapon2['label']})
						user.removeMoney(weapon2['PRICE'])
					else
						TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'error', text = 'You do not have enough money to buy this weapon'})
					end
				else
					TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'error', text = 'Your trying to buy a weapon that doesnt exist'})
				end
			else
				local weapon2 = weapon2(data.weapon)
				if weapon2 then
					if cash >= weapon2['AMMOPRICE'] then
						local ItemData = Framework.getItem(_source, data.weapon)
						ItemData.AddItem(1)
						TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'success', text = 'Received '..weapon2['label']})
						user.removeMoney(weapon2['AMMOPRICE'])
					else
						TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'error', text = 'You do not have enough money to buy ammo'})
					end
				else
					TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'error', text = 'Your trying to buy ammo that doesnt exist'})
				end
			end
		end)
	end
end)


--Taken from redemrp_weaponshop made by CryptoGenics for compatability when switching over

-------- Revolver
RegisterServerEvent("RegisterUsableItem:revolver_ammo")
AddEventHandler("RegisterUsableItem:revolver_ammo", function(source)
	local _source = source
	
	TriggerClientEvent('JJzpp::giveammo', _source, "WEAPON_REVOLVER_CATTLEMAN",code)
	local ItemData = Framework.getItem(_source, 'revolver_ammo', 1)
	ItemData.RemoveItem(1)
end)
-------- Pistol
RegisterServerEvent("RegisterUsableItem:pistol_ammo")
AddEventHandler("RegisterUsableItem:pistol_ammo", function(source)
	local _source = source
	TriggerClientEvent('JJzpp::giveammo', _source, "WEAPON_PISTOL_MAUSER",code)
	local ItemData = Framework.getItem(_source, 'pistol_ammo', 1)
	ItemData.RemoveItem(1)
end)
-------- 22 Ammo
RegisterServerEvent("RegisterUsableItem:22_ammo")
AddEventHandler("RegisterUsableItem:22_ammo", function(source)
	local _source = source
	TriggerClientEvent('JJzpp::giveammo', _source, "WEAPON_RIFLE_VARMINT",code)
	local ItemData = Framework.getItem(_source, '22_ammo', 1)
	ItemData.RemoveItem(1)
end)
-------- Rifle
RegisterServerEvent("RegisterUsableItem:rifle_ammo")
AddEventHandler("RegisterUsableItem:rifle_ammo", function(source)
	local _source = source
	TriggerClientEvent('JJzpp::giveammo', _source, "WEAPON_RIFLE_BOLTACTION",code)
	local ItemData = Framework.getItem(_source, '22_ammo', 1)
	ItemData.RemoveItem(1)
end)
-------- Shotgun Shells
RegisterServerEvent("RegisterUsableItem:shotgun_ammo")
AddEventHandler("RegisterUsableItem:shotgun_ammo", function(source)
	local _source = source
	TriggerClientEvent('JJzpp::giveammo', _source, "WEAPON_SHOTGUN_DOUBLEBARREL",code)
	local ItemData = Framework.getItem(_source, 'shotgun_ammo', 1)
	ItemData.RemoveItem(1)
end)

-------- Repeater
RegisterServerEvent("RegisterUsableItem:repeator_ammo")
AddEventHandler("RegisterUsableItem:repeator_ammo", function(source)
	local _source = source
	TriggerClientEvent('JJzpp::giveammo', _source, "WEAPON_REPEATER_EVANS",code)
	local ItemData = Framework.getItem(_source, 'repeator_ammo', 1)
	ItemData.RemoveItem(1)
end)
-------- Sniper
RegisterServerEvent("RegisterUsableItem:snipe_ammo")
AddEventHandler("RegisterUsableItem:snipe_ammo", function(source)
	local _source = source
	TriggerClientEvent('JJzpp::giveammo', _source, "WEAPON_SNIPERRIFLE_CARCANO",code)
	local ItemData = Framework.getItem(_source, 'snipe_ammo', 1)
	ItemData.RemoveItem(1)
end)
-------- Arrows
RegisterServerEvent("RegisterUsableItem:arrows")
AddEventHandler("RegisterUsableItem:arrows", function(source)
	local _source = source
	TriggerClientEvent('JJzpp::giveammo', _source, "WEAPON_BOW",code)
	local ItemData = Framework.getItem(_source, 'arrows', 1)
	ItemData.RemoveItem(1)
end)
print("^4[JJzppmain]-[PropCatalog] ^2 loaded ^0")
-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tprint (tbl, indent)
	if not indent then indent = 0 end
	for k, v in pairs(tbl) do
		formatting = string.rep("  ", indent) .. k .. ": "
		if type(v) == "table" then
			print(formatting)
			tprint(v, indent+1)
		elseif type(v) == 'boolean' then
			print(formatting .. tostring(v))
		else
			print(formatting .. v)
		end
	end
end
