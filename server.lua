local QBCore = exports['qb-core']:GetCoreObject()

local function IsAdmin(source)

    for _, permission in ipairs(Config.Permissions) do

        if QBCore.Functions.HasPermission(source, permission) then
            return true
        end

    end

    return false
end

---------------------------------------------------
-- CHECK ADMIN
---------------------------------------------------

QBCore.Functions.CreateCallback('dz_adminmenu:server:IsAdmin', function(source, cb)

    cb(IsAdmin(source))

end)

---------------------------------------------------
-- GET PLAYERS
---------------------------------------------------

QBCore.Functions.CreateCallback('dz_adminmenu:server:GetPlayers', function(source, cb)

    if not IsAdmin(source) then
        cb({})
        return
    end

    local players = {}

    for _, playerId in ipairs(QBCore.Functions.GetPlayers()) do

        local Player = QBCore.Functions.GetPlayer(playerId)

        if Player then

            local charinfo = Player.PlayerData.charinfo

            players[#players + 1] = {
                id = playerId,
                name = charinfo.firstname .. ' ' .. charinfo.lastname,
                citizenid = Player.PlayerData.citizenid,
                job = Player.PlayerData.job.name
            }

        end

    end

    cb(players)

end)
