local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPl = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_outlawalert")
Lclient = Tunnel.getInterface("vrp_outlawalert","vrp_outlawalert")
Tunnel.bindInterface("vrp_outlawalert",vRPl)

--cfg = {}
--cfg.tilladelse = "wk.fire"; -- Indtast her tilladelse, som dine Firefighter har. [!]


function getOnDutyfire() -- function used to return the user id of the police group in a table
	local users = vRP.getUsersByPermission({"wk.fire"})

	 for k, v in pairs(users) do
		local user_id = v
		local player = vRP.getUserSource({user_id})
		local Firefighter = user_id
		if player ~= nil then
			return user_id
		end
	 end
end

local Firefighter = {}

RegisterServerEvent('fireInProgress')
AddEventHandler('fireInProgress', function(street1, street2)
	local user_id = vRP.getUserId({source}, function(user_id) return user_id end)
	local Firefighter = getOnDutyfire()	
	
	if user_id == Firefighter then
			vRPclient.notify(user_id,{"~r~Der er opdaget en brand ved ~w~"..street1.."~r~ og ~w~"..street2})
	end		
end)

RegisterServerEvent('fireInProgressS1')
AddEventHandler('fireInProgressS1', function(street2)
	local user_id = vRP.getUserId({source}, function(user_id) return user_id end)
	local Firefighter = getOnDutyfire()	
	
	if user_id == Firefighter then
			vRPclient.notify(user_id,{"~r~Der er opdaget en brand ved ~w~"..street2})
	end		
end)

RegisterServerEvent('fireInProgressPos')
AddEventHandler('fireInProgressPos', function(gx, gy, gz)
	local user_id = vRP.getUserId({source}, function(user_id) return user_id end)
	local Firefighter = getOnDutyfire()	
	
	if user_id == Firefighter then
			print(string.format("Brand rapporteret %.2f, %.2f, %.2f.",gx,gy,gz))
			TriggerClientEvent('FirePlacing', -1, gx, gy, gz)
	end		
end)
