RegisterServerEvent('thiefInProgress')
AddEventHandler('thiefInProgress', function(street1, street2, veh, sex)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "cop", "Car jacking, mistænkt er en "..sex.." sidst set på "..street1.." og "..street2)
	else
		TriggerClientEvent("outlawNotify", -1, "cop", "Car jacking, mistænkt kører en "..veh.." er en "..sex.." sidst set på "..street1.." og "..street2)
	end
end)

RegisterServerEvent('thiefInProgressS1')
AddEventHandler('thiefInProgressS1', function(street1, veh, sex)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "cop", "Stjålet bil af en "..sex.." sidst set på "..street1)
	else
		TriggerClientEvent("outlawNotify", -1, "cop", "Stjålet "..veh.." sidst set hurtigere med en "..sex.." rundt om "..street1)
	end
end)


RegisterServerEvent('fireInProgress')
AddEventHandler('fireInProgress', function(street1, street2)
	TriggerClientEvent("outlawNotify", -1, "fire", "Der er opdaget en brand ved "..street1.." og "..street2)

end)

RegisterServerEvent('fireInProgressS1')
AddEventHandler('fireInProgressS1', function(streetA)
	TriggerClientEvent("outlawNotify", -1, "fire", "Der er opdaget en brand ved "..streetA)
end)


RegisterServerEvent('gunshotInProgress')
AddEventHandler('gunshotInProgress', function(street1, street2, sex)
	TriggerClientEvent("outlawNotify", -1, "cop", "Skud fyret, ved en "..sex.." mellem "..street1.." og "..street2)
end)

RegisterServerEvent('gunshotInProgressS1')
AddEventHandler('gunshotInProgressS1', function(street1, sex)
	TriggerClientEvent("outlawNotify", -1, "cop", "Skud fyret af en "..sex.."  sidst set ved "..street1)
end)

RegisterServerEvent('thiefInProgressPos')
AddEventHandler('thiefInProgressPos', function(tx, ty, tz)
	TriggerClientEvent('thiefPlace', -1, tx, ty, tz)
end)

RegisterServerEvent('gunshotInProgressPos')
AddEventHandler('gunshotInProgressPos', function(gx, gy, gz)
	TriggerClientEvent('gunshotPlace', -1, gx, gy, gz)
end)

RegisterServerEvent('fireInProgressPos')
AddEventHandler('fireInProgressPos', function(mx, my, mz)
	print(string.format("outlaw. Brand rapporteret %.2f, %.2f, %.2f.",mx,my,mz))
	TriggerClientEvent('FirePlacing', -1, mx, my, mz)
end)