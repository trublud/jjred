_properties = {}
_modules = {}
_ownership = {}

loadProperties = function(cb)
    print("^4[JJzppmain]-[Properties] ^2 loading ^0")
    local data = LoadResourceFile(GetCurrentResourceName(), "server/data/properties.json")

    if not data then
        SaveResourceFile(GetCurrentResourceName(), "server/data/properties.json", "[]")
        data = "[]"
    end

    _properties = json.decode(LoadResourceFile(GetCurrentResourceName(), "server/data/properties.json"))
    print("^4[JJzppmain]-[Properties]^2 " .. #_properties .. " properties ^0")
    loadOwnershipData(cb)
end

loadOwnershipData = function(cb)
    print("^4[JJzppmain]-[Properties]^2 Loading ownership data... ^0")
    local data = LoadResourceFile(GetCurrentResourceName(), "server/data/ownership.json")

    if not data then
        SaveResourceFile(GetCurrentResourceName(), "server/data/ownership.json", "[]")
        data = "[]"
    end

    _ownership = json.decode(LoadResourceFile(GetCurrentResourceName(), "server/data/ownership.json"))

    for k,v in ipairs(_ownership) do
        for j, i in ipairs(_properties) do
            if(v.name == i.name)then
                i.owner = v.owner
                i.ownerID = v.ownerID
            end
        end
    end
    
 --   print("^1[RedEM:RP Properties]^0 Loaded " .. #_ownership .. " ownership data")

    for k,v in ipairs(_modules)do
        if v.handlers.initialize then
            v.handlers.initialize()
        end
    end
end

initialize = function(cb)
  --  print("^1[RedEM:RP Properties]^0 Initializing...")
    loadProperties(cb)
end

initialize()

function registerModule(name)
    local id = #_modules + 1
    _modules[id] = {
        name = name,
        handlers = {}
    }

    _modules[id].setHandler = function(name, cb)
        _modules[id].handlers[name] = cb
    end
    print("^4[JJzppmain]-[Properties]^2 Module registered: " .. name.." ^0")

    return _modules[id]
end

function setPropertyData(key, value)
    _properties[key] = value
end