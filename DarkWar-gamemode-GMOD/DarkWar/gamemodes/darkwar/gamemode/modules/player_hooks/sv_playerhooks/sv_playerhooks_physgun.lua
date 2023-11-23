function GM:PhysgunPickup(ply, ent)

	return ply:GetPlayerIsAdminRank()

end

function GM:OnPhysgunReload(weapon, ply)

	return ply:GetPlayerIsAdminRank()

end