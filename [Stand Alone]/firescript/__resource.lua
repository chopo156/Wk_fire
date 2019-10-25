resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

dependency "vrp"

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua",
	"vars/variables.lua",
}
client_scripts { 
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"client.lua",
	"vars/variables.lua",
}

-- Export function
export "PagePagers"


