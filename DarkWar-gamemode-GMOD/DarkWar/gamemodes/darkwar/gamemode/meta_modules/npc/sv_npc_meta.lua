local nmeta = FindMetaTable('NPC')

function nmeta:SetDefender(t)
	
	self.IsDefender = true
	self:SetNWBool('PointDefender', true)
	self.DefenderTeam = t
	self:SetNWString('DefenderTeam', t)

end