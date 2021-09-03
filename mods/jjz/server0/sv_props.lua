local Props = {}
RegisterServerEvent("JJzppmain:SaveProp")
AddEventHandler("JJzppmain:SaveProp", function(prophash, x ,y, z ,heading)
    local _source = source
    Props[heading.."-"..x] = {prophash = prophash , x = x, y = y , z = z , heading = heading}
    SaveResourceFile(GetCurrentResourceName(), "server/data/Props.json", json.encode(Props), -1)
    TriggerClientEvent('JJzppmain:GetProps', _source, Props)
end)

function loadProps()
    print(GetCurrentResourceName())
    prop = LoadResourceFile(GetCurrentResourceName(), "server/data/Props.json") or ""
    if prop ~= "" then
        Props = json.decode(prop)
     
        print("^4[JJzppmain] ^2 all Props loaded ^0")
    else
        Props = {}
    end
      print("^4[JJzppmain] ^2[PropPlacer] loaded ^0")
end




RegisterServerEvent("JJzppmain:PropRequest")
AddEventHandler("JJzppmain:PropRequest", function()
    local _source = source
    TriggerClientEvent('JJzppmain:GetProps', _source, Props)
end)
RegisterServerEvent("JJzppmain:DeleteProp")
AddEventHandler("JJzppmain:DeleteProp", function(id)
    local _source = source
    Props[id] = nil
    SaveResourceFile(GetCurrentResourceName(), "server/data/Props.json", json.encode(Props), -1)
    TriggerClientEvent('JJzppmain:GetProps', _source, Props)
end)

loadProps()
