local boneNamesByCustomID = {

	[111111111] = 'Голова',
	[111111112] = 'Тело',
	[111111113] = 'Живот',
	[111111114] = 'Левая рука',
	[111111115] = 'Правая рука',
	[111111116] = 'Левая нога',
	[111111117] = 'Правая нога',
	[000000000] = 'НЕИЗВЕСТНАЯ КОСТЬ'

}

function GM:PostGamemodeLoaded()

	local tabuTable = {

		['player_manager'] = true,
		['scene_manager'] = true,
		['beam'] = true,
		['bodyque'] = true,
		['gmod_gamerules'] = true,
		['network'] = true,
		['soundent'] = true,
		['spotlight_end'] = true,
		['predicted_viewmodel'] = true,
		['gmod_hands'] = true,
		['prop_door_rotating'] = true

	}

	timer.Create('FreezeProps', GAMEMODE.Config.propsFreezeTime, 0, function()

		print('[PropFreezer] Делаю заморозку всех пропов и энтити на карте!')

		for k,v in pairs(ents.GetAll()) do 

			if not IsValid(v) then continue end
			if v:IsPlayer() then continue end
			if v:IsNPC() then continue end
			if v:IsWeapon() then continue end
			if tabuTable[v:GetClass()] then continue end
			if v:GetVelocity() ~= Vector(0, 0, 0) then continue end

			v:PhysicsDestroy() 

		end

	end)

	timer.Create('NPCWorldSpawnDespawn', GAMEMODE.Config.npcSpawnTime, 0, function()

		if not CanContinueMatch() then return end

		SendPlayerNotificationForAll('Только что произошел респавн NPC!', 'garrysmod/content_downloaded.wav')

		for k,v in pairs(ents.FindByClass("npc_zombie")) do
			
			v:Remove()
		
		end

		for i = 1, #GAMEMODE.Config.npcSpawnPositions do

			local npc = ents.Create("npc_zombie")
			npc:SetPos(GAMEMODE.Config.npcSpawnPositions[i].pos)
			npc:SetKeyValue("spawnflags", bit.bor(SF_NPC_NO_WEAPON_DROP))
			npc:Spawn()

		end

	end)

	timer.Create('AirdropSpawn', GAMEMODE.Config.planeSpawnTime, 0, function()

		if not CanContinueMatch() then return end

		if IsValid(planeairdrop) then planeairdrop:Remove() end
		if IsValid(airdrop) then airdrop:Remove() end

		planeairdrop = ents.Create( "airdropplane" )
		planeairdrop:SetModel( "models/xqm/jetbody3_s2.mdl" )
		planeairdrop:SetPos(GAMEMODE.Config.planeVector)
		planeairdrop:SetAngles(GAMEMODE.Config.planeAngle)
		planeairdrop:Spawn()
		
		timer.Create('posChange', 0.1, 1000, function()

			if not IsValid(planeairdrop) then timer.Remove('posChange') return end
			
			planeairdrop:SetPos(Vector(planeairdrop:GetPos().x + GAMEMODE.Config.planeVectorTo.zS, planeairdrop:GetPos().y + GAMEMODE.Config.planeVectorTo.yS, planeairdrop:GetPos().z + GAMEMODE.Config.planeVectorTo.zS))

		end)

		if timer.RepsLeft('posChange') == 0 then

			planeairdrop:Remove()

		end

		timer.Create('DropAirdrop', GAMEMODE.Config.airdropAfterPlaneDropTime, 1, function()

			if not IsValid(planeairdrop) then timer.Remove('DropAirdrop') return end

			SendPlayerNotificationForAll('Только что упал Airdrop! Спеши на точку.', 'garrysmod/content_downloaded.wav')

			airdrop = ents.Create("airdrop")
			airdrop:SetModel("models/Items/item_item_crate.mdl")
			airdrop:SetPos(Vector(planeairdrop:GetPos().x, planeairdrop:GetPos().y, planeairdrop:GetPos().z - 50))
			airdrop:Spawn()

			airdrop:SetLoot(table.Random(GAMEMODE.Config.airdropLoot))

		end)

	end)

end

function GM:EntityTakeDamage(trg, dmg)

	local att = dmg:GetAttacker()

	if att:IsPlayer() then

		if trg:IsPlayer() then

			if trg:GetPlayerTeam() ~= att:GetPlayerTeam() then 
			
				att:PrintMessage(HUD_PRINTCONSOLE, 'Вы попали в ' .. utf8.sub(trg:Nick(), 0, 15) .. ' нанеся ' .. math.floor(dmg:GetDamage()) .. ' урона в ' .. boneNamesByCustomID[dmg:GetDamageCustom()])
				att:CallDamageIndicator()

			end

		else

			if trg:IsNPC() then

				if trg:GetIsDefender() then

					if trg:GetNPCDefenderTeam() ~= att:GetPlayerTeam() then

						att:PrintMessage(HUD_PRINTCONSOLE, 'Вы попали в ' .. trg:GetClass() .. ' нанеся ' .. math.floor(dmg:GetDamage()) .. ' урона в ' .. boneNamesByCustomID[dmg:GetDamageCustom()])
						att:CallDamageIndicator()

					end

				elseif trg:Health() > 0 then

					att:PrintMessage(HUD_PRINTCONSOLE, 'Вы попали в ' .. trg:GetClass() .. ' нанеся ' .. math.floor(dmg:GetDamage()) .. ' урона в ' .. boneNamesByCustomID[dmg:GetDamageCustom()])
					att:CallDamageIndicator()

				end

			elseif trg.Hitpoints ~= nil then

				att:PrintMessage(HUD_PRINTCONSOLE, 'Вы попали в ' .. trg:GetClass() .. ' нанеся ' .. math.floor(dmg:GetDamage()) .. ' урона.')
				att:CallDamageIndicator()

			end
		
		end
		
	end

	if trg:IsPlayer() then

		if dmg:GetDamageCustom() == 111111111 then

			trg:EmitSound('vo/npc/male01/ow01.wav', 75, 100, 0.75)

			if trg:GetBoneMatrix(6) ~= nil then
					
				local pos = trg:GetBoneMatrix(6):GetTranslation()

				for i = 0, 360, 30 do
							
					ParticleEffect("blood_advisor_pierce_spray_c", pos, Angle( 0, i, 0 ), trg)

				end

				timer.Simple(0.25, function() trg:StopParticles() end)

			end

		end

		for i = 1, #GAMEMODE.Config.playerClasses do

			if GAMEMODE.Config.playerClasses[i].class ~= trg:GetPlayerClass() then continue end

			dmg:SetDamage((100 - GAMEMODE.Config.playerClasses[i].resist) * dmg:GetDamage() * 0.01)

			break

		end

		if att:IsPlayer() then 
			
			if trg:SteamID() == att:SteamID() then return end
			if trg:GetPlayerTeam() ~= att:GetPlayerTeam() then return end

	    	dmg:SetDamage(0)

	    	att:SendPlayerNotification('Не стреляйте по своим союзникам!', 'garrysmod/balloon_pop_cute.wav')

	    end

	    if att:IsNPC() then

	    	if not att:GetIsDefender() then return end
			if att:GetNPCDefenderTeam() ~= trg:GetPlayerTeam() then return end

			dmg:SetDamage(0)

	    end

	end

	if trg:IsNPC() then

		if not att:IsPlayer() then return end
		if not trg:GetIsDefender() then return end
		if trg:GetNPCDefenderTeam() ~= att:GetPlayerTeam() then return end

		dmg:SetDamage(0)

		att:SendPlayerNotification('Не стреляйте по своим союзникам!', 'garrysmod/balloon_pop_cute.wav')

	end

end

function GM:OnNPCKilled(npc, attacker, inflictor)

	if CanContinueMatch() then

		if attacker:IsPlayer() then

			attacker:AddPlayerMoney(25)
			attacker:AddPlayerExperience(10)
			attacker:AddPlayerNPCKills(1)

			attacker:SendPlayerNotification('Вы убили NPC и получили: 25$ и 10 EXP', 'garrysmod/balloon_pop_cute.wav')

		end

	end

end

function GM:ScaleNPCDamage(npc, hitgroup, dmg)
	
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