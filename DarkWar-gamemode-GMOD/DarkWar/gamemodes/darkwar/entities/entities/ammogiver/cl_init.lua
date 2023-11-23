include("shared.lua")

function ENT:Draw()
	
	self:DrawModel()
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) <= 500 then

		local ang = self:GetAngles()
		
		ang:RotateAroundAxis(self:GetAngles():Forward(),90)
		ang:RotateAroundAxis(self:GetAngles():Up(), -1 * (self:GetAngles().y - LocalPlayer():GetAngles().y) - 90)

		cam.Start3D2D(self:GetPos(),ang,0.1)
			
			draw.RoundedBox(0, -150, -300, 300, 50, Color(55, 55, 55, 115))
			draw.RoundedBox(0, -149, -299, 298, 48, Color(0, 0, 0, 175))
			drawTextWithShadow('Коробка с патронами', "SplashFont", 0, -275, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		cam.End3D2D()
	
	end

end