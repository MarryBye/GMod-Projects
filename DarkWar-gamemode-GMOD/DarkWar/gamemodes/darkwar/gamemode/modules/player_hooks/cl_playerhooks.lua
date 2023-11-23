local hud_list = {

    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudSuitPower"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,
    ["CHudZoom"] = true,
    ["CHudDeathNotice"] = true,
    ["CHudPoisonDamageIndicator"] = true,
    ["CHudDamageIndicator"] = true,
    ['CHudCrosshair'] = true

}

hook.Add("HUDShouldDraw", "HideHUD", function(name)

    if not cl_VarsLoaded then return false end

    if hud_list[name] then

        return false
    
    end

end)

function GM:HUDDrawTargetID()
    
    return false

end

function GM:DrawDeathNotice()

	return false

end

function GM:ContextMenuEnabled()

    return false

end

function GM:ContextMenuOpen()

    return false

end

function GM:SpawnMenuOpen()

    if not cl_VarsLoaded then return false end
   	if lcply_adminRank then return true end

	return false

end