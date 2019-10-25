vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_outlawalert")
vRPl = {}
Lserver = Tunnel.getInterface("vrp_outlawalert","vrp_outlawalert")
vRPl = Tunnel.getInterface("vrp_outlawalert","vrp_outlawalert")
Tunnel.bindInterface("vrp_outlawalert",vRPl)


function Isems()
    Lserver.perm({p1}, function(tilladelse)
    
        return tilladelse
    end)
end

-- outlawalert_client.lua
RegisterNetEvent('FirePlacing') -- adicione esse evento
AddEventHandler('FirePlacing', function(gx, gy, gz)
        local transM = 250
    local fireBlip = AddBlipForCoord(gx, gy, gz)
    SetBlipSprite(fireBlip,  436)
    SetBlipColour(fireBlip,  1)
    SetBlipAlpha(fireBlip,  transM)
    SetBlipAsShortRange(fireBlip,  1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("CBS-opkald")
    EndTextCommandSetBlipName(fireBlip)
    while transM ~= 0 do
        Wait(3000) -- her øger eller mindskes tiden, hvor blip vises
        transM = transM - 1
        SetBlipAlpha(fireBlip, transM)
    end
	RemoveBlip(fireBlip)
end)
