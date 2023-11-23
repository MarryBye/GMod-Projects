local pmeta = FindMetaTable('Player')

function pmeta:SetAuthorised(b)

	if not b then
			
		self:SetModel('models/player/skeleton.mdl')
		self:StripWeapons()

	end

	self.PlayerAuthorised = b
	self:SetNWBool('Aut', b)
	self:SetNWInt('Money', 0)
	self:SetNWInt('Kills', 0)

	self:SetNoDraw(not b)
	self:SetNoTarget(not b)
	self:Freeze(not b)
		
	if b then 
			
		self:GodDisable()

	else

		self:GodEnable()

	end

end

function pmeta:SetPlayerTeam(t)

	self.PlayerTeam = t
	self:SetNWString('Team', self.PlayerTeam)

end

function pmeta:SetPlayerClass(c)

	self.PlayerClass = c
	self:SetNWString('Class', self.PlayerClass)

end

function pmeta:AddPlayerMoney(m)

	if self.PlayerMoney == nil then self.PlayerMoney = 0 end
	
	self.PlayerMoney = self.PlayerMoney + m
	self:SetNWInt('Money', self.PlayerMoney)

end

function pmeta:AddPlayerKills(k)

	if self.PlayersKills == nil then self.PlayersKills = 0 end

	self.PlayersKills = self.PlayersKills + k
	self:SetNWInt('Kills', self.PlayersKills)

end

function pmeta:AddPlayerNPCKills(k)

	if self.PlayerNPCKills == nil then self.PlayerNPCKills = 0 end

	self.PlayerNPCKills = self.PlayerNPCKills + k
	self:SetNWInt('NPCKills', self.PlayerNPCKills)

end

function pmeta:SetPlayerSpectator(b)

	if b then 

		self.oldPlayerPosSpec = self:GetPos()
		self:Spectate(OBS_MODE_IN_EYE) 

	else 

		self:UnSpectate()
		self:SetPos(self.oldPlayerPosSpec)

	end

	self.SpectateModeActive = b 
	self:SetNWBool('spectateActive_' .. self:SteamID(), b)

end

function pmeta:SetPlayerDamagedOther(b)

	self.PlayerDamagedOther = b
	self:SetNWBool('DamageByPlyToPly_' .. self:SteamID(), b)

end

function pmeta:SetPlayerDead(b)

	self.PlayerIsDead = b
	self:SetNWBool('PlayerDead_' .. self:SteamID(), b)

end

function pmeta:SetCanChangeTeam(b)

	self.CanChangeTeam = b
	self:SetNWBool('CanChangeTeam', b)

end

function pmeta:CallDamageIndicator()

	if not self:GetPlayerDamagedOther() then

		self:SetPlayerDamagedOther(true)

	end

	self.TimeWhenDealDamage = CurTime() + 0.25

end

function pmeta:CallDeathScreen()

	if not self:GetPlayerDead() then

		self:SetPlayerDead(true)

	end

	self.CanRespawnAfterDeathAfter = CurTime() + 5

end

function pmeta:AddPlayerExperience(exp)

	local playerRank = self:GetPlayerRank()

	playerRank.experience = playerRank.experience + exp

	if GAMEMODE.Config.playerRanks[playerRank.experience] then 

		playerRank.rankName = GAMEMODE.Config.playerRanks[playerRank.experience].rankName
		playerRank.icon = GAMEMODE.Config.playerRanks[playerRank.experience].icon

	end

	if self:GetNWString('CL_RankName') == nil or self:GetNWString('CL_RankName') ~= playerRank.rankName then

		self:SetNWString('CL_RankName', playerRank.rankName)

	end

	if self:GetNWInt('CL_RankExperience') == nil or self:GetNWInt('CL_RankExperience') ~= playerRank.experience then

		self:SetNWInt('CL_RankExperience', playerRank.experience)

	end

	if self:GetNWString('CL_RankIcon') == nil or self:GetNWString('CL_RankIcon') ~= playerRank.icon then

		self:SetNWString('CL_RankIcon', playerRank.icon)

	end

	self:SetPData('PlayerRank', util.TableToJSON(playerRank))

end

function pmeta:SetPlayerRank(tbl)

	self:SetPData('PlayerRank', util.TableToJSON(table.Copy(tbl)))

	local playerRank = self:GetPlayerRank()

	if self:GetNWString('CL_RankName') == nil or self:GetNWString('CL_RankName') ~= playerRank.rankName then

		self:SetNWString('CL_RankName', playerRank.rankName)

	end

	if self:GetNWInt('CL_RankExperience') == nil or self:GetNWInt('CL_RankExperience') ~= playerRank.experience then

		self:SetNWInt('CL_RankExperience', playerRank.experience)

	end

	if self:GetNWString('CL_RankIcon') == nil or self:GetNWString('CL_RankIcon') ~= playerRank.icon then

		self:SetNWString('CL_RankIcon', playerRank.icon)

	end

end

function pmeta:SetPlayerAsAdmin(b)

	if not isbool(b) then print('Неверно введено значение bool! ( ' .. tostring(b) .. ' )') return end

	self:SetPData('IsCustomAdmin', b)
	self:SetNWBool('IsCustomAdmin', b)

	print(self:Nick() .. ' установлен статус администратора на ' .. tostring(b))

end

function pmeta:extendedNoClip(b)

	self.extendedNoClipState = b
	self:SetNWBool('ExtendedNoClip', b)

	if not self:GetPlayerIsAdmin() then 
					
		self:SetNoDraw(b)
			
		if not b then 
				
			self:GodDisable()

		else

			self:GodEnable()

		end

		self:SetNoTarget(b)

	end

	for k,v in pairs(self:GetWeapons()) do

		if not b then
						
			v:SetRenderMode(0)
			v:Fire("alpha", 255, 0)
			v:SetMaterial("")

		else

			v:SetRenderMode(1)
			v:Fire("alpha", 0, 0)
			v:SetMaterial("")

		end

	end

end

function pmeta:SendPlayerNotification(text, soundShow)

	net.Start('NotificattionsNet')

		net.WriteString(text)
		net.WriteString(soundShow)

	net.Send(self)

end

function SendPlayerNotificationForAll(text, soundShow)

	for k,v in pairs(player.GetAll()) do

		net.Start('NotificattionsNet')

			net.WriteString(text)
			net.WriteString(soundShow)

		net.Send(v)

	end

end

function SendPlayerDeathNotification(text)

	for k,v in pairs(player.GetAll()) do

		net.Start('NotificattionsDeathNet')

			net.WriteString(text)

		net.Send(v)

	end

end