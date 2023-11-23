local pmeta = FindMetaTable('Player')

function pmeta:GetAuthorised()

	if SERVER then return self.PlayerAuthorised or false end
	if CLIENT then return self:GetNWBool('Aut', false) end

end

function pmeta:GetPlayerTeam()

	if SERVER then return self.PlayerTeam or 'None' end
	if CLIENT then return self:GetNWString('Team', 'None') end

end

function pmeta:GetPlayerClass()

	if SERVER then return self.PlayerClass or 'None' end
	if CLIENT then return self:GetNWString('Class', 'None') end

end

function pmeta:GetPlayerMoney()

	if SERVER then return self.PlayerMoney or 0 end
	if CLIENT then return self:GetNWInt('Money', 0) end

end

function pmeta:GetPlayerKills()
	
	if SERVER then return self.PlayersKills or 0 end
	if CLIENT then return self:GetNWInt('Kills', 0) end

end

function pmeta:GetPlayerNPCKills()

	if SERVER then return self.PlayerNPCKills or 0 end
	if CLIENT then return self:GetNWInt('NPCKills', 0) end

end

function pmeta:GetPlayerSpectator()

	if SERVER then return self.SpectateModeActive or false end
	if CLIENT then return self:GetNWBool('spectateActive_' .. self:SteamID(), false) end

end

function pmeta:GetPlayerDamagedOther()

	if SERVER then return self.PlayerDamagedOther or false end
	if CLIENT then return self:GetNWBool('DamageByPlyToPly_' .. self:SteamID(), false) end

end

function pmeta:GetPlayerDead()

	if SERVER then return self.PlayerIsDead or false end 
	if CLIENT then return self:GetNWBool('PlayerDead_' .. self:SteamID(), false) end

end

function pmeta:CanChangeTeam()

	if SERVER then return self.CanChangeTeam or false end
	if CLIENT then return self:GetNWBool('CanChangeTeam', false) end

end

function pmeta:GetPlayerRank()

	if SERVER then return util.JSONToTable(self:GetPData('PlayerRank')) end
	if CLIENT then return { rankName = self:GetNWString('CL_RankName'), experience = self:GetNWInt('CL_RankExperience'), icon = self:GetNWString('CL_RankIcon') } end

end

function pmeta:GetPlayerKD()

	return math.min(math.Round(self:GetPlayerKills() / self:Deaths(), 1), self:GetPlayerKills())

end

function pmeta:getExtendedNoClip()
	
	if SERVER then return self.extendedNoClipState end
	if CLIENT then return self:GetNWBool('ExtendedNoClip', false) end

end

function pmeta:GetPlayerIsAdmin()

	return self:GetPlayerTeam() == GAMEMODE.Config.adminTeamName or self:GetPlayerClass() == GAMEMODE.Config.adminTeamName

end

function pmeta:GetPlayerIsAdminRank()

	if CLIENT then return self:GetNWBool('IsCustomAdmin', false) end
	if SERVER then return tobool(self:GetPData('IsCustomAdmin')) or false end

end

function pmeta:GetSeqWepTable()

	self.plyWepTblValid = {}
	
	for _,v in ipairs(self:GetWeapons()) do

		self.plyWepTblValid[#self.plyWepTblValid + 1] = { class = v:GetClass(), name = v:GetPrintName() }

	end

	return self.plyWepTblValid

end