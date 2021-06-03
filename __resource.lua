fx_version 'adamant'
game 'common'

name 'RedeLandia Framewrok'
description 'Framework for FiveM'
author 'UrgingGamer'
version '1.0.0'
url 'https://github.com/RedeLandia/rl_framework'

client_scripts {
    'client/client.lua',
    'functions/functions.lua'
}


server_script 'server/server.lua'

shared_script 'config.lua'

file 'version.json'

dependencies {
    'ghmattimysql'
}
