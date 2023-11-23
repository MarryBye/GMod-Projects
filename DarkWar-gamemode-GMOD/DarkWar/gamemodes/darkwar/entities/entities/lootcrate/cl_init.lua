include("shared.lua")

function ENT:Draw()

	self:DrawModel()
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) <= 500 then

		local ang = self:GetAngles()
		
		ang:RotateAroundAxis(self:GetAngles():Forward(),90)
		ang:RotateAroundAxis(self:GetAngles():Up(), -1 * (self:GetAngles().y - LocalPlayer():GetAngles().y) - 90)

		cam.Start3D2D(self:GetPos(),ang,0.1)
			
			draw.RoundedBox(0, -125, -350, 250, 50, Color(55, 55, 55, 115))
			draw.RoundedBox(0, -124, -349, 248, 48, Color(0, 0, 0, 175))
			drawTextWithShadow(self:GetNWString('Owner', 'No owner'), "SplashFont", 0, -325, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		cam.End3D2D()
	
	end

end