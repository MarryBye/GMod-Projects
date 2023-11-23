function AddScoreTeam(team, score)

	if GetConVar(team) == nil then return end
	if GetConVar(team):GetInt() == nil then return end

	GetConVar(team):SetInt(GetConVar(team):GetInt() + score)

	if GetMatchFinal() then

		RoundRestart()

	end

end

function RoundRestart()

	for k,v in pairs(player.GetAll()) do

		v:SendPlayerNotification('Раунд окончен! Победителем оказались: ' .. GetMatchWinner(), 'resource/warning.wav')

		v:Freeze(true)

		timer.Simple(5, function()

			v:Freeze(false)
					
			v:KillSilent()
			v:AddPlayerMoney(-v:GetPlayerMoney())
			v:AddPlayerKills(-v:GetPlayerKills())
			v:AddPlayerNPCKills(-v:GetPlayerNPCKills())
			v:SetDeaths(0)
			v:SetFrags(0)
			v:SetPlayerTeam('None')
			v:SetPlayerClass('None')
			v:Spawn()
			v:SetAuthorised(false)

			if timer.Exists('TeamChangeCooldown_' .. v:SteamID()) then timer.Remove('TeamChangeCooldown_' .. v:SteamID()) end
			v:SetNWBool('CanChangeTeam', true)
			v:SetNWBool('PlayerDead_' .. v:SteamID(), false)

			GetConVar(GAMEMODE.Config.firstTeamName):SetInt(0)
			GetConVar(GAMEMODE.Config.secondTeamName):SetInt(0)

		end)

	end

	for k,v in pairs(ents.GetAll()) do 

		if not IsValid(v) then continue end
		if not IsEntity(v) then continue end
		if v:IsPlayer() then continue end
		if v:IsWorld() then continue end
		if v:CreatedByMap() then continue end
		if GAMEMODE.Config.dontDeleteAfterFinal[v:GetClass()] then continue end 
				
		v:Remove()

	end

end