--Config
local timer = 2 --in minutes - Set the time during the player is outlaw
local showOutlaw = true --Set if show outlaw act on map
local gunshotAlert = true --Set if show alert when player use gun
local carJackingAlert = true --Set if show when player do carjacking
local meleeAlert = true --Set if show when a fire starts 
local blipGunTime = 90 --in second
local blipMeleeTime = 500 --in second
local blipJackingTime = 90 -- in second
local debugFirePlacing = true -- if notifications should be shown for fires
--End config

local origin = false --Don't touche it
local timing = timer * 60000 --Don't touche it

local msg = function(text,ms)
	exports.pNotify:SendNotification({text = text,type = "warning",timeout = (ms or 8000),layout = "centerLeft",queue = "right"})
end
local FireModels = {
	[GetHashKey("S_M_Y_Fireman_01")] = true,
	[GetHashKey("s_f_y_paramedic_01")] = true,
	[GetHashKey("medic")] = true,
	[GetHashKey("lsfd")] = true,
}
local PoliceModels = {
        [GetHashKey("s_m_y_cop_01")] = true,
        [GetHashKey('s_m_m_snowcop_01')] = true,
        [GetHashKey('s_m_y_hwaycop_01')] = true,
        [GetHashKey('s_f_y_cop_01')] = true,
        [GetHashKey('s_m_y_sheriff_01')] = true,
        [GetHashKey('s_m_y_ranger_01')] = true,
        [GetHashKey('s_m_m_armoured_01')] = true,
        [GetHashKey('s_m_m_armoured_01')] = true,
        [GetHashKey('s_f_y_sheriff_01')] = true,
        [GetHashKey('s_f_y_ranger_01')] = true,
        [GetHashKey('s_m_y_swat_01')] = true,
    }
GetPlayerName()
RegisterNetEvent('outlawNotify')
AddEventHandler('outlawNotify', function(faction,alert)
	if origin then
		return
	end
	
	local model = GetEntityModel(GetPlayerPed(-1))
	if faction == "fire" then
		if not FireModels[model] then
			return
		end
	elseif faction == "cop" then
		if not PoliceModels[model] then
			return
		end
	else
		msg("INVALID FACTION FOR outlawNotify")
		return
	end
    Notify(alert)
end)

function Notify(msg)
    exports.pNotify:SendNotification({text = msg,type = "warning",timeout = 8000,layout = "centerLeft",queue = "right"})
    CancelEvent()
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if NetworkIsSessionStarted() then
            DecorRegister("IsOutlaw",  3)
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
            return
        end
    end
end)

RegisterNetEvent('thiefPlace')
AddEventHandler('thiefPlace', function(tx, ty, tz)
	if origin or not carJackingAlert or not PoliceModels[GetEntityModel(GetPlayerPed(-1))] then
		return
	end
    local transT = 250
    local thiefBlip = AddBlipForCoord(tx, ty, tz)
    SetBlipSprite(thiefBlip,  304)
    SetBlipColour(thiefBlip,  4)
    SetBlipAlpha(thiefBlip,  transT)
    SetBlipAsShortRange(thiefBlip,  1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("CBS Call")
    EndTextCommandSetBlipName(thiefBlip)
    while transT ~= 0 do
        Wait(blipJackingTime * 4)
        transT = transT - 1
        SetBlipAlpha(thiefBlip,  transT)
    end
	RemoveBlip(thiefBlip)
end)

RegisterNetEvent('gunshotPlace')
AddEventHandler('gunshotPlace', function(gx, gy, gz)
	if origin or not gunshotAlert or not PoliceModels[GetEntityModel(GetPlayerPed(-1))] then
		return
	end
    local transG = 250
    local gunshotBlip = AddBlipForCoord(gx, gy, gz)
    SetBlipSprite(gunshotBlip,  304)
    SetBlipColour(gunshotBlip,  2)
    SetBlipAlpha(gunshotBlip,  transG)
    SetBlipAsShortRange(gunshotBlip,  1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("CBS Call")
    EndTextCommandSetBlipName(gunshotBlip)
    while transG ~= 0 do
        Wait(blipGunTime * 10)
        transG = transG - 1
        SetBlipAlpha(gunshotBlip,  transG)
    end
	RemoveBlip(gunshotBlip)
end)

RegisterNetEvent('FirePlacing')
AddEventHandler('FirePlacing', function(mx, my, mz)
	if origin then
		if debugFirePlacing then
			msg("Brand startede, Alarmcentralen gav ikke fuld information.")
		end
		return
	end
	if not meleeAlert then
		if debugFirePlacing then
			msg("BRAND ALARM FRA")
		end
		return
	end
	local player = GetPlayerPed(-1)
	if not FireModels[GetEntityModel(player)] then
		if debugFirePlacing then
			--msg("En brand er begyndt i byen")
		end
		return
	end
	--msg("MODTAGELSE AF BRAND")
    local transM = 250
    local meleeBlip = AddBlipForCoord(mx, my, mz)
    SetBlipSprite(meleeBlip,  436)
    SetBlipColour(meleeBlip,  1)
    SetBlipAlpha(meleeBlip,  transM)
    SetBlipAsShortRange(meleeBlip,  1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("CBS-opkald")
    EndTextCommandSetBlipName(meleeBlip)
    while transM ~= 0 do
        Wait(blipMeleeTime * 4)
        transM = transM - 1
        SetBlipAlpha(meleeBlip, transM)
    end
	RemoveBlip(meleeBlip)
end)

--Star color
--[[1- White
2- Black
3- Grey
4- Clear grey
5-
6-
7- Clear orange
8-
9-
10-
11-
12- Clear blue]]

--Citizen.CreateThread( function()
--    while true do
--        Wait(0)
--        if showOutlaw then
--            for i = 0, 31 do
--                if DecorGetInt(GetPlayerPed(i), "IsOutlaw") == 2 and GetPlayerPed(i) ~= GetPlayerPed(-1) then
--                    gamerTagId = Citizen.InvokeNative(0xBFEFE3321A3F5015, GetPlayerPed(i), ".", false, false, "", 0 )
--                    Citizen.InvokeNative(0xCF228E2AA03099C3, gamerTagId, 0) --Show a star
--                    Citizen.InvokeNative(0x63BB75ABEDC1F6A0, gamerTagId, 7, true) --Active gamerTagId
--                    Citizen.InvokeNative(0x613ED644950626AE, gamerTagId, 7, 1) --White star
--                elseif DecorGetInt(GetPlayerPed(i), "IsOutlaw") == 1 then
--                    Citizen.InvokeNative(0x613ED644950626AE, gamerTagId, 7, 255) -- Set Color to 255
--                    Citizen.InvokeNative(0x63BB75ABEDC1F6A0, gamerTagId, 7, false) --Unactive gamerTagId
--                end
--            end
--        end
--    end
--end)

Citizen.CreateThread( function()
    while true do
        Wait(0)
        if DecorGetInt(GetPlayerPed(-1), "IsOutlaw") == 2 then
            Wait( math.ceil(timing) )
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
        end
    end
end)

Citizen.CreateThread( function()
    while true do
        Wait(0)
        local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
        local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        local street1 = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
        if IsPedTryingToEnterALockedVehicle(GetPlayerPed(-1)) or IsPedJacking(GetPlayerPed(-1)) then
            origin = true
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
            local male = IsPedMale(GetPlayerPed(-1))
            if male then
                sex = "male"
            elseif not male then
                sex = "female"
            end
            TriggerServerEvent('thiefInProgressPos', plyPos.x, plyPos.y, plyPos.z)
            local veh = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
            local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
            local vehName2 = GetLabelText(vehName)
            if s2 == 0 then
                TriggerServerEvent('thiefInProgressS1', street1, vehName2, sex)
            elseif s2 ~= 0 then
                TriggerServerEvent('thiefInProgress', street1, street2, vehName2, sex)
            end
            Wait(5000)
            origin = false
        end
    end
end)

--[[
Citizen.CreateThread( function()
    while true do
        Wait(0)
        local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
        local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        local street1 = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
        if IsPedInMeleeCombat(GetPlayerPed(-1)) then 
            origin = true
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
            local male = IsPedMale(GetPlayerPed(-1))
            if male then
                sex = "male"
            elseif not male then
                sex = "female"
            end
            TriggerServerEvent('meleeInProgressPos', plyPos.x, plyPos.y, plyPos.z)
            if s2 == 0 then
                TriggerServerEvent('meleeInProgressS1', street1)
            elseif s2 ~= 0 then
                TriggerServerEvent("meleeInProgress", street1, street2)
            end
            Wait(3000)
            origin = false
        end
    end
end)]]

Citizen.CreateThread( function()
    while true do
        Wait(0)
        local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
        local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        local street1 = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
        if IsPedShooting(GetPlayerPed(-1)) then
            origin = true
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
            local male = IsPedMale(GetPlayerPed(-1))
            if male then
                sex = "male"
            elseif not male then
                sex = "female"
            end
            TriggerServerEvent('gunshotInProgressPos', plyPos.x, plyPos.y, plyPos.z)
            if s2 == 0 then
                TriggerServerEvent('gunshotInProgressS1', street1, sex)
            elseif s2 ~= 0 then
                TriggerServerEvent("gunshotInProgress", street1, street2, sex)
            end
            Wait(3000)
            origin = false
        end
    end
end)