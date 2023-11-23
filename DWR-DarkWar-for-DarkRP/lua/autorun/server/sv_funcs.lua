include("autorun/sh_config.lua")
AddCSLuaFile("autorun/sh_config.lua")

util.AddNetworkString("spectate_wh")
util.AddNetworkString("unspectate_wh")
util.AddNetworkString("playSoundsUI")

_G.DarkWar.f_faction_kills = 0
_G.DarkWar.s_faction_kills = 0

local PMETA = FindMetaTable("Player")

function PMETA:GetPData(name, default)
	
	name = Format( "%s[%s]", self:SteamID64(), name)
	local val = sql.QueryValue("SELECT value FROM playerpdata WHERE infoid = "..SQLStr(name).." LIMIT 1")

	return val or default

end

function PMETA:SetPData(name, value)

	name = Format("%s[%s]", self:SteamID64(), name)

	return sql.Query("REPLACE INTO playerpdata (infoid, value) VALUES ("..SQLStr(name)..", "..SQLStr(value).." )") ~= false

end

function PMETA:RemovePData(name)

	name = Format("%s[%s]", self:SteamID64(), name)

	return sql.Query("DELETE FROM playerpdata WHERE infoid = "..SQLStr(name)) ~= false

end

function PMETA:rankLoad()

	if self:GetPData('Exp') == nil then
		
		self:SetPData('Exp', 0)
		self:SetNWInt('Exp', 0)

	else

		self:SetNWInt('Exp', self:GetPData('Exp'))

	end

	if self:GetPData('Rank') == nil then
		
		self:SetPData('Rank', CONFIG.player_ranks[1].name)
		self:SetNWString('Rank', CONFIG.player_ranks[1].name)

	else

		self:SetNWString('Rank', self:GetPData('Rank'))

	end

	if self:GetPData('NextExp') == nil then
		
		self:SetPData('NextExp', CONFIG.player_ranks[2].exp)
		self:SetNWInt('NextExp', CONFIG.player_ranks[2].exp)

	else

		self:SetNWInt('NextExp', self:GetPData('NextExp'))

	end

	if self:GetPData('NextRank') == nil then
		
		self:SetPData('NextRank', CONFIG.player_ranks[2].name)
		self:SetNWString('NextRank', CONFIG.player_ranks[2].name)

	else

		self:SetNWString('NextRank', self:GetPData('NextRank'))

	end

	if self:GetPData('Icon') == nil then
		
		self:SetPData('Icon', CONFIG.player_ranks[1].icon)
		self:SetNWString('Icon', CONFIG.player_ranks[1].icon)

	else

		self:SetNWString('Icon', self:GetPData('Icon'))

	end

	if self:GetPData('NextIcon') == nil then
		
		self:SetPData('NextIcon', CONFIG.player_ranks[2].icon)
		self:SetNWString('NextIcon', CONFIG.player_ranks[2].icon)

	else

		self:SetNWString('NextIcon', self:GetPData('NextIcon'))

	end

end

function PMETA:rankAdd(value)

	self:rankLoad()

	self:SetPData('Exp', self:GetPData('Exp') + value)
	self:SetNWInt('Exp', self:GetPData('Exp'))

	for i = 1, table.maxn(CONFIG.player_ranks) do
		if (i + 1) <= table.maxn(CONFIG.player_ranks) then
			if tonumber(self:GetNWInt('Exp')) >= CONFIG.player_ranks[i].exp and tonumber(self:GetNWInt('Exp')) < CONFIG.player_ranks[i + 1].exp then
				self:SetPData('Rank', CONFIG.player_ranks[i].name)
				self:SetPData('NextExp', CONFIG.player_ranks[i + 1].exp)
				self:SetPData('NextRank', CONFIG.player_ranks[i + 1].name)
				self:SetPData('Icon', CONFIG.player_ranks[i].icon)
				self:SetPData('NextIcon', CONFIG.player_ranks[i + 1].icon)
				self:SetNWString('Rank', self:GetPData('Rank'))
				self:SetNWInt('NextExp', self:GetPData('NextExp'))
				self:SetNWString('NextRank', self:GetPData('NextRank'))
				self:SetNWString('Icon', self:GetPData('Icon'))
				self:SetNWString('NextIcon', self:GetPData('NextIcon'))
			elseif tonumber(self:GetNWInt('Exp')) >= CONFIG.player_ranks[table.maxn(CONFIG.player_ranks)].exp then
				self:SetPData('Rank', CONFIG.player_ranks[table.maxn(CONFIG.player_ranks)].name)
				self:SetPData('NextExp', CONFIG.player_ranks[table.maxn(CONFIG.player_ranks)].exp)
				self:SetPData('NextRank', CONFIG.player_ranks[table.maxn(CONFIG.player_ranks)].name)
				self:SetPData('Icon', CONFIG.player_ranks[table.maxn(CONFIG.player_ranks)].icon)
				self:SetPData('NextIcon', CONFIG.player_ranks[table.maxn(CONFIG.player_ranks)].icon)
				self:SetNWString('Rank', self:GetPData('Rank'))
				self:SetNWInt('NextExp', self:GetPData('NextExp'))
				self:SetNWString('NextRank', self:GetPData('NextRank'))
				self:SetNWString('Icon', self:GetPData('Icon'))
				self:SetNWString('NextIcon', self:GetPData('NextIcon'))
			end
		else
			break
		end
	end

end

ents.InSquare = function(vCorner1, vCorner2)

	local tEntities = ents.FindInBox(vCorner1, vCorner2)
	local tNPC = {}
	local iNPC = 0
	
	for i = 1, #tEntities do
		
		if tEntities[i]:IsNPC() then

			iNPC = iNPC + 1
			tNPC[iNPC] = tNPC[i]
		
		end
	
	end
	
	return tNPC, iNPC

end

DarkWar.AntiKill = function(ply)
	
	return false

end

hook.Add("CanPlayerSuicide", "AntiKill", DarkWar.AntiKill)

DarkWar.MuteDeath = function()

	return true

end

hook.Add("PlayerDeathSound", "MuteDeath", DarkWar.MuteDeath)

DarkWar.OffCrosshair = function(ply)

	timer.Simple(0.1, function()
		
		ply:CrosshairDisable()
	
	end)

end

hook.Add("PlayerLoadout", "OffCrosshair", DarkWar.OffCrosshair)

DarkWar.Ramming = function(ply, tr, ent)

	if CONFIG.can_ram_props then
		
		if ent:GetClass() == "prop_physics" and ent:CPPIGetOwner() != nil and ent:CPPIGetOwner().warranted then
			
			ent:Remove()
			return true
		
		else
			
			return false
		
		end
	
	end

end

hook.Add("canDoorRam", "Ramming", DarkWar.Ramming)

DarkWar.Limits = function(ply)

	if ply:Health() > 100 then
		
		ply:SetHealth(100)
	
	end
	
	if ply:Armor() > 100 then
		
		ply:SetArmor(100)
	
	end
	
	if ply:Health() > 0 and IsValid(ply:GetActiveWeapon()) then
		
		for i = 1, table.maxn(CONFIG.spawn_ammo) do
			
			if ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType()) > CONFIG.spawn_ammo[i].cnt then
				
				if ply:GetActiveWeapon():GetPrimaryAmmoType() == CONFIG.spawn_ammo[i].type then
					
					ply:SetAmmo(CONFIG.spawn_ammo[i].cnt, CONFIG.spawn_ammo[i].type)
				
				end
			
			end
		
		end
	
	end
	
	if ply:getDarkRPVar("money") < 0 then
		
		ply:addMoney(ply:getDarkRPVar("money") * (-1))
	
	end

end

hook.Add("PlayerPostThink", "Limits", DarkWar.Limits)

DarkWar.Giver = function(ply)

	for i = 1, table.maxn(CONFIG.spawn_ammo) do

		ply:SetAmmo(CONFIG.spawn_ammo[i].cnt, CONFIG.spawn_ammo[i].type)

	end
	
	if CONFIG.job_access[ply:Team()] then

		if CONFIG.job_access[ply:Team()].phys then

			ply:Give("weapon_physgun")

		end

	end

	if CONFIG.job_access[ply:Team()] then

		if CONFIG.job_access[ply:Team()].tool then

			ply:Give("gmod_tool")

		end

	end

end

hook.Add("PlayerLoadout", "Giver", DarkWar.Giver)

DarkWar.ResistTeam = function(trg, dmg)

	local att = dmg:GetAttacker()
    
    if trg:IsPlayer() and att:IsPlayer() then

    	if not (att:SteamID() == trg:SteamID()) then 

    		if trg:getJobTable()["category"] == att:getJobTable()["category"] then

        		dmg:SetDamage(CONFIG.team_fire_dmg)
        		DarkRP.notify(att, 1, 1, "Стрельба по своим запрещена!")

        	end
    	
    	end
    
    end
	
	if trg:IsPlayer() then

		if CONFIG.job_viewers[trg:Team()] then

			if att:IsPlayer() then

	        	dmg:SetDamage(0)
	        	DarkRP.notify(att, 1, 1, "Стрельба по наблюдателям запрещена!")

	        else

				dmg:SetDamage(0)

			end

    	end

    end

    if att:IsPlayer() then
    	
    	if CONFIG.job_viewers[att:Team()] then

    		if trg:IsNPC() then 

				dmg:SetDamage(0)

	        elseif trg:IsPlayer() then

	        	dmg:SetDamage(0)
	        	DarkRP.notify(att, 1, 1, "Наблюдателям запрещено наносить урон!")

	        end

    	end
	
	end

end

hook.Add("EntityTakeDamage", "ResistTeam", DarkWar.ResistTeam)

DarkWar.Resist = function(trg, dmg)

	local att = dmg:GetAttacker()
    
    if trg:IsNPC() and att:IsPlayer() then

    	dmg:SetDamage((dmg:GetDamage() * (100 - CONFIG.npc_resist)) / 100)

	elseif trg:IsPlayer() and att:IsPlayer() then

		if CONFIG.job_resists[trg:Team()] then

			if CONFIG.job_resists[trg:Team()].check then

				dmg:SetDamage((dmg:GetDamage() * (100 - CONFIG.job_resists[trg:Team()].resist)) / 100)

			end
		
		end
	
	end

end

hook.Add("EntityTakeDamage", "Resist", DarkWar.Resist)

DarkWar.MoneyPriseNPC = function(trg, killer, inf)

	if trg:IsNPC() and killer:IsPlayer() then

		killer:addMoney(CONFIG.npc_kill_prise)
		DarkRP.notify(killer, 0, 3, "Вы убили NPC и получили " .. CONFIG.npc_kill_prise .. "$")
		killer:rankAdd(CONFIG.npc_kill_exp_prise)

	end

end

hook.Add("OnNPCKilled", "MoneyPriseNPC", DarkWar.MoneyPriseNPC)

DarkWar.DropMoneyNPC = function(ply, gun, killer)

	if killer:IsNPC() and ply:IsPlayer() then

		if ply:getDarkRPVar("money") > CONFIG.player_min_money then

			DarkRP.notify(ply, 0, 3, "Вы были убиты NPC и потеряли " .. CONFIG.npc_dead_lose .. "$")
			ply:addMoney(-CONFIG.npc_dead_lose)

		elseif ply:getDarkRPVar("money") <= CONFIG.player_min_money then

			DarkRP.notify(ply, 0, 3, "Вы были убиты NPC, но ничего не потеряли!")

		end
	
	end

end

hook.Add("PlayerDeath", "DropMoneyNPC", DarkWar.DropMoneyNPC)

DarkWar.MoneyPrisePlayer = function(ply, gun, killer)

	local MoneyAdd = CONFIG.player_kill_prise
	ply:SetFrags(0)
	
	if ply:IsPlayer() and killer:IsPlayer() then
		
		if not (ply:Team() == killer:Team()) then
			
			if ply:getDarkRPVar("money") > CONFIG.player_min_money then
				
				ply:addMoney(-MoneyAdd)
				killer:addMoney(MoneyAdd)
				DarkRP.notify(killer, 0, 3, "Вы убили " .. ply:Nick() .. " и получили " .. MoneyAdd .. "$")
				DarkRP.notify(ply, 0, 3, "Вы были убиты " .. killer:Nick() .. " и потеряли " .. MoneyAdd .. "$")
			
			elseif ply:getDarkRPVar("money") <= CONFIG.player_min_money then
				
				DarkRP.notify(killer, 0, 3, "Вы убили " .. ply:Nick() .. ", но ничего не получили!")
				DarkRP.notify(ply, 0, 3, "Вы были убиты " .. killer:Nick() .. ", но ничего не потеряли!")
			
			end
		
		end
	
	end

end

hook.Add("PlayerDeath", "MoneyPrisePlayer", DarkWar.MoneyPrisePlayer)

DarkWar.ArrestMoneyPrise = function(ply, time, arrester)

	local MoneyAddCop = CONFIG.player_arrest_prise
	ply:SetFrags(0)
	
	if ply:IsPlayer() and arrester:IsPlayer() then
		
		if not (ply:Team() == arrester:Team()) then
			
			if ply:getDarkRPVar("money") > CONFIG.player_min_money then
				
				ply:addMoney(-MoneyAddCop)
				arrester:addMoney(MoneyAddCop)
				DarkRP.notify(arrester, 0, 3, "Вы посадили " .. ply:Nick() .. " и получили " .. MoneyAddCop .. "$")
				DarkRP.notify(ply, 0, 3, "Вас посадил " .. arrester:Nick() .. " и вы потеряли " .. MoneyAddCop .. "$")
			
			elseif ply:getDarkRPVar("money") <= CONFIG.player_min_money then
				
				DarkRP.notify(arrester, 0, 3, "Вы посадили " .. ply:Nick() .. ", но ничего не получили!")
				DarkRP.notify(ply, 0, 3, "Вас посадил " .. arrester:Nick() .. ", но вы ничего не потеряли!")
			
			end
		
		end
	
	end

end

DarkWar.Kills = function(ply, gun, killer)
	
	if ply:IsPlayer() and killer:IsPlayer() then
		
		if not (ply:Team() == killer:Team()) then

			killer.kills = killer.kills + 1
			killer:SetNWInt('kills_dwr', killer.kills)
			killer:rankAdd(CONFIG.player_kill_exp_prise)

			if killer:getJobTable()['category'] == CONFIG.f_faction then
							
				DarkWar.f_faction_kills = DarkWar.f_faction_kills + 1
				
				for k,v in pairs(player.GetAll()) do 

					v:SetNWInt(CONFIG.f_faction, DarkWar.f_faction_kills)
				
				end

			end

			if killer:getJobTable()['category'] == CONFIG.s_faction then
						
				DarkWar.s_faction_kills = DarkWar.s_faction_kills + 1
				
				for k,v in pairs(player.GetAll()) do 

					v:SetNWInt(CONFIG.s_faction, DarkWar.s_faction_kills)
				
				end

			end

		end

	end

end

hook.Add('PlayerDeath', 'Kills', DarkWar.Kills)

hook.Add("playerArrested", "ArrestMoneyPrise", DarkWar.ArrestMoneyPrise)

DarkWar.NPCSpawn = function(ply)

	if ply:SteamID() == "STEAM_0:1:527419720" then

		timer.Create("Spawn", CONFIG.npc_spawn_delay, 0, function()

			for k,v in pairs(player.GetAll()) do

				v:ChatPrint("Были заспавнены новые NPC!")
				
				for k,v in pairs(ents.FindByClass("npc_*")) do

					v:Remove()
				
				end
			
			end
			
			for i = 1, table.maxn(CONFIG.enemy_npc_pos) do

				local npc = ents.Create(table.Random(CONFIG.enemy_npcs))

				if (!IsValid(npc)) then 
					return 
				end 

				npc:SetPos(CONFIG.enemy_npc_pos[i])
				npc:SetKeyValue("spawnflags", bit.bor(SF_NPC_NO_WEAPON_DROP))
				npc:Spawn()
			
			end
		
		end)
	
	end

end

hook.Add("PlayerInitialSpawn", "NPCSpawn", DarkWar.NPCSpawn)

DarkWar.SpawnProp = function(ply, model)

	if CONFIG.job_access[ply:Team()] then

		if CONFIG.job_access[ply:Team()].prop_spawn then

			return true

		end
	
	else
		
		return false
	
	end

end

hook.Add("PlayerSpawnProp", "SpawnProp", DarkWar.SpawnProp)

DarkWar.SpawnRagdoll = function(ply, gun, killer)

	if not CONFIG.spawn_ragdoll then return end

	ply:GetRagdollEntity():Remove()

	local ragdoll = ents.Create("prop_ragdoll")
	ragdoll:SetPos(ply:GetPos())
	ragdoll:SetModel(ply:GetModel())
	ragdoll:SetColor(ply:GetColor())
	ragdoll:SetSkin(ply:GetSkin())
	ragdoll:Spawn()

	ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	timer.Simple(CONFIG.ragdoll_life_time, function()

		ragdoll:Remove()

	end)

end

hook.Add("PlayerDeath", "SpawnRagdoll", DarkWar.SpawnRagdoll)

DarkWar.DropWeaponAfterDeath = function(ply, gun, killer)
			
	if not CONFIG.drop_weapons then return end

	crate_weapons = {}
	crate_owner = ply:Name()

	local crate = ents.Create("lootcrate")
	crate:SetPos(ply:GetPos())	

	for k,v in pairs(ply:GetWeapons()) do

		if CONFIG.dont_drop_after_death[v:GetClass()] then continue end

		table.insert(crate_weapons, v:GetClass())

	end

	crate:Spawn()
	crate:SetColor(ply:getJobTable()['color'])

end

hook.Add('DoPlayerDeath', 'DropWeaponAfterDeath', DarkWar.DropWeaponAfterDeath)

DarkWar.Loader = function(ply)
	
	timer.Simple(0.1, function()

		ply:rankLoad()
		
		ply:SetNWInt(CONFIG.f_faction, DarkWar.f_faction_kills)
		ply:SetNWInt(CONFIG.s_faction, DarkWar.s_faction_kills)

		ply.kills = 0

		ply:addMoney((ply:getDarkRPVar("money") * (-1)) + CONFIG.start_money)

		ply:SetCanZoom( false )
		ply:SetNWBool('canUseY', true)
		ply:SetNWBool('canUseT', true)

		net.Start('playSoundsUI')
		net.Send(ply)

	end)

end

hook.Add('PlayerInitialSpawn', 'Loader', DarkWar.Loader)

DarkWar.Checker = function()

	if DarkWar.f_faction_kills >= CONFIG.win_goal or DarkWar.s_faction_kills >= CONFIG.win_goal then
					
		if DarkWar.f_faction_kills >= CONFIG.win_goal then
						
			for k,v in pairs(player.GetAll()) do
				
				if v:getJobTable()['category'] == CONFIG.f_faction then
								
					v:addMoney((v:getDarkRPVar("money") * (-1)) + CONFIG.win_money)
					DarkRP.notify(v, 0, 3, 'Ваша команда [' .. CONFIG.f_faction .. '] выиграла раунд и получила ' .. CONFIG.win_money .. '$')
							
				else

					DarkRP.notify(v, 0, 3, 'Ваша команда [' .. CONFIG.s_faction .. '] програла!')
					v:addMoney((v:getDarkRPVar("money") * (-1)) + CONFIG.start_money)

				end

			end

		end

		if DarkWar.s_faction_kills >= CONFIG.win_goal then
						
			for k,v in pairs(player.GetAll()) do
				
				if v:getJobTable()['category'] == CONFIG.s_faction then
								
					v:addMoney((v:getDarkRPVar("money") * (-1)) + CONFIG.win_money)
					DarkRP.notify(v, 0, 3, 'Ваша команда [' .. CONFIG.s_faction .. '] выиграла раунд и получила ' .. CONFIG.win_money .. '$')
					v:rankAdd(CONFIG.win_exp)
							
				else

					DarkRP.notify(v, 0, 3, 'Ваша команда [' .. CONFIG.f_faction .. '] програла!')
					v:addMoney((v:getDarkRPVar("money") * (-1)) + CONFIG.start_money)

				end

			end

		end

		for k,allPly in pairs(player.GetAll()) do
						
			DarkWar.f_faction_kills = 0
			DarkWar.s_faction_kills = 0

			allPly:SetNWInt(CONFIG.f_faction, DarkWar.f_faction_kills)
			allPly:SetNWInt(CONFIG.s_faction, DarkWar.s_faction_kills)

			if not CONFIG.job_viewers[allPly:Team()] then 
						
				allPly:changeTeam(CONFIG.win_team, true, true)
				allPly:Kill()

			end
					
		end

		for k,ent in pairs(ents.FindByClass('battlepoint')) do

			ent:SetNWString('pointTeam', 'No team')
			ent:SetNWBool('captureActive', false)
			ent:SetNWInt('capture', -1)
			ent:SetNWInt('cooldown', -1)
			ent.teamCapture = 'No team'
			ent.battle = false
			ent.canCapture = false
			ent.SOCC = true

		end

	end

end

hook.Add('Think', 'Checker', DarkWar.Checker)

DarkWar.Spectate = function(spec, cmd, args)

	if not CONFIG.admins[spec:GetUserGroup()] then return MsgN("Нет доступа!") end

	local nick = args[1]
	nick = string.lower( nick )

	for k,v in pairs( player.GetAll() ) do
		
		if string.find( string.lower( v:Nick() ), nick ) then

			spec:Spectate(OBS_MODE_CHASE)
			spec:SpectateEntity(v)
			spec:StripWeapons()
			spec:CrosshairDisable()
			net.Start("spectate_wh")
			net.Send(spec)

		end
	
	end

end

concommand.Add("dwr_spec", DarkWar.Spectate)

DarkWar.PlayerBinds = function(ply, key)
	
	if key == IN_ZOOM and ply:GetNWBool('canUseY', true) then

		ply:SetNWBool('canUseY', false)
		ply:EmitSound(CONFIG.player_sounds[math.random(1,#CONFIG.player_sounds)])
		timer.Simple(2.5, function() ply:SetNWBool('canUseY', true) end)

	end

	if key == IN_ATTACK2 and ply:GetNWBool('canUseT', true) then

		if ply:GetEyeTrace().Entity:IsPlayer() then

			local Distance = ply:GetPos():Distance(ply:GetEyeTrace().Entity:GetPos())

			if ply:GetEyeTrace().Entity:getJobTable()['category'] == ply:getJobTable()['category'] and Distance <= 100 then

				ply:SetNWBool('canUseT', false)
				ply:GetEyeTrace().Entity:SetVelocity(ply:GetAngles():Forward() * 1000)
				ply:EmitSound('player/pl_pain7.wav')
				timer.Simple(3, function() ply:SetNWBool('canUseT', true) end)

			end

		end

	end

end

hook.Add( 'KeyPress', 'PlayerBinds', DarkWar.PlayerBinds)

DarkWar.UnSpectate = function(spec, cmd, args)

	spec:UnSpectate()
	spec:Spawn()
	net.Start("unspectate_wh")
	net.Send(spec)

end

concommand.Add("dwr_unspec", DarkWar.UnSpectate)

DarkWar.UnSpectate = function(spec, cmd, args)

	spec:UnSpectate()
	spec:Spawn()
	net.Start("unspectate_wh")
	net.Send(spec)

end

concommand.Add("dwr_unspec", DarkWar.UnSpectate)