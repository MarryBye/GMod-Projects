function GM:PlayerPostThink(ply)

	if not ply:GetAuthorised() then return end

	local curtime = CurTime()
	local ply_money = ply:GetPlayerMoney()
	local ply_kills = ply:GetPlayerKills()
	local ply_frags = ply:Frags()
	local ply_hp = ply:Health()
	local ply_mhp = ply:GetMaxHealth()
	local ply_arm = ply:Armor()
	local ply_marm = ply:GetMaxArmor()
	local ply_dead = ply:GetPlayerDead()
	local ply_damagedother = ply:GetPlayerDamagedOther()

	if ply_money < 0 then

		ply:AddPlayerMoney(-ply_money)

	end

	if ply_kills < 0 then

		ply:AddPlayerKills(-ply_kills)

	end

	if ply_frags < 0 then

		ply:SetFrags(0)

	end

	if ply_hp > ply_mhp then 

		ply:SetHealth(ply_mhp)

	end

	if ply_arm > ply_marm then

		ply:SetArmor(ply_marm)

	end

	local ply_wep = ply:GetActiveWeapon()

	if IsValid(ply_wep) then

		local ply_wep_primAmmo = ply_wep:GetPrimaryAmmoType()
		local ply_wep_allAmmo = ply:GetAmmoCount(ply_wep_primAmmo)
		local ply_wep_ammoName = game.GetAmmoName(ply_wep_primAmmo)
		local ply_wep_maxClip1 = ply_wep:GetMaxClip1()

		if ply_wep_ammoName ~= nil then

			if ply_wep_allAmmo > ply_wep_maxClip1 * GAMEMODE.Config.maxClipCanTake then

				ply:SetAmmo(ply_wep_maxClip1 * GAMEMODE.Config.maxClipCanTake, ply_wep_ammoName)

			end

			if ply_wep_allAmmo > GAMEMODE.Config.maxAmmoCanTake then

				ply:SetAmmo(GAMEMODE.Config.maxAmmoCanTake, ply_wep_ammoName)

			end

		end

	end

	if ply_damagedother then

		if ply.TimeWhenDealDamage < curtime then

			ply:SetPlayerDamagedOther(false)

		end

	end

	if ply_dead then

		if ply.CanRespawnAfterDeathAfter < curtime then

			ply:SetPlayerDead(false)

			ply:UnLock()

		end

	end

end