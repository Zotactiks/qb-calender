local isCalendarOpen = false

RegisterNetEvent('qb-calendar:openCalendar', function()
    local isAdmin = IsPlayerAceAllowed(PlayerId(), "admin") 
    SetNuiFocus(true, true)
    SendNUIMessage({ 
        action = 'openCalendar',
        isAdmin = isAdmin
    })
    isCalendarOpen = true
end)

RegisterNUICallback('closeCalendar', function(data, cb)
    SetNuiFocus(false, false)
    isCalendarOpen = false
    cb('ok')
end)

RegisterNUICallback('getEvents', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-calendar:getEvents', function(events)
        cb(events)
    end)
end)

RegisterNUICallback('saveEvent', function(data, cb)
    TriggerServerEvent('qb-calendar:saveEvent', data.date, data.title, data.isGlobal)
    cb('ok')
end)

RegisterCommand('opencalendar', function()
    TriggerEvent('qb-calendar:openCalendar')
end)
