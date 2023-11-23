hook.Add('HUDPaint', 'PlayerInterface_Wallhack', function()

	if not cl_VarsLoaded then return end
	if not lcply:GetAuthorised() then return end

	for k,v in pairs(ents.GetAll()) do

		if v:IsNPC() then
			
			if lcply_pos:Distance(v:GetPos()) < 1500 then continue end
			if not v:GetIsDefender() then continue end
			if v:GetNPCDefenderTeam() ~= lcply_team and not lcply_admin then continue end
			if v:Health() <= 0 then continue end
			if v:GetBoneMatrix(0) == nil then continue end
				
			local matrix = v:GetBoneMatrix(0)
			local pos = matrix:GetTranslation()

			local Position = (pos):ToScreen()

			drawCircle(Position.x, Position.y, 7, 3, Color(0, 0, 0, 255))
			drawCircle(Position.x, Position.y, 4, 3, Color(175, 225, 0, 255))

		end

		if v:IsPlayer() then 

			if lcply_pos:Distance(v:GetPos()) < 1500 then continue end
			if v:SteamID() == lcply_steamid then continue end
			if v:GetPlayerTeam() ~= lcply_team and not lcply_admin then continue end
			if v:Health() <= 0 then continue end
			if v:GetBoneMatrix(0) == nil then continue end

			local matrix = v:GetBoneMatrix(0)
			local pos = matrix:GetTranslation()

			local Position = (pos):ToScreen()

			drawCircle(Position.x, Position.y, 7, 4, Color(0, 0, 0, 255))
			drawCircle(Position.x, Position.y, 4, 4, Color(35, 225, 0, 255))

		end

	end

end)

hook.Add("PreDrawHalos", "PlayerInterface_WallhackGlow", function()

	if not cl_VarsLoaded then return end
	if not lcply:GetAuthorised() then return end

	local listOfItemsForGlowEbatNazvanieSuka = {}
	local npc_listOfItemsForGlowEbatNazvanieSuka = {}
	
	for k,v in pairs(ents.GetAll()) do

		if v:IsPlayer() then
			
			if v == lcply then continue end
			if not IsValid(v) or v:Health() < 0 then continue end
			if lcply_pos:Distance(v:GetPos()) > 1500 then continue end
			if v:GetPlayerTeam() ~= lcply_team and not lcply_admin then continue end

			listOfItemsForGlowEbatNazvanieSuka[#listOfItemsForGlowEbatNazvanieSuka + 1] = v

		end

		if v:IsNPC() and v:GetIsDefender() then

			if not IsValid(v) or v:Health() < 0 then continue end
			if v:GetNPCDefenderTeam() ~= lcply_team then continue end
			if lcply_pos:Distance(v:GetPos()) > 1500 and not lcply_admin then continue end

			npc_listOfItemsForGlowEbatNazvanieSuka[#npc_listOfItemsForGlowEbatNazvanieSuka + 1] = v

		end

	end

	halo.Add(listOfItemsForGlowEbatNazvanieSuka, Color(50, 200, 0, 255), 1, 1, 1, true, true)
	halo.Add(npc_listOfItemsForGlowEbatNazvanieSuka, Color(175, 225, 0, 255), 1, 1, 1, true, true)

end)