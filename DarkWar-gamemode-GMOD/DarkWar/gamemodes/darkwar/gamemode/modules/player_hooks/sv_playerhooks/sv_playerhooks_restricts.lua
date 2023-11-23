function GM:PlayerSetModel(ply)

	return false

end

function GM:CanPlayerSuicide()

	return false

end

function GM:PlayerDeathSound()

	return false

end

function GM:PlayerSpawnProp(ply, model)

	return ply:GetPlayerIsAdminRank()

end

function GM:PlayerSpawnEffect(ply, model)

	return ply:GetPlayerIsAdminRank()

end

function GM:PlayerSpawnNPC(ply, npc, wep)

	return ply:GetPlayerIsAdminRank()

end

function GM:PlayerSpawnRagdoll(ply, model)

	return ply:GetPlayerIsAdminRank()

end

function GM:PlayerSpawnSENT(ply, class)

	return ply:GetPlayerIsAdminRank()

end

function GM:PlayerSpawnSWEP(ply, wep, tblWep)

	return ply:GetPlayerIsAdminRank()

end

function GM:PlayerSpawnVehicle(ply, model, name, tbl)

	return ply:GetPlayerIsAdminRank()

end

function GM:PlayerGiveSWEP(ply, wep, tbl)

	return ply:GetPlayerIsAdminRank()

end

function GM:CanProperty(ply, property, ent)
	
	return ply:GetPlayerIsAdminRank()

end

function GM:CanTool(ply, tr, toolname, tool, button)

    return ply:GetPlayerIsAdminRank()

end