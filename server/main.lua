local calendarEvents = {}
local globalEvents = {}

QBCore = exports['qb-core']:GetCoreObject()

-- Load events from the database when the script starts
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    LoadEventsFromDatabase()
end)

-- Function to load events from the database
function LoadEventsFromDatabase()
    local result = MySQL.query.await('SELECT * FROM calendar_events')

    if result then
        for _, event in ipairs(result) do
            if event.is_global == 1 then
                globalEvents[event.date] = event.title
            else
                if not calendarEvents[event.citizenid] then
                    calendarEvents[event.citizenid] = {}
                end
                calendarEvents[event.citizenid][event.date] = event.title
            end
        end
    end
end

-- Save event to the database
RegisterServerEvent('qb-calendar:saveEvent')
AddEventHandler('qb-calendar:saveEvent', function(date, title, isGlobal)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid

    if isGlobal and IsPlayerAceAllowed(src, "admin") then
        globalEvents[date] = title
        MySQL.insert('INSERT INTO calendar_events (citizenid, date, title, is_global) VALUES (?, ?, ?, ?)', {
            'global',
            date,
            title,
            1
        })
        TriggerClientEvent('QBCore:Notify', src, 'Global Event Saved Successfully', 'success')
    else
        if not calendarEvents[citizenid] then
            calendarEvents[citizenid] = {}
        end

        calendarEvents[citizenid][date] = title
        MySQL.insert('INSERT INTO calendar_events (citizenid, date, title, is_global) VALUES (?, ?, ?, ?)', {
            citizenid,
            date,
            title,
            0
        })
        TriggerClientEvent('QBCore:Notify', src, 'Event Saved Successfully', 'success')
    end
end)

-- Fetch events from the database for the client
QBCore.Functions.CreateCallback('qb-calendar:getEvents', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid

    local events = globalEvents

    if calendarEvents[citizenid] then
        for date, title in pairs(calendarEvents[citizenid]) do
            events[date] = title
        end
    end

    cb(events)
end)
