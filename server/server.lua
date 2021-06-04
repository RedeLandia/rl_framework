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

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local source = source
    local identifiers = GetPlayerIdentifiers(source)
    local identifier

    for k, v in ipairs(identifiers) do
        if string.match(v, 'steam:') then
            identifier = v
            break
        end
    end

    if not identifier then
        deferrals.done('Steam Client was not detected. Please restart the game and start Steam Client. If you need help, contact us in: discord.gg/example')
    else
        deferrals.done()

        exports.ghmattimysql:scalar('SELECT 1 FROM users WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(result)
            if not result then
                exports.ghmattimysql:execute('INSERT INTO users (identifier) VALUES (@identifier)', {
                    ['@identifier'] = identifier
                })
            end
        end)
    end
end)


--=-- Weapon Give --=--

RegisterServerEvent("weaponGive")
AddEventHandler("weaponGive", function(param, hash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(hash), 999, false, false)
end)




--=-- Version Checker --=--
Citizen.CreateThread(
        function()
            local vRaw = LoadResourceFile(GetCurrentResourceName(), 'version.json')
            if vRaw and Config.versionCheck then
                local v = json.decode(vRaw)
                PerformHttpRequest(
                        'https://raw.githubusercontent.com/RedeLandia/rl_framework/master/version.json',
                        function(code, res, headers)
                            if code == 200 then
                                local rv = json.decode(res)
                                if rv.version ~= v.version then
                                    print(
                                            ([[^1
--------------------------ENGLISH---------------------------
rl_framework
UPDATE: %s AVAILABLE
CHANGELOG: %s
--------------------------ENGLISH---------------------------

--------------------------PORTUGUÊS-------------------------
rl_framework
ATUALIZAÇÃO: %s DISPONÍVEL
CHANGELOG: %s
--------------------------PORTUGUÊS-------------------------
^0]]):format(
                                                    rv.version,
                                                    rv.changelog
                                            )
                                    )
                                end
                            else
                                print('There was an Error checking rl_framework version! | Ocorreu um erro verificando a versão do rl_logs')
                            end
                        end,
                        'GET'
                )
            end
        end
)
