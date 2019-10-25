print("Fire Script has loaded! Coded by Wick")

-- RegisterServerEvent("lol:startfire")
-- AddEventHandler("lol:startfire", function( x , y , z , args, p)
	-- TriggerClientEvent("chatMessage", p, "LOL ", {255, 0, 0}, "it got to server.")
	-- maxChilds = args[1]
	-- isGas = args[2]
	-- gasFire = false
	-- if (isGas == 1) then
		-- gasFire = true
	-- end
	-- TriggerClientEvent("chatMessage", p, "INFO", {255, 0, 0}, tostring(y))
	-- TriggerClientEvent("chatMessage", p, "INFO", {255, 0, 0}, tostring(maxChilds))
	-- TriggerClientEvent("chatMessage", p, "INFO", {255, 0, 0}, tostring(gasFire))
	-- StartScriptFire(x, y, z, maxChilds, gasFire)
-- end)
RegisterServerEvent('fire:chatAlert2')
AddEventHandler('fire:chatAlert2', function( text )  
    TriggerClientEvent('chatMessage2', -1, 'FIRE', {255, 0, 0}, 'Der er opdaget en brand ved: ' .. text)
end)
RegisterServerEvent('fire:chatAlert')
AddEventHandler('fire:chatAlert', function( text )  
    TriggerClientEvent('meleeInProgress', -1, 'FIRE', {255, 0, 0}, 'Der er opdaget en brand ved: ' .. text)
end)
 RegisterServerEvent("lol:firesyncs")
 AddEventHandler("lol:firesyncs", function( firec, lastamnt, deletedfires, original )
	--local test = ping
	TriggerClientEvent("lol:firesyncs2", -1, firec, lastamnt, deletedfires, original)
	--TriggerClientEvent("lol:firesync3", -1)
 end)
  RegisterServerEvent("lol:fireremovesyncs2")
 AddEventHandler("lol:fireremovesyncs2", function( firec, lastamnt, deletedfires, original )
	--local test = ping
	TriggerClientEvent("lol:fireremovesync", -1, firec, lastamnt, deletedfires, original)
 end)
 RegisterServerEvent("lol:firesyncs60")
 AddEventHandler("lol:firesyncs60", function()
	--local test = ping
	--TriggerClientEvent("lol:firesyncs2", -1, firec, lastamnt, deletedfires, original)
	TriggerClientEvent("lol:firesync3", -1)
 end)
  RegisterServerEvent("lol:removefires")
 AddEventHandler("lol:removefires", function( x, y, z, i )
	local test = i
	--local test = ping
	TriggerClientEvent("lol:fireremovess", -1, x, y, z, test)
	--TriggerClientEvent("lol:firesync3", -1)
 end)
 RegisterServerEvent("fire:syncedAlarm")
AddEventHandler("fire:syncedAlarm", function()
  TriggerClientEvent("triggerSound", source)
end)
 
AddEventHandler("chatMessage", function(p, color, msg)
    if msg:sub(1, 1) == "/" then
        fullcmd = stringSplit(msg, " ")
        cmd = fullcmd[1]
		
		

        --[[if cmd == "/fir89765e" then
			TriggerClientEvent("chatMessage", p, "FIRE ", {255, 0, 0}, "Du startede en brand! ")
                local fireamnt = cmd[2]
        	TriggerClientEvent("lol:firethings", p)
        	CancelEvent()
        end]]
        if cmd == "/firestop" then
			TriggerClientEvent("chatMessage", p, "FIRE ", {255, 0, 0}, "Du stoppede alle brande!")
        	TriggerClientEvent("lol:firestop", p)
			TriggerClientEvent("lol:firesync", -1)
        	CancelEvent()
        end
       --[[ if cmd == "/coor098ds" then
        	TriggerClientEvent("lol:coords", p)
        	CancelEvent()
        end]]
		if cmd == "/firecount" then
        	TriggerClientEvent("lol:firecounter", p)
        	CancelEvent()
        end
        if cmd == "/cbomb" then
        	TriggerClientEvent("lol:carbomb", p)
        	CancelEvent()
        end
		--[[if cmd == "/t56est" then
        	TriggerClientEvent("l0l:test1", p)
        	CancelEvent()
        end]]
		if cmd == "/sync" then
        	TriggerClientEvent("lol:firesync3", p)
        end
       --[[ if cmd == "/fireh56elp" then
        	TriggerClientEvent("chatMessage", p, "FIRE ", {255, 0, 0}, "Du kan starte en stor brand ved at skrive /fire, og du kan også starte en enkelt brand ved at skrive /cbomb sprænger den sidste bil, du kom ind, og starter en stor brand omkring den!")
        	CancelEvent()
        end]]
    end
end)
function stringSplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

------------------------------------------------------------
----------------------- RANDOM FIRES -----------------------
------------------------------------------------------------
RegisterServerEvent("lol:amfireman")

local spawnRandomFires = true -- set to true and put x,y,z locations and amount of time before their is a chance of a fire spawning
local spawnRandomFireChance = 750 -- basically a thousand sided dice is rolled and if it gets above this number then a fire spawns at one of the locations specified
local spawnRandomFireAlways = true -- for debugging, overrides the chance.
local randomSpawnTime = 900000 -- time to wait before trying ot spawn another random fire in milliseconds 1,200,000 is 20 minutes.
local randomResponseTime = 1000 -- time to wait for response from clients if they're a fireman.
local function randomFireAttempt()
	if not spawnRandomFires then
		SetTimeout(randomSpawnTime,randomFireAttempt)
		print("[FIRE] Tilfældige brande er slukket.")
	elseif not spawnRandomFireAlways and not (math.random(1,1000) <= spawnRandomFireChance) then
		SetTimeout(randomSpawnTime,randomFireAttempt)
		print("[FIRE] Tilfældig brand fik et dårligt kast.")
	else
		print("[FIRE] Tilfældig brand starter...")
		local event
		event = AddEventHandler("lol:amfireman",function()
			if event then
				RemoveEventHandler(event)
				event = nil
				TriggerClientEvent("lol:random",source)
				SetTimeout(randomSpawnTime,randomFireAttempt)
				print("[FIRE] "..(GetPlayerName(source) or "???").." vil klar det.")
			end
		end)
		SetTimeout(randomResponseTime,function()
			if event then
				RemoveEventHandler(event)
				event = nil
				SetTimeout(randomSpawnTime,randomFireAttempt)
				print("[FIRE] Nevermind, ingen brandmænd!")
			end
		end)
		TriggerClientEvent("lol:askfireman",-1)
	end
end
math.randomseed(os.time())
SetTimeout(randomSpawnTime,randomFireAttempt)