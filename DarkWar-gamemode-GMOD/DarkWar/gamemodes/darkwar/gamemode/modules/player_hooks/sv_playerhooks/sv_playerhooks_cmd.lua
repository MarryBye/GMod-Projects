concommand.Add( "dwr_getpos", function(ply, cmd, args)

	local ply_pos =   ply:GetPos()
	
	print('Vector(' .. ply_pos.x .. ', ' .. ply_pos.y .. ', ' .. ply_pos.z .. ')')

end)

concommand.Add( "dwr_getAdmins", function(ply, cmd, args)

	if not ply:GetPlayerIsAdminRank() then return end

	for k,v in pairs(player.GetAll()) do

		if not v:GetPlayerIsAdminRank() then continue end

		local ranply_id = v:EntIndex()
		local ranply_nick = v:Nick()
		local ranply_steamid = v:SteamID()
		local ranply_team, ranply_class = v:GetPlayerTeam(), v:GetPlayerClass()
		local ranply_txt = ' [ ' .. ranply_team .. ' ' .. ranply_class .. ' ]'

		print(ranply_id,ranply_steamid,ranply_nick,ranply_txt)

	end

end)

concommand.Add("dwr_setAdmin", function(ply, cmd, args)

	if not ply:GetPlayerIsAdminRank() then return end

	local steamid = args[1]
	local bool = args[2]

	for k,v in pairs(player.GetAll()) do

		local ranply_steamid = v:SteamID()

		if ranply_steamid == args[1] then

			v:SetPlayerAsAdmin(tobool(bool))

			return

		end

	end

	print('Игрок не найден!')

end, function(cmd, args)

	local tbl = {}

	for k,v in pairs(player.GetAll()) do

		local ranply_steamid = v:SteamID()
		
		tbl[#tbl + 1] = cmd .. ' "' .. ranply_steamid .. '" "true"'
		tbl[#tbl + 1] = cmd .. ' "' .. ranply_steamid .. '" "false"'

	end

	return tbl

end, 'Выдать права администратора', FCVAR_SERVER_CAN_EXECUTE)

concommand.Add("dwr_openMenu", function(ply, cmd, args)

	if not ply:GetPlayerIsAdminRank() then return end
	
	net.Start('OpenAdminMenu')
	net.Send(ply)

end, function() end, 'Открыть меню администратора', FCVAR_SERVER_CAN_EXECUTE)

local prefix = '/'

function GM:PlayerSay(ply, text)

	if string.lower(text) == prefix .. "adminteam" then

		if not ply:GetPlayerIsAdminRank() then ply:ChatPrint('Вам недоступна эта команда!') return '' end

		if timer.Exists('TeamChangeCooldown_' .. ply:SteamID()) then timer.Remove('TeamChangeCooldown_' .. ply:SteamID()) end
		ply:SetCanChangeTeam(true)

		ply:SetAuthorised(true)
		ply:SetPlayerTeam(GAMEMODE.Config.adminTeamName)
		ply:SetPlayerClass(GAMEMODE.Config.adminTeamName)
		ply:AddPlayerMoney(-ply:GetPlayerMoney())
		ply:AddPlayerKills(-ply:GetPlayerKills())
		ply:SetFrags(0)

		ply:GodEnable()

		ply:SetNoDraw(true)
		ply:SetNoTarget(true)

		ply:SetModel('models/player/skeleton.mdl')
		ply:StripWeapons()

		ply:SetupHands()

		ply:ChatPrint('Вы успешно зашли в режим администратора!')

		return ''

	end

	if string.lower(utf8.sub(text, 0, #prefix + #'giveselfmoney')) == prefix .. 'giveselfmoney' then

		if not ply:GetPlayerIsAdminRank() then ply:ChatPrint('Вам недоступна эта команда!') return '' end

		local moneyToGive = utf8.sub(text, #prefix + #'giveselfmoney' + 2)

		if not isnumber(tonumber(moneyToGive)) then ply:ChatPrint('Введено неверное количество денег!') return '' end

		ply:AddPlayerMoney(moneyToGive)

		ply:ChatPrint('Вы успешно выдали себе ' .. moneyToGive .. '$ !' )

		return ''

	end

	if string.lower(utf8.sub(text, 0, #prefix + #'givefteamscore')) == prefix .. 'givefteamscore' then

		if not ply:GetPlayerIsAdminRank() then ply:ChatPrint('Вам недоступна эта команда!') return '' end

		local scoreToGive = utf8.sub(text, #prefix + #'givefteamscore' + 2)

		if not isnumber(tonumber(scoreToGive)) then ply:ChatPrint('Введено неверное количество очков!') return '' end

		AddScoreTeam(GAMEMODE.Config.firstTeamName, scoreToGive)

		ply:ChatPrint('Вы успешно выдали ' .. scoreToGive .. ' очков команде ' .. GAMEMODE.Config.firstTeamName .. '!')

		return ''

	end

	if string.lower(utf8.sub(text, 0, #prefix + #'givesteamscore')) == prefix .. 'givesteamscore' then

		if not ply:GetPlayerIsAdminRank() then ply:ChatPrint('Вам недоступна эта команда!') return '' end

		local scoreToGive = utf8.sub(text, #prefix + #'givesteamscore' + 2)

		if not isnumber(tonumber(scoreToGive)) then ply:ChatPrint('Введено неверное количество очков!') return '' end

		AddScoreTeam(GAMEMODE.Config.secondTeamName, scoreToGive)

		ply:ChatPrint('Вы успешно выдали ' .. scoreToGive .. ' очков команде ' .. GAMEMODE.Config.secondTeamName .. '!')

		return ''

	end

	return text

end