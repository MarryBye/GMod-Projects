include("autorun/sh_config.lua")
AddCSLuaFile("cl_fonts.lua")

net.Receive("spectate_wh", function()

    DarkWar.Wallhack = function()

        for k,v in pairs (player.GetAll()) do

        	local ply = LocalPlayer()
    		ply:SetPos(v:GetPos())

	        local Position = (v:GetPos() + Vector(0,0,85)):ToScreen()
	           
	        draw.RoundedBox(0, Position.x, Position.y + 2, 12, 70, team.GetColor(v:Team()))
	        draw.DrawText(v:Nick(), "Spec_Main",  Position.x + 15, Position.y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT)
	       	draw.DrawText(v:getDarkRPVar("job"), "Spec_Main",  Position.x + 15, Position.y + 25, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT)
	        draw.DrawText(v:Health() .. " / " .. v:Armor(), "Spec_Main",  Position.x + 15, Position.y + 50, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT)

        end

    end

    hook.Add("HUDPaint", "Wallhack", DarkWar.Wallhack)

end)

net.Receive("unspectate_wh", function()

    hook.Remove("HUDPaint", "Wallhack")

end)

local icon = function(m, x, y, w, h, c)
    
    surface.SetMaterial(Material(m))
    surface.SetDrawColor(c)
    surface.DrawTexturedRect(x, y, w, h)

end

local box = function(r, x, y, w, h, c)
    
    draw.RoundedBox(r, x, y, w, h, c)

end

local text = function(s, f, x, y, c, aX, aY)
    
    if aY == nil then

        draw.SimpleText(s, f, x, y, c, aX)

    else
        
        draw.SimpleText(s, f, x, y, c, aX, aY)

    end

end

DarkWar.TeamWallhack = function()

	for k,v in pairs ( player.GetAll() ) do
 
		local Position = ( v:GetPos() + Vector( 0,0,80 ) ):ToScreen()
		local Name = ""
 
		if v == LocalPlayer() then Name = "" else Name = v:Name() end
		if LocalPlayer():GetPos():Distance(v:GetPos()) > 1500 then return end

		if not LocalPlayer():IsLineOfSightClear(v) then 

			if LocalPlayer():getJobTable()['category'] == v:getJobTable()['category'] then

				icon(v:GetNWString('Icon', 'No value'), Position.x - 8, Position.y - 33, 16, 16, Color(255, 255, 255, 255))
 				text(v:GetNWString('Rank', 'No value'), "3D_Rank_Spec", Position.x, Position.y - 15, Color(255,255,255,255), TEXT_ALIGN_CENTER)
 		    
	 		    text( '[  ' .. v:Nick() .. '  ]', "Spec_Main", Position.x, Position.y, Color(255,255,255,255), TEXT_ALIGN_CENTER)

			    box(1, Position.x - 60, Position.y + 30, 120, 5, Color(50,50,50,180))
			    box(1, Position.x - 60, Position.y + 40, 120, 5, Color(50,50,50,180))

			  	box(1, Position.x - 60, Position.y + 30, math.Clamp(v:Health(), 0, 100) * 1.2, 5, Color(175,50,50,150))
			   	box(1, Position.x - 60, Position.y + 40, math.Clamp(v:Armor(), 0, 100) * 1.2, 5, Color(50,50,175,150))

			    box(1, Position.x - 60, Position.y + 30, 5, 1, Color(255,255,255,255))
			    box(1, Position.x - 60, Position.y + 30, 1, 5, Color(255,255,255,255))
			    box(1, Position.x - 60, Position.y + 34, 5, 1, Color(255,255,255,255))

			    box(1, Position.x + 55, Position.y + 30, 5, 1, Color(255,255,255,255))
			    box(1, Position.x + 60, Position.y + 30, 1, 5, Color(255,255,255,255))
			    box(1, Position.x + 55, Position.y + 34, 5, 1, Color(255,255,255,255))

			    box(1, Position.x - 60, Position.y + 40, 5, 1, Color(255,255,255,255))
			    box(1, Position.x - 60, Position.y + 40, 1, 5, Color(255,255,255,255))
			    box(1, Position.x - 60, Position.y + 44, 5, 1, Color(255,255,255,255))

			    box(1, Position.x + 55, Position.y + 40, 5, 1, Color(255,255,255,255))
			    box(1, Position.x + 60, Position.y + 40, 1, 5, Color(255,255,255,255))
			    box(1, Position.x + 55, Position.y + 44, 5, 1, Color(255,255,255,255))

			end

			if CONFIG.job_viewers[LocalPlayer():Team()] then

				icon(v:GetNWString('Icon', 'No value'), Position.x - 8, Position.y - 33, 16, 16, Color(255, 255, 255, 255))
 				text(v:GetNWString('Rank', 'No value'), "3D_Rank_Spec", Position.x, Position.y - 15, Color(255,255,255,255), TEXT_ALIGN_CENTER)

				text( '[  ' .. v:Nick() .. '  ]', "Spec_Main", Position.x, Position.y, Color(255,255,255,255), TEXT_ALIGN_CENTER)

			    box(1, Position.x - 60, Position.y + 30, 120, 5, Color(50,50,50,180))
			    box(1, Position.x - 60, Position.y + 40, 120, 5, Color(50,50,50,180))

			  	box(1, Position.x - 60, Position.y + 30, math.Clamp(v:Health(), 0, 100) * 1.2, 5, Color(175,50,50,150))
			   	box(1, Position.x - 60, Position.y + 40, math.Clamp(v:Armor(), 0, 100) * 1.2, 5, Color(50,50,175,150))

			    box(1, Position.x - 60, Position.y + 30, 5, 1, Color(255,255,255,255))
			    box(1, Position.x - 60, Position.y + 30, 1, 5, Color(255,255,255,255))
			    box(1, Position.x - 60, Position.y + 34, 5, 1, Color(255,255,255,255))

			    box(1, Position.x + 55, Position.y + 30, 5, 1, Color(255,255,255,255))
			    box(1, Position.x + 60, Position.y + 30, 1, 5, Color(255,255,255,255))
			    box(1, Position.x + 55, Position.y + 34, 5, 1, Color(255,255,255,255))

			    box(1, Position.x - 60, Position.y + 40, 5, 1, Color(255,255,255,255))
			    box(1, Position.x - 60, Position.y + 40, 1, 5, Color(255,255,255,255))
			    box(1, Position.x - 60, Position.y + 44, 5, 1, Color(255,255,255,255))

			    box(1, Position.x + 55, Position.y + 40, 5, 1, Color(255,255,255,255))
			    box(1, Position.x + 60, Position.y + 40, 1, 5, Color(255,255,255,255))
			    box(1, Position.x + 55, Position.y + 44, 5, 1, Color(255,255,255,255))

			end

		end
 
	end

end

hook.Add("HUDPaint", "TeamWallhack", DarkWar.TeamWallhack)