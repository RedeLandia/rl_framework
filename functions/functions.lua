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

function alert(msg)
    SetTextComponentFormat('STRING')
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function notify(string)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(string)
    DrawNotification(true, false)
end

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