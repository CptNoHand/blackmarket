fx_version 'cerulean'
game 'gta5'

author 'ManLikeTJB'
description 'BlackMarket'
version '4.0.1'


server_scripts {
    "server/main.lua"
}

client_scripts {
	"client/main.lua"
}

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

dependency {
	'nh-context'
}
