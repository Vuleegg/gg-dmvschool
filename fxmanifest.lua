fx_version 'cerulean'
game 'gta5'
verzija '1.0.0'
deskripcija 'autoskola'
autor 'vulegg#5757'



lua54 'yes'
shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
    'locale/en.lua',
}

client_scripts {
    'client/**.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/**.lua',
}

dependencies {
    'es_extended',
    'ox_lib',
}