net.Receive('JoinTeam', function(_, ply)

	if not ply:CanChangeTeam() then return end

	local chosenTeam = net.ReadString()

	if ply:GetPlayerTeam() == chosenTeam then return end

	if chosenTeam == GAMEMODE.Config.adminTeamName then

		print('[WARNING] Игрок попытался зайти за команду админов! Возможно читер.' )

		return

	end 

	if chosenTeam ~= GAMEMODE.Config.firstTeamName and chosenTeam ~= GAMEMODE.Config.secondTeamName then 

		print('[WARNING] Выбранной игроком ' .. ply:SteamID64() .. ' команды ' .. chosenTeam .. ' не существует! Возможно читер.' ) 

		return 

	end

	if ply:GetPlayerClass() == 'None' or ply:GetPlayerIsAdmin() then

		local randomClass = table.Random(GAMEMODE.Config.playerClasses)
	
		ply:SetPlayerClass(randomClass.class)
		ply:SetModel(table.Random(randomClass.models[chosenTeam]))

	end
	
	ply:SetPlayerTeam(chosenTeam)
	ply:SetAuthorised(true)

	ply:AddPlayerMoney(ply:GetPlayerMoney() * 0 + 200)
	ply:AddPlayerKills(ply:GetPlayerKills() * 0)

	ply:SetCanChangeTeam(false)

	timer.Create('TeamChangeCooldown_' .. ply:SteamID(), 240, 1, function()

		ply:SetCanChangeTeam(true)

	end)

	ply:KillSilent()

end)

net.Receive('CharEdit', function(_, ply)

	if ply:GetPlayerTeam() == 'None' or ply:GetPlayerIsAdmin() then return end

	local chosenModel = net.ReadString()
	local chosenClass = net.ReadString()

	if ply:GetPlayerClass() == chosenClass then return end

	local validClass = false
	local validModel = false

	if chosenClass == GAMEMODE.Config.adminTeamName then

		print('[WARNING] Игрок попытался зайти за класс админов! Возможно читер.' )

		return

	end

	for i = 1, #GAMEMODE.Config.playerClasses do

		if chosenClass ~= GAMEMODE.Config.playerClasses[i].class then 

			continue

		end

		validClass = true

		for k,v in pairs(GAMEMODE.Config.playerClasses[i].models[ply:GetPlayerTeam()]) do

			if chosenModel ~= v then 

				continue

			end 

			validModel = true

			ply:SetModel(chosenModel)
			ply:SetPlayerClass(chosenClass)

			if ply:GetAuthorised() then

				ply:KillSilent()

			end

			break

		end

		break

	end

	if not validClass then 

		print('[WARNING] Выбранный игроком ' .. ply:SteamID64() .. ' класс ' .. chosenClass .. ' не совпал с существующими! Возможно читер.')

	end

	if not validModel then 

		print('[WARNING] Выбранная игроком ' .. ply:SteamID64() .. ' модель ' .. chosenModel .. ' не совпала с существующими! Возможно читер.') 

	end

end)

net.Receive('ExecuteAdminCommand', function(_, ply)

	local funcName = net.ReadString()
	local target = net.ReadEntity()
	local func = net.ReadInt(32)

	if not ply:GetPlayerIsAdminRank() then return end

	GAMEMODE.Config.adminButtonsCommands[func].func(ply, target)

	print('Игрок ' .. ply:Nick() .. ' использовал функцию "' .. funcName .. '" на игроке ' .. target:Nick())

end)