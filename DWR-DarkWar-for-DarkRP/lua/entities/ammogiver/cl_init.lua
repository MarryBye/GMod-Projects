include("shared.lua")

surface.CreateFont( "AMMO_BOX", { font = "Trebuchet24", size = 35, weight = 1000 } )

function ENT:Draw()
	
	self:DrawModel()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Forward(),90)
	ang:RotateAroundAxis(self:GetAngles():Up(),90)
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 500 then
		
		cam.Start3D2D(self:GetPos() + ang:Right() + ang:Up()* 16,ang,0.1)  --Vector(-26,0,90)
			
			draw.SimpleTextOutlined("Коробка с патронами", "AMMO_BOX", -150, -140,  Color(255,255,255,220), 0, 0, 2,Color(0,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT )
		
		cam.End3D2D()
	
	end

end