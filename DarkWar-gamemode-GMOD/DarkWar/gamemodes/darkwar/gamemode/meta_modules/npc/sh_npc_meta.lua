local nmeta = FindMetaTable('NPC')

function nmeta:GetIsDefender()
	
	if SERVER then return self.IsDefender or false end
	if CLIENT then return self:GetNWBool('PointDefender', false) end

end

function nmeta:GetNPCDefenderTeam()	
	
	if SERVER then return self.DefenderTeam or 'None' end
	if CLIENT then return self:GetNWString('DefenderTeam', 'None') end

end