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


RegisterServerEvent("WK:firePos")
AddEventHandler("WK:firePos", function(mx, my, mz)
	print(string.format("Fire reported %.2f, %.2f, %.2f.",mx,my,mz))
	--print(string.format("Brand rapporteret %.2f, %.2f, %.2f.",mx,my,mz))
	TriggerClientEvent("WK:FirePlacing", -1, mx, my, mz)
end)
 RegisterServerEvent("WK:firesyncs")
 AddEventHandler("WK:firesyncs", function( firec, lastamnt, deletedfires, original )
	--local test = ping
	TriggerClientEvent("WK:firesyncs2", -1, firec, lastamnt, deletedfires, original)
	--TriggerClientEvent("WK:firesync3", -1)
end)
  RegisterServerEvent("WK:fireremovesyncs2")
 AddEventHandler("WK:fireremovesyncs2", function( firec, lastamnt, deletedfires, original )
	--local test = ping
	TriggerClientEvent("WK:fireremovesync", -1, firec, lastamnt, deletedfires, original)
 end)
 RegisterServerEvent("WK:firesyncs60")
 AddEventHandler("WK:firesyncs60", function()
	--local test = ping
	--TriggerClientEvent("WK:firesyncs2", -1, firec, lastamnt, deletedfires, original)
	TriggerClientEvent("WK:firesync3", -1)
 end)
  RegisterServerEvent("WK:removefires")
 AddEventHandler("WK:removefires", function( x, y, z, i )
	local test = i
	--local test = ping
	TriggerClientEvent("WK:fireremovess", -1, x, y, z, test)
	--TriggerClientEvent("WK:firesync3", -1)
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
        	TriggerClientEvent("WK:firethings", p)
        	CancelEvent()
        end]]
        if cmd == "/firestop" then
			TriggerClientEvent("chatMessage", p, "FIRE ", {255, 0, 0}, "Du stoppede alle brande!")
			--TriggerClientEvent("chatMessage", p, "FIRE ", {255, 0, 0}, "You stopped all the fires!")
        	TriggerClientEvent("WK:firestop", p)
			TriggerClientEvent("WK:firesync", -1)
        	CancelEvent()
        end
       --[[ if cmd == "/coor098ds" then
        	TriggerClientEvent("WK:coords", p)
        	CancelEvent()
        end]]
		if cmd == "/firecount" then
        	TriggerClientEvent("WK:firecounter", p)
        	CancelEvent()
        end
        if cmd == "/cbomb" then
        	TriggerClientEvent("WK:carbomb", p)
        	CancelEvent()
        end
		--[[if cmd == "/t56est" then
        	TriggerClientEvent("WK:test1", p)
        	CancelEvent()
        end]]
		if cmd == "/sync" then
        	TriggerClientEvent("WK:firesync3", p)
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
RegisterServerEvent("WK:amfireman")

local spawnRandomFires = true -- set to true and put x,y,z locations and amount of time before their is a chance of a fire spawning
local spawnRandomFireChance = 750 -- basically a thousand sided dice is rolled and if it gets above this number then a fire spawns at one of the locations specified
local spawnRandomFireAlways = true -- for debugging, overrides the chance.
local randomSpawnTime = 900000 -- time to wait before trying ot spawn another random fire in milliseconds 1,200,000 is 20 minutes.
local randomResponseTime = 1000 -- time to wait for response from clients if they're a fireman.
local function randomFireAttempt()
	if not spawnRandomFires then
		SetTimeout(randomSpawnTime,randomFireAttempt)
		print("[FIRE] Tilfældige brande er slukket.")
		--print("[FIRE] Random fires are extinguished.")
	elseif not spawnRandomFireAlways and not (math.random(1,1000) <= spawnRandomFireChance) then
		SetTimeout(randomSpawnTime,randomFireAttempt)
		print("[FIRE] Tilfældig brand fik et dårligt kast.")
		--print("[FIRE] Random fire got a bad throw.")
	else
		print("[FIRE] Tilfældig brand starter...")
		--print("[FIRE] Random fire starts...")
		local event
		event = AddEventHandler("WK:amfireman",function()
			if event then
				RemoveEventHandler(event)
				event = nil
				TriggerClientEvent("WK:random",source)
				SetTimeout(randomSpawnTime,randomFireAttempt)
				print("[FIRE] "..(GetPlayerName(source) or "???").." vil klar det.")
				--print("[FIRE] "..(GetPlayerName(source) or "???").." will do it.")
			end
		end)
		SetTimeout(randomResponseTime,function()
			if event then
				RemoveEventHandler(event)
				event = nil
				SetTimeout(randomSpawnTime,randomFireAttempt)
				print("[FIRE] Nevermind, ingen brandmænd!")
				--print("[FIRE] Nevermind, no firefighters on!")
			end
		end)
		TriggerClientEvent("WK:askfireman",-1)
	end
end
math.randomseed(os.time())
SetTimeout(randomSpawnTime,randomFireAttempt)