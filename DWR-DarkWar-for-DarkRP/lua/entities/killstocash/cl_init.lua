include("shared.lua")
include('autorun/sh_config.lua')

surface.CreateFont( "Standart", {
	font = "Trebuchet24",
	size = 30,
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
	outline = false,
} )

function ENT:Draw()

	self:DrawModel()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Forward(),90)
	ang:RotateAroundAxis(self:GetAngles():Up(),90)
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 500 then
		
		cam.Start3D2D(self:GetPos() + ang:Right() + ang:Up()* -8,ang,0.1)  --Vector(-26,0,90)
			
			draw.RoundedBox(0,-250,-600,500,200,Color(50,50,50,160))
			draw.SimpleTextOutlined("Обмен убийств на деньги.", "Standart", -165, -590,  Color(255,255,255,220), 0, 0, 2,Color(0,0,0,220), TEXT_ALIGN_CENTER )
			draw.SimpleTextOutlined("Вы можете получить: " .. LocalPlayer():Frags() * CONFIG.frag_cost .. "$", "Standart", -165, -550,  Color(255,255,255,220), 0, 0, 2,Color(0,0,0,220), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT )
		
		cam.End3D2D()
	
	end

end