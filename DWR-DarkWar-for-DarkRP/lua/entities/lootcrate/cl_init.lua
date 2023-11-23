include("shared.lua")
include('autorun/sh_config.lua')

surface.CreateFont( "LOOT", {
	font = "Trebuchet24",
	size = 50,
	weight = 1000, 
	blursize = 0, 
	scanlines = 0, 
	antialias = false, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = true,
} )

function ENT:Draw()

	self:DrawModel()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Forward(),90)
	ang:RotateAroundAxis(self:GetAngles():Up(),90)
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 500 then
		
		cam.Start3D2D(self:GetPos() + ang:Right() + ang:Up()* 18,ang,0.1)  --Vector(-26,0,90)
			
			draw.SimpleText(self:GetNWString('lootOwner', 'NO OWNER'), "LOOT", -10, -215, Color(255,255,255,255), TEXT_ALIGN_CENTER)

		cam.End3D2D()
	
	end

end