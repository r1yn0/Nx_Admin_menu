local QBCore = exports['qb-core']:GetCoreObject()

local MenuOpen = false

---------------------------------------------------
-- OPEN ADMIN MENU
---------------------------------------------------

RegisterCommand(Config.OpenCommand, function()

    QBCore.Functions.TriggerCallback(
        'dz_adminmenu:server:IsAdmin',
        function(isAdmin)

            if not isAdmin then

                QBCore.Functions.Notify(
                    'You do not have permission',
                    'error'
                )

                return
            end

            MenuOpen = true

            SetNuiFocus(true, true)

            SendNUIMessage({
                action = 'open',
                serverName = Config.ServerName
            })

            TriggerServerEvent('dz_adminmenu:server:RequestPlayers')

        end
    )

end, false)

---------------------------------------------------
-- CLOSE MENU
---------------------------------------------------

RegisterNUICallback('close', function(_, cb)

    MenuOpen = false

    SetNuiFocus(false, false)

    SendNUIMessage({
        action = 'close'
    })

    cb('ok')

end)

---------------------------------------------------
-- GET PLAYERS
---------------------------------------------------

RegisterNUICallback('getPlayers', function(_, cb)

    QBCore.Functions.TriggerCallback(
        'dz_adminmenu:server:GetPlayers',
        function(players)

            cb(players)

        end
    )

end)

---------------------------------------------------
-- ESC CLOSE
---------------------------------------------------

CreateThread(function()

    while true do

        Wait(0)

        if MenuOpen then

            if IsControlJustPressed(0, 322) then

                MenuOpen = false

                SetNuiFocus(false, false)

                SendNUIMessage({
                    action = 'close'
                })

            end

        else

            Wait(500)

        end

    end

end)
