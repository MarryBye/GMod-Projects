include("autorun/sh_config.lua")
AddCSLuaFile("cl_fonts.lua")

local icon = function(m, x, y, w, h, c)
    
    surface.SetMaterial(Material(m))
    surface.SetDrawColor(c)
    surface.DrawTexturedRect(x, y, w, h)

end

local text = function(s, f, x, y, c, aX, aY)
    
    if aY == nil then

        draw.SimpleText(s, f, x, y, c, aX)

    else
        
        draw.SimpleText(s, f, x, y, c, aX, aY)

    end

end

local box = function(r, x, y, w, h, c)
    
    draw.RoundedBox(r, x, y, w, h, c)

end

hook.Add("PostPlayerDraw", "3D2DNicks", function(ply)
	
	local Distance = LocalPlayer():GetPos():Distance(ply:GetPos())

	if not IsValid( ply ) then return end 
	if not ply:Alive() then return end
	if ply == LocalPlayer() then return end 
	if ply:SetNoDraw() then return end
	if Distance > 350 then return end
 
	local offset = Vector(0, 0, 85)
	local ang = LocalPlayer():EyeAngles()
	local pos = ply:GetPos() + offset + ang:Up()
	 
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)
		
	cam.Start3D2D(pos, Angle(0, ang.y, 90), 0.1)

 		if ply:getJobTable()['category'] == LocalPlayer():getJobTable()['category'] then

 			icon(ply:GetNWString('Icon', 'No value'), -8, -10, 16, 16, Color(255, 255, 255, 255))
 			text(ply:GetNWString('Rank', 'No value'), "3D_Rank", 0, 15, Color(255,255,255,255), TEXT_ALIGN_CENTER)

		    text('[  ' .. ply:Nick() .. '  ]', "3D_Nick", 0, 50, Color(255,255,255,255), TEXT_ALIGN_CENTER)

		    box(1, -125, 100, 250, 10, Color(50,50,50,180))
		    box(1, -125, 125, 250, 10, Color(50,50,50,180))

		  	box(1, -125, 100, math.Clamp(ply:Health(), 0, 100) * 2.5, 10, Color(175,50,50,150))
		   	box(1, -125, 125, math.Clamp(ply:Armor(), 0, 100) * 2.5, 10, Color(50,50,175,150))

		    box(1, -125, 100, 10, 2, Color(255,255,255,255))
		    box(1, -125, 100, 2, 10, Color(255,255,255,255))
		    box(1, -125, 108, 10, 2, Color(255,255,255,255))

		    box(1, 115, 100, 10, 2, Color(255,255,255,255))
		    box(1, 123, 100, 2, 10, Color(255,255,255,255))
		    box(1, 115, 108, 10, 2, Color(255,255,255,255))

		    box(1, -125, 125, 10, 2, Color(255,255,255,255))
		    box(1, -125, 125, 2, 10, Color(255,255,255,255))
		    box(1, -125, 133, 10, 2, Color(255,255,255,255))

		    box(1, 115, 125, 10, 2, Color(255,255,255,255))
		    box(1, 123, 125, 2, 10, Color(255,255,255,255))
		    box(1, 115, 133, 10, 2, Color(255,255,255,255))

		end

		if CONFIG.job_viewers[LocalPlayer():Team()] then

			icon(ply:GetNWString('Icon', 'No value'), -8, -10, 16, 16, Color(255, 255, 255, 255))
 			text(ply:GetNWString('Rank', 'No value'), "3D_Rank", 0, 15, Color(255,255,255,255), TEXT_ALIGN_CENTER)
		    
		    text( '[  ' .. ply:Nick() .. '  ]', "3D_Nick", 0, 50, Color(255,255,255,255), TEXT_ALIGN_CENTER)

		    box(1, -125, 100, 250, 10, Color(50,50,50,180))
		    box(1, -125, 125, 250, 10, Color(50,50,50,180))

		  	box(1, -125, 100, math.Clamp(ply:Health(), 0, 100) * 2.5, 10, Color(175,50,50,150))
		   	box(1, -125, 125, math.Clamp(ply:Armor(), 0, 100) * 2.5, 10, Color(50,50,175,150))

		    box(1, -125, 100, 10, 2, Color(255,255,255,255))
		    box(1, -125, 100, 2, 10, Color(255,255,255,255))
		    box(1, -125, 108, 10, 2, Color(255,255,255,255))

		    box(1, 115, 100, 10, 2, Color(255,255,255,255))
		    box(1, 123, 100, 2, 10, Color(255,255,255,255))
		    box(1, 115, 108, 10, 2, Color(255,255,255,255))

		    box(1, -125, 125, 10, 2, Color(255,255,255,255))
		    box(1, -125, 125, 2, 10, Color(255,255,255,255))
		    box(1, -125, 133, 10, 2, Color(255,255,255,255))

		    box(1, 115, 125, 10, 2, Color(255,255,255,255))
		    box(1, 123, 125, 2, 10, Color(255,255,255,255))
		    box(1, 115, 133, 10, 2, Color(255,255,255,255))

	    end

	cam.End3D2D()
 
 end)