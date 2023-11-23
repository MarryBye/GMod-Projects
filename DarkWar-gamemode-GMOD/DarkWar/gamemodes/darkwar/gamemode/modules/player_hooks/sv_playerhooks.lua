function GM:PlayerInitialSpawn(ply)

	timer.Simple(0.1, function()

		ply:SetAuthorised(false)

		if ply:IsBot() then

			local randomTeam = table.Random({GAMEMODE.Config.firstTeamName, GAMEMODE.Config.secondTeamName})
				
			local classTable = table.Copy(GAMEMODE.Config.playerClasses)
				
			local randomClass = classTable[math.random(1, #classTable)].class
			local randomModel = table.Random(classTable[math.random(1, #classTable)].models[randomTeam])
				
			ply:SetAuthorised(true)
			ply:SetModel(randomModel)
			ply:SetPlayerTeam(randomTeam)
			ply:SetPlayerClass(randomClass)
			ply:KillSilent()

		end

		ply:SetCustomCollisionCheck(true)

		ply:AddPlayerMoney(ply:GetPlayerMoney() * 0 + 200)
		ply:AddPlayerKills(ply:GetPlayerKills() * 0)

		if ply:GetPlayerRank() == nil then 
				
			ply:SetPlayerRank({ rankName = 'Новобранец', experience = 0, icon = 'icon16/user.png' })
		
		else

			ply:SetPlayerRank(ply:GetPlayerRank())

		end

		ply:SetCanChangeTeam(true)

		if GAMEMODE.Config.adminsList[ply:SteamID()] then

			print('Игрок из списка перманентных админов! Выдаю админку...')
			ply:SetPlayerAsAdmin(true)

		end

		if ply:GetPlayerIsAdminRank() then

			ply:SetPlayerAsAdmin(true)

		end

		ply.TimeWhenDealDamage = -1
		ply.CanRespawnAfterDeathAfter = -1

	end)

end

function GM:PlayerSpawn(ply, bool)
		
	if ply:GetAuthorised() then

		ply:SetupHands()
		
		ply:SetHealth(100)
		ply:SetArmor(100)
		ply:SetAmmo(24, 'Pistol')
		ply:GodEnable()

		ply:SetColor(Color(255, 255, 255, 125))
		ply:SetRenderMode(RENDERMODE_TRANSCOLOR)

	end

	if GAMEMODE.Config.spawnPositions[ply:GetPlayerTeam()] then 
			
		ply:SetPos(GAMEMODE.Config.spawnPositions[ply:GetPlayerTeam()][math.random(1, #GAMEMODE.Config.spawnPositions)].pos)

	end

	for i = 1, #GAMEMODE.Config.playerClasses do

		if ply:GetPlayerClass() ~= GAMEMODE.Config.playerClasses[i].class then continue end

		ply:SetRunSpeed(GAMEMODE.Config.playerClasses[i].speedRun)
		ply:SetWalkSpeed(GAMEMODE.Config.playerClasses[i].speedWalk)

		for k,v in pairs(GAMEMODE.Config.playerClasses[i].weaponsOnSpawn) do

			ply:Give(v, false)
			
			if IsValid(ply:GetActiveWeapon()) and game.GetAmmoName(ply:GetActiveWeapon():GetPrimaryAmmoType()) ~= nil then
				
				ply:SetAmmo(GAMEMODE.Config.maxAmmoCanTake, game.GetAmmoName(ply:GetActiveWeapon():GetPrimaryAmmoType()))

			end

		end

	end

	if timer.Exists('BabyGodTime_' .. ply:SteamID()) then timer.Remove('BabyGodTime_' .. ply:SteamID()) end

	timer.Create('BabyGodTime_' .. ply:SteamID(), 3, 1, function()

		if not IsValid(ply) or ply:Health() <= 0 then return end

		ply:GodDisable()

		ply:SetColor(Color(255, 255, 255, 255))

	end)

end

function GM:ShouldCollide(ent1, ent2)

	if ent1:IsPlayer() and ent2:IsPlayer() then
    	
    	if not ent1:GetAuthorised() or not ent2:GetAuthorised() then return false end
	    if ent1:getExtendedNoClip() or ent2:getExtendedNoClip() then return false end
	    if ent1:GetPlayerIsAdmin() or ent2:GetPlayerIsAdmin() then return false end
	    if ent1:GetPlayerTeam() == ent2:GetPlayerTeam() then return false end

	end

	if ent1:IsNPC() and ent2:IsPlayer() then

		if ent1:GetIsDefender() then

			if ent1:GetNPCDefenderTeam() == ent2:GetPlayerTeam() then

				return false

			end

		end

	end

	if ent2:IsNPC() and ent1:IsPlayer() then

		if ent2:GetIsDefender() then

			if ent2:GetNPCDefenderTeam() == ent1:GetPlayerTeam() then

				return false

			end

		end

	end

	return true

end

function GM:DoPlayerDeath(ply, gun, killer)

	local crate_weapons = {}

	for k,v in pairs(ply:GetWeapons()) do

		if GAMEMODE.Config.dontDropAfterDeath[v:GetClass()] then continue end

		crate_weapons[#crate_weapons + 1] = { class = v:GetClass() }

	end

	if #crate_weapons > 0 then

		local crate = ents.Create("lootcrate")
		crate:SetPos(ply:GetPos())	
		crate:SetNWString('Owner', ply:Nick())
		crate:Spawn()

		crate:SetLoot(crate_weapons)

	end

	crate_weapons = {}

	ply:CallDeathScreen()
	ply:Lock()

end

function GM:PlayerDeath(victim, inflictor, attacker)

	local deathSound = table.Random({ 'vo/npc/male01/pain07.wav', 'vo/npc/male01/pain09.wav', 'vo/npc/male01/pain05.wav' })

	victim:EmitSound(deathSound, 75, 100, 0.75)
	victim:AddPlayerMoney(-100)
	victim:SetFrags(0)

	if IsValid(victim:GetRagdollEntity()) then
		
		victim:GetRagdollEntity():Remove()

	end

	if victim:GetAuthorised() then
	
		if IsValid(victim.ragdoll) then victim.ragdoll:Remove() end

		victim.ragdoll = ents.Create("prop_ragdoll")
		victim.ragdoll:SetPos(victim:GetPos())
		victim.ragdoll:SetModel(victim:GetModel())
		victim.ragdoll:SetColor(victim:GetColor())
		victim.ragdoll:SetSkin(victim:GetSkin())
		victim.ragdoll:Spawn()

		victim.ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)

		if timer.Exists('RagdollDelete_' .. victim:SteamID()) then timer.Remove('RagdollDelete_' .. victim:SteamID()) end

		timer.Create('RagdollDelete_' .. victim:SteamID(), 60, 1, function()

			if not IsValid(victim.ragdoll) then return end
			
			victim.ragdoll:Remove()

		end)

	end
        
    if victim:IsPlayer() and attacker:IsPlayer() then

    	if attacker:SteamID() ~= victim:SteamID() then

    		if CanContinueMatch() then
	    	
		    	attacker:AddPlayerMoney(100)
		    	attacker:AddPlayerExperience(50)
		    	attacker:AddPlayerKills(1)
		    	attacker:AddFrags(1)
		    	victim:AddDeaths(1)

		    	AddScoreTeam(attacker:GetPlayerTeam(), 5)

		    	attacker:SendPlayerNotification('Вы убили ' .. victim:Nick() .. ' и получили: 100$ и 50 EXP', 'garrysmod/balloon_pop_cute.wav')
	    		victim:SendPlayerNotification('Вы погибли от ' .. attacker:Nick() .. ' и потеряли: 100$', 'garrysmod/balloon_pop_cute.wav')

		    end

	    	SendPlayerDeathNotification(utf8.sub(attacker:Nick(), 0, 15) .. ' убил ' .. utf8.sub(victim:Nick(), 0, 15))

	    end

    elseif victim:IsPlayer() and attacker:IsNPC() then

    	if CanContinueMatch() then

	    	victim:SendPlayerNotification('Вы погибли от NPC и потеряли: 100$', 'garrysmod/balloon_pop_cute.wav')
	    	victim:AddDeaths(1)

	    end

    	SendPlayerDeathNotification(utf8.sub(victim:Nick(), 0, 15) .. ' погиб от NPC')

    end

end

function GM:PlayerSwitchWeapon(ply, oldWeapon, newWeapon)

	local ply_steamid = ply:SteamID()

	if timer.Exists('CanTakeWeapon_' .. ply_steamid) then timer.Remove('CanTakeWeapon_' .. ply_steamid) end

	ply:DrawViewModel(true)
	ply:DrawWorldModel(true)
	
	timer.Create('CanTakeWeapon_' .. ply_steamid, 0, 0, function()

		local ply_wep = ply:GetActiveWeapon()

		if IsValid(ply_wep) then

			local curtime = CurTime()
			local ply_wep_valid = ply_wep:CanBeTakedInArms()

			if not ply_wep_valid then
				
				ply_wep:SetNextPrimaryFire(curtime + 1)
				ply_wep:SetNextSecondaryFire(curtime + 1)

				ply:DrawViewModel(false)
				ply:DrawWorldModel(false)

				ply_wep:SetHoldType('normal')

			end

		end

	end)

end

function GM:PlayerButtonDown(ply, button)
	
	if button == 17 then

		ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_GIVE)
		ply:DropWeapon()

	end

	if button == 15 then

		if ply:GetPlayerIsAdminRank() and ply:GetPlayerSpectator() then

			ply:SetPlayerSpectator(false)

		end

	end

end

function GM:PlayerNoClip(ply, state)

	if state then

		timer.Simple(0.1, function()

			if ply:GetMoveType() == MOVETYPE_NOCLIP then
		
				ply:extendedNoClip(true)

			end

		end)

	else

		timer.Simple(0.1, function()
				
			ply:extendedNoClip(false)

		end)

	end

	return ply:GetPlayerIsAdminRank()

end

function GM:DoAnimationEvent(ply, event, data)
	
	if event == PLAYERANIMEVENT_RELOAD then

		ply:EmitSound('vo/npc/male01/youdbetterreload01.wav', 75, 100, 0.75)

		return ACT_INVALID

	end

end

function GM:ScalePlayerDamage(ply, hitgroup, dmg)

	if not GAMEMODE.Config.hitboxDamage[hitgroup] then return end
	if GAMEMODE.Config.hitboxDamage[hitgroup].scale then dmg:SetDamage(dmg:GetDamage() * GAMEMODE.Config.hitboxDamage[hitgroup].scaleInt) end
	if GAMEMODE.Config.hitboxDamage[hitgroup].static then 

		if GAMEMODE.Config.hitboxDamage[hitgroup].staticInt >= dmg:GetDamage() then
			
			dmg:SetDamage(GAMEMODE.Config.hitboxDamage[hitgroup].staticInt) 

		end

	end

	dmg:SetDamageCustom(000000000)

	if hitgroup == HITGROUP_HEAD then 

		dmg:SetDamageCustom(111111111)

	end

	if hitgroup == HITGROUP_CHEST then

		dmg:SetDamageCustom(111111112)

	end

	if hitgroup == HITGROUP_STOMACH then

		dmg:SetDamageCustom(111111113)

	end

	if hitgroup == HITGROUP_LEFTARM then

		dmg:SetDamageCustom(111111114)

	end

	if hitgroup == HITGROUP_RIGHTARM then

		dmg:SetDamageCustom(111111115)

	end

	if hitgroup == HITGROUP_LEFTLEG then

		dmg:SetDamageCustom(111111116)

	end

	if hitgroup == HITGROUP_RIGHTLEG then

		dmg:SetDamageCustom(111111117)

	end

end