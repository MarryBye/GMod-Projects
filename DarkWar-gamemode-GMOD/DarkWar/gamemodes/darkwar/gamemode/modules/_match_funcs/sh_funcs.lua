function GetScoreTeam(team)

	GetConVar(team):GetInt()

end

function GetMatchFinal()

	return GetConVar(GAMEMODE.Config.firstTeamName):GetInt() >= GAMEMODE.Config.winPoints or GetConVar(GAMEMODE.Config.secondTeamName):GetInt() >= GAMEMODE.Config.winPoints

end

function GetMatchWinner()

	local winner = 'None'

	if GetConVar(GAMEMODE.Config.firstTeamName):GetInt() >= GAMEMODE.Config.winPoints then winner = GAMEMODE.Config.firstTeamName end
	if GetConVar(GAMEMODE.Config.secondTeamName):GetInt() >= GAMEMODE.Config.winPoints then winner = GAMEMODE.Config.secondTeamName end
	
	return winner

end

function GetPlayersInTeam()

	local fTeam = 0
	local sTeam = 0

	for k,v in pairs(player.GetAll()) do

		if v:GetPlayerTeam() == GAMEMODE.Config.firstTeamName then fTeam = fTeam + 1 end
		if v:GetPlayerTeam() == GAMEMODE.Config.secondTeamName then sTeam = sTeam + 1 end

	end

	return fTeam, sTeam

end

function CanContinueMatch()

	local fT, sT = GetPlayersInTeam()

	if fT >= GAMEMODE.Config.needToStartPlayers and sT >= GAMEMODE.Config.needToStartPlayers then return true end

	return false

end