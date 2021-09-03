sMain = class()

-- KeyValueStore:Set("MostRecentChatMessage", args.text)

-- this is how we can retrieve the most recent chat message
-- KeyValueStore:Get("MostRecentChatMessage", function(value)
-- print("The most recent chat message is:", value)
RegisterNetEvent('JJz:newPlayer')
RegisterNetEvent('JJz:playerKilledUndead')
RegisterNetEvent('JJz:playerKilledByUndead')
RegisterNetEvent('JJz:playerKilledBySelf')
RegisterNetEvent('JJz:playerKilledByPvp')
RegisterNetEvent('JJz:playerKilled')
RegisterNetEvent('JJz:playerKilledInnocent')
RegisterNetEvent('JJz:townfolkKilledByUndead')
RegisterNetEvent('JJz:townfolkKilled')
function sMain:__init()
    self.CurrentZone =
        (Config.DefaultZone and Config.Zones[Config.DefaultZone] or nil)

    Network:Subscribe("JJz:newPlayer", function(args)
        Network:Send('JJz:setZone', args[1], self.CurrentZone)
    end)
    Network:Subscribe("JJz:playerKilledUndead",
                      function(args) sMain:playerKilledUndead(args[1]) end)
    Network:Subscribe("JJz:playerKilledByUndead",
                      function(args) sMain:playerKilledByUndead(args[1]) end)
    Network:Subscribe("JJz:playerKilledBySelf",
                      function(args) sMain:playerKilledBySelf(args[1]) end)
    Network:Subscribe("JJz:playerKilledByPvp",
                      function(args) sMain:playerKilledByPvp(args[1]) end)
    Network:Subscribe("JJz:playerKilled",
                      function(args) sMain:playerKilled(args[1]) end)
    Network:Subscribe("JJz:playerKilledInnocent",
                      function(args) sMain:playerKilledInnocent(args[1]) end)
    Network:Subscribe("JJz:townfolkKilledByUndead",
                      function(args) sMain:townfolkKilledByUndead(args[1]) end)
    Network:Subscribe("JJz:townfolkKilled",
                      function(args) sMain:townfolkKilled(args[1]) end)

    Network:Send('JJz:setZone', -1, CurrentZone)

    Network:Subscribe("PedSpawned", function(args)
        MySQL.ready(function()
            sMain:InitPlayer(args[1], args[2], args[3])
        end)
        Network:Send('JJz:setZone', args[1], self.CurrentZone)

        if Config.ZoneTimeout then
            CreateThread(function()
                local elapsed = Config.ZoneTimeout

                while true do
                    Wait(1000)

                    if elapsed >= Config.ZoneTimeout then
                        SetZone('random')
                        elapsed = 0
                    else
                        elapsed = elapsed + 1
                    end
                end
            end)
            if Config.EnableSql then
                CreateThread(function()
                    while true do
                        if Player:GetId() ~= nill then

                            UpdateScoreboards()
                            --	UpdatePlayerStats()
                        end
                        Wait(1000)
                    end

                end)
            end
        end

    end)
    

    function sMain:InitPlayer(player, name, license)

        MySQL.Async.fetchScalar('SELECT id FROM undead WHERE id = @id',
                                {['id'] = license}, function(id)
            if id then
                sMain:Log(name ," Has Returned ")
                --[[     MySQL.Async.execute('UPDATE undead SET name = @name WHERE id = @id',
                                {['name'] = name, ['id'] = license},
                                function(affectedRows)
                if affectedRows < 1 then
                    Log('error', 'failed to update ' .. license)
                end
            end)]]
            else
                sMain:Log(name ,"  Has Joined")
                MySQL.Async.execute(
                    'INSERT INTO undead (id, name, killed) VALUES (@id, @name, 0)',
                    {['id'] = license, ['name'] = name}, function(affectedRows)
                        if affectedRows > 0 then
                            sMain:Log('success',
                                name .. ' ' .. license .. ' was created')
                        else
                            sMain:Log('error',
                                'failed to initialize ' .. name .. ' ' ..
                                    license)
                        end
                    end)
            end
       --     self.SetZone(self.RandomZone())
        end)
    end

    SQL:Execute([[CREATE TABLE IF NOT EXISTS `undead` (
  `id` char(40) NOT NULL,
  `name` varchar(255) NOT NULL,
  `killed` int(10) unsigned DEFAULT 0,
  `murders` int(10) unsigned DEFAULT 0,
  `deaths` int(10) unsigned DEFAULT 0,
  `lossed` int(10) unsigned DEFAULT 0,
  `pvpkills` int(10) unsigned DEFAULT 0,
  `pvpdeaths` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`)
)]])

    SQL:Execute([[CREATE TABLE IF NOT EXISTS `stables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `charid` int(11) DEFAULT 0,
  `name` varchar(255) COLLATE utf8mb4_bin DEFAULT 'Horse',
  `vehicles` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `type` varchar(11) COLLATE utf8mb4_bin DEFAULT NULL,
  `bondxp` int(11) DEFAULT 0,
  `stabled` tinyint(1) DEFAULT 1,
  `healthy` tinyint(1) DEFAULT 1,
  `default` tinyint(1) DEFAULT 0,
  `saddle` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  `blanket` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  `mane` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  `tail` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  `bag` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  `bedroll` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  `stirups` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
)]])

    SQL:Execute([[CREATE TABLE IF NOT EXISTS `skins` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `skin` varchar(5000) NOT NULL
)]])

    SQL:Execute([[CREATE TABLE IF NOT EXISTS `outfits` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `clothes` varchar(6255) NOT NULL,
  `name` varchar(255) DEFAULT NULL
)]])

    SQL:Execute([[CREATE TABLE IF NOT EXISTS `horses` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `horse` varchar(255) NOT NULL
)]])

    SQL:Execute([[CREATE TABLE IF NOT EXISTS `dogs` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `dog` varchar(255) NOT NULL
)]])
    SQL:Execute([[CREATE TABLE IF NOT EXISTS `coords` (
  `characterid` tinyint(11) NOT NULL,
  `identifier` varchar(22) NOT NULL,
  `coords` longtext NOT NULL,
  PRIMARY KEY (`characterid`)
)]])

    SQL:Execute([[CREATE TABLE IF NOT EXISTS `complementos_caballo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steamid` varchar(45) NOT NULL,
  `charid` tinyint(2) NOT NULL,
  `nombre_complemento` varchar(50) NOT NULL,
  `tipo` int(1) NOT NULL,
  `hash` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
)]])
    SQL:Execute([[CREATE TABLE IF NOT EXISTS `coaches` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `coach` varchar(255) NOT NULL
)]])
    SQL:Execute([[CREATE TABLE IF NOT EXISTS `clothes` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `clothes` varchar(6000) NOT NULL
)]])

    SQL:Execute([[CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `characterid` int(11) DEFAULT 0,
  `money` int(11) DEFAULT 0,
  `gold` int(11) DEFAULT 0,
  `xp` int(11) DEFAULT 0,
  `level` int(11) DEFAULT 0,
  `job` varchar(50) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT 'first',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT 'last',
  `jobgrade` int(11) DEFAULT 0,
  `coords` varchar(2000) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
)]])

    SQL:Execute([[CREATE TABLE IF NOT EXISTS `boates` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `boat` varchar(255) NOT NULL
)]])
    -- SQL:Execute([[INSERT INTO `undead` VALUES ('de6e9ef166705f174b32dd2f818170534edcbd85','xmindpingx',325,84,59,282,0,9)]])

    -- SQL:Execute([[CREATE TABLE IF NOT EXISTS `key_value_store` (`key` VARCHAR(200) NOT NULL PRIMARY KEY, `value_type` VARCHAR(50), `value` TEXT)]])
    -- SQL:Execute([[CREATE TABLE IF NOT EXISTS `undead` (`id` VARCHAR(40) NOT NULL PRIMARY KEY, `name` VARCHAR(255) NOT NULL, `killed` INT(40) NOT NULL, `deaths` INT(40) NOT NULL, `lossed` INT(40) NOT NULL, `pvpkills` INT(40) NOT NULL, `murders` INT NOT NULL, `pvpdeaths` INT(40) NOT NULL)]])
    -- SQL.Execute("CREATE TABLE IF NOT EXISTS `undead` (`id` VARCHAR(40) NOT NULL PRIMARY KEY, `name` VARCHAR(255) NOT NULL, `killed` INT(40) NOT NULL, `deaths` INT(40) NOT NULL, `lossed` INT(40) NOT NULL, `pvpkills` INT(40) NOT NULL, `murders` INT NOT NULL, `pvpdeaths` INT(40) NOT NULL)", {}, function(data) end)

    function sMain:playerKilledByUndead(license)
        if not Config.EnableSql then return end


        MySQL.ready(function()
            MySQL.Async.execute(
                'UPDATE undead SET deaths = deaths + 1 WHERE id = @id',
                {['id'] = license}, function(affectedRows)
                    if affectedRows < 1 then
                        sMain:Log('error',
                            'failed to update deaths count for ' .. license)
                    end
                end)
        end)
    end

    function sMain:townfolkKilledByUndead(license)
        if not Config.EnableSql then return end


        MySQL.ready(function()
            MySQL.Async.execute(
                'UPDATE undead SET lossed = lossed + 1 WHERE id = @id',
                {['id'] = license}, function(affectedRows)
                    if affectedRows < 1 then
                        sMain:Log('error',
                            'failed to update deaths count for ' .. license)
                    end
                end)
        end)
    end

    function sMain:townfolkKilled(license)
        if not Config.EnableSql then return end


        MySQL.ready(function()
            MySQL.Async.execute(
                'UPDATE undead SET lossed = lossed + 1 WHERE id = @id',
                {['id'] = license}, function(affectedRows)
                    if affectedRows < 1 then
                        sMain:Log('error',
                            'failed to update deaths count for ' .. license)
                    end
                end)
        end)
    end
    function sMain:playerKilledBySelf(license)
        if not Config.EnableSql then return end


        MySQL.ready(function()
            MySQL.Async.execute(
                'UPDATE undead SET deaths = deaths + 1 WHERE id = @id',
                {['id'] = license}, function(affectedRows)
                    if affectedRows < 1 then
                        sMain:Log('error',
                            'failed to update deaths count for ' .. license)
                    end
                end)
        end)
    end
    function sMain:playerKilledByPvp(license)
        if not Config.EnableSql then return end


        MySQL.ready(function()
            MySQL.Async.execute(
                'UPDATE undead SET pvpdeaths = pvpdeaths + 1 WHERE id = @id',
                {['id'] = license}, function(affectedRows)
                    if affectedRows < 1 then
                        sMain:Log('error',
                            'failed to update kill count for ' .. license)
                    end
                end)
        end)
    end
    function sMain:playerKilled(license)
        if not Config.EnableSql then return end

       

        MySQL.ready(function()
            MySQL.Async.execute(
                'UPDATE undead SET deaths = deaths + 1 WHERE id = @id',
                {['id'] = license}, function(affectedRows)
                    if affectedRows < 1 then
                        sMain:Log('error',
                            'failed to update deaths count for ' .. license)
                    end
                end)
        end)
    end
    function sMain:playerKilledUndead(license)
        if not Config.EnableSql then return end

       

        MySQL.ready(function()
            MySQL.Async.execute(
                'UPDATE undead SET killed = killed + 1 WHERE id = @id',
                {['id'] = license}, function(affectedRows)
                    if affectedRows < 1 then
                        sMain:Log('error',
                            'failed to update kill count for ' .. license)
                    end
                end)
        end)
    end
    function sMain:playerKilledInnocent(license)
        if not Config.EnableSql then return end

      

        MySQL.ready(function()
            MySQL.Async.execute(
                'UPDATE undead SET murders = murders + 1 WHERE id = @id',
                {['id'] = license}, function(affectedRows)
                    if affectedRows < 1 then
                        sMain:Log('error',
                            'failed to update murders count for ' .. license)
                    end
                end)
        end)
    end
    function sMain:updatehudData(slot, data)
        TriggerClientEvent('jjred:updatehudData', source, slot, data)
    end


    
function sMain:UpdatePlayerStats(license)

    MySQL.ready(function()
        MySQL.Async.fetchAll('SELECT name, killed FROM undead WHERE id = @id',
                             {['id'] = license}, function(results)
            TriggerClientEvent('JJz:updatePlayerStats', -1, results)

        end)

    end)
end
function sMain:UpdateScoreboards(license)
    MySQL.ready(function()
        MySQL.Async.fetchAll(
            "SELECT name, killed, murders, lossed FROM undead WHERE name <> '' AND killed <> 0 ORDER BY killed DESC LIMIT 10",
            {}, function(results)
                TriggerClientEvent('JJz:updateScoreboard', -1, results)

            end)

        MySQL.Async.fetchScalar("SELECT SUM(killed) FROM undead", {},
                                function(total)
            TriggerClientEvent("JJz:updateTotalUndeadKilled", -1, total)
        end)

    end)

    --  print("license")
    --   print(license)
    MySQL.ready(function()
        MySQL.Async.fetchAll(
            'SELECT name, killed, murders, lossed FROM undead WHERE id = @id',
            {['id'] = license}, function(results)
                if source ~= nil then print(source) end
                local id
                for k, v in ipairs(GetPlayerIdentifiers(-1)) do
                    if string.sub(v, 1, string.len("steam:")) then
                        print(v)
                        id = v
                        break
                    end
                end
                print("license")
                print(license)

                TriggerClientEvent('JJz:updatePlayerStats', -1, results)
                sMain:updatehudData(5, results[1].killed)
                sMain:updatehudData(6, results[1].murders)
                sMain:updatehudData(7, results[1].lossed)
            end)
    end)
end
self.LogColors = {
    ['name'] = '\x1B[31m',
    ['default'] = '\x1B[0m',
    ['error'] = '\x1B[31m',
    ['success'] = '\x1B[32m'
}

function sMain:Log(label, message)
    local color = sMain.LogColors[label]

    if not color then color = sMain.LogColors.default end

    print(string.format('%s[JJz] %s[%s]%s %s', sMain.LogColors.name, color, label,
    sMain.LogColors.default, message))
end
sMain:Log("success" , " Covid-21 loaded ", "hi")
end





--[[
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    if not Config.EnableSql then return end

    local player = source
    MySQL.ready(function() InitPlayer(player, name) end)
end)]]

AddEventHandler('onResourceStart', function()
    if resource == GetCurrentResourceName() then
        if not Config.EnableSql then
            Log("error" ,"[SQL] not enabled - not saving stats ^0")
            return
        end
        sMain:Log("Covid-21" ," loaded")
        --[[   MySQL.ready(function()
            for _, playerId in ipairs(GetPlayers()) do
                InitPlayer(playerId, GetPlayerName(playerId))
            end
        end)]]
    end


function sMain:RandomZone()
    return Config.Zones[Config.ZoneRotation[math.random(#Config.ZoneRotation)]]
end

function sMain:SetZone(zone)
    if zone == 'random' then
        CurrentZone = sMain:RandomZone()
    elseif zone then
        CurrentZone = Config.Zones[zone]
    else
        CurrentZone = nil
    end
    print("zoned")
    Network:Send('JJz:setZone', -1, CurrentZone)
    TriggerClientEvent('JJz:setZone', -1, CurrentZone)
end

function sMain:CreateZone(name, x, y, z, radius)
    Config.Zones[name] = {name = name, x = x, y = y, z = z, radius = radius}
    sMain:SetZone(name)
end
end)
RegisterCommand('JJzone', function(source, args, raw)
    if #args >= 5 then
        local name = args[1]
        local x = tonumber(args[2]) * 1.0
        local y = tonumber(args[3]) * 1.0
        local z = tonumber(args[4]) * 1.0
        local r = tonumber(args[5]) * 1.0
        sMain:CreateZone(name, x, y, z, r)
    else
        sMain:SetZone(args[1])
    end
end, true)

sMain = sMain()
