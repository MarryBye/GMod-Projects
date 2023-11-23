cl_VarsLoaded = false

local function lcply_vars()

	lcply_alive 	= lcply:Health() > 0
	lcply_aiming 	= lcply:KeyDown(IN_ATTACK2)
	lcply_damaged	= lcply:GetPlayerDamagedOther()
	lcply_dead 		= lcply:GetPlayerDead()
	lcply_admin		= lcply:GetPlayerIsAdmin()
	lcply_adminRank = lcply:GetPlayerIsAdminRank()
	lcply_spec 		= lcply:GetPlayerSpectator()
	lcply_canchtm	= lcply:CanChangeTeam()
	lcply_kills 	= lcply:GetPlayerKills()
	lcply_npcKills 	= lcply:GetPlayerNPCKills()
	lcply_deaths 	= lcply:Deaths()
	lcply_kddiv		= lcply:GetPlayerKD()
	lcply_hp 		= lcply:Health()
	lcply_arm 		= lcply:Armor()
	lcply_model 	= lcply:GetModel()
	lcply_money 	= lcply:GetPlayerMoney()
	lcply_class 	= lcply:GetPlayerClass()
	lcply_team 		= lcply:GetPlayerTeam()
	lcply_rank		= lcply:GetPlayerRank()
	lcply_pos 		= lcply:GetPos()
	lcply_steamid 	= lcply:SteamID()

end

local function lcply_wep_vars()

	lcply_wep 		= lcply:GetActiveWeapon()

	if not IsValid(lcply_wep) then return end

	lcply_wep_prim	= lcply_wep:GetPrimaryAmmoType()
	lcply_wep_clip1 = lcply_wep:Clip1()
	lcply_wep_valid = lcply_wep:CanBeTakedInArms()
	lcply_wep_ammos = lcply:GetAmmoCount(lcply_wep_prim)

end

local function lcply_convars()

	lcply_cvarCrossVar	= GetConVar('dwr_crosshair')
	lcply_cvarCrossSize = GetConVar('dwr_crosshair_size')
	lcply_cvarCrossCol	= GetConVar('dwr_color')

	lcply_CrossVar 		= lcply_cvarCrossVar:GetString()
	lcply_CrossSize 	= lcply_cvarCrossSize:GetInt()
	lcply_CrossCol 		= string.ToColor(lcply_cvarCrossCol:GetString())

	lcply_cvarDmgVar 	= GetConVar('dwr_indicator')
    lcply_cvarDmgSize 	= GetConVar('dwr_indicator_size')
    lcply_cvarDmgCol 	= GetConVar('dwr_color_ind')

    lcply_DmgVar 		= lcply_cvarDmgVar:GetString()
    lcply_DmgSize 		= lcply_cvarDmgSize:GetInt()
    lcply_DmgCol 		= string.ToColor(lcply_cvarDmgCol:GetString())

    lcply_cvarIcoCol 	= GetConVar('dwr_color_ico')

    lcply_IcoCol 		= string.ToColor(lcply_cvarIcoCol:GetString())


end

local function other_vars()

	scrw, scrh 			= ScrW(), ScrH()
	mouse_x, mouse_y 	= gui.MousePos()

end

timer.Create('RefreshVars', 0, 0, function()

	lcply 			= LocalPlayer()

	if not IsValid(lcply) then return end

	lcply_vars()
	lcply_convars()
	lcply_wep_vars()
	other_vars()

	if not cl_VarsLoaded then cl_VarsLoaded = true end

end)