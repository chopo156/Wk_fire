---------------------made by Wick------------------------------------------------

local skins = {
    "S_M_Y_Fireman_01",
}
----------------------------------------------------------------------------------
function isPedAllowed()
    local ped = GetPlayerPed(-1)
    for i=1, #skins do
        if GetHashKey(skins[i]) == GetEntityModel(ped) then
            return true
        end
    end
    return false
end

SetPedInfiniteAmmo(GetPlayerPed(-1), true, "WEAPON_FIREEXTINGUISHER")