--EN:
--
-- RedeLandia Framework V. 2.0
-- Created by: UrgingGamer
--
-- Copyright (c) RedeLandia 2021. All rights Reserved!

--PT:
--
-- RedeLandia Framework V. 2.0
-- Criada por: UrgingGamer
--
-- Copyright (c) RedeLandia 2021. Todos os Direitos Reservados!


--=-- Give Weapon --=--
RegisterCommand('giveweapon', function(source, args)
    TriggerServerEvent("weaponGive", giveTheWeaponToPed(args[1]))
    notify('~g~You recive the weapon: ' .. args[1])

end, false)

--=-- Remove Weapons --=--
RegisterCommand('clearloadout', function()
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
    notify('~g~You removed all weapons from your inventory!')
end, false)

local cars = {'police', 'police2', 'riot', 'riot2'}

RegisterCommand('car', function()

    local cars = (cars[math.random(#cars)])
    spawnCar(car)
    notify('~g~You Spawned the:' .. car)

end, false)

--=-- Creates the TPM command --=--
RegisterCommand('tpm', function(source, args, raw)
    local playerPed = PlayerPedId() -- GetPlayerPed(-1)
    local waypoint = GetFirstBlipInfoId(8)
    local waypointCoords = GetBlipInfoIdCoord(waypoint)

    SetEntityCoords(playerPed, waypointCoords.x, waypointCoords.y, waypointCoords.z+35)
    notify('~g~Teleported to that position!')

end, false)


--=-- GOD Mode --=--
RegisterCommand('god', function(source, args)
    god = not god
    if god then
        SetEntityInvincible(GetPlayerPed(-1), true)
        alert("~g~God Mode On")
    else
        SetEntityInvincible(GetPlayerPed(-1), false)
        alert("~r~God Mode Off")
    end
end)


--=-- Functions --=--

    --=-- Spawn Car --=--
function spawnCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, x + 3, y + 4, z + 1, 0.0, true, false)
    SetEntityAsMissionEntry(vehicle, true, true)
end
    --=-- Alert (Top) --=--
function alert(msg)
    SetTextComponentFormat('STRING')
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
    --=-- Notify (Radar) --=--
function notify(string)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(string)
    DrawNotification(true, false)
end

    --=-- Weapon Give --=--
function giveTheWeaponToPed(hash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(hash), 999, false, false)
end


--=-- Command Suggestion in Chat --=--
Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/tpm', 'Teleport you to your current waypoint!',{})
    TriggerEvent('chat:addSuggestion', '/clearloadout', 'Remove all your weapons from your inventory!',{})
    TriggerEvent('chat:addSuggestion', '/car', 'Spawns an random car',{})
    TriggerEvent('chat:addSuggestion', '/giveweapon', 'Give yourself an Weapon',{{name="Weapon", help="Put here the Weapon Name"}})
end)
