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

--=-- rl_framework Default Command
RegisterCommand('rlframework', function(source, args)

    if args[1] == 'commands' then
        sendChatMessage("~y~-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
        sendChatMessage("~r~Commands of rl_framework:")
        sendChatMessage("~b~/car <car>              ~w~Spawns a Car")
        sendChatMessage("~b~/clearloadout           ~w~Clear a Loadout")
        sendChatMessage("~b~/tpm                    ~w~Teleports to your Waipoint")
        sendChatMessage("~b~/god                    ~w~Enable / Disable God Mode")
        sendChatMessage("~b~/giveweapon <weapon>    ~w~Give you an Weapon")
        sendChatMessage("~y~-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
    else
        sendChatMessage("~y~-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
        sendChatMessage("~r~Please put an Valid Subcommand!")
        sendChatMessage("~y~-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
    end
end)

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



--=-- Disable Police Method --=--
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DisablePlayerVehicleRewards(GetPlayerPed(-1))

        if Config.enableCops == false then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
            SetPoliceIgnorePlayer(PlayerId(), true)
            SetDispatchCopsForPlayer(PlayerId(), false)
            SetDitchPoliceModels()
            SetMaxWantedLevel(0)
        elseif Config.enableCops == true then
            SetPoliceIgnorePlayer(PlayerId(), false)
            SetDispatchCopsForPlayer(PlayerId(), true)
            SetMaxWantedLevel(5)
        end

        local playerPed = GetPlayerPed(-1)
        local playerLocalisation = GetEntityCoords(playerPed)
        DisablePlayerVehicleRewards(PlayerId(-1))
    end
end)


--=-- Cash Give to Player --=--

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local rPlayerPed = GetPlayerPed(-1)

        StatSetInt("MP0_WALLET_BALANCE", Config.cashGive, false)

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

    --=-- Chat Message --=--
function sendChatMessage(text)
    TriggerEvent("chatMessage", "[ RL_Framework ]", {255,0,255}, text)
end


--=-- Command Suggestion in Chat --=--
Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/rlframework', 'Default RL_FRAMEWORK command',{{name="Subcommand", help="Subcommands: commands"}})
    TriggerEvent('chat:addSuggestion', '/god', 'You are gonna be an god :)',{})
    TriggerEvent('chat:addSuggestion', '/tpm', 'Teleport you to your current waypoint!',{})
    TriggerEvent('chat:addSuggestion', '/clearloadout', 'Remove all your weapons from your inventory!',{})
    TriggerEvent('chat:addSuggestion', '/car', 'Spawns an random car',{})
    TriggerEvent('chat:addSuggestion', '/giveweapon', 'Give yourself an Weapon',{{name="Weapon", help="Put here the Weapon Name"}})
end)
