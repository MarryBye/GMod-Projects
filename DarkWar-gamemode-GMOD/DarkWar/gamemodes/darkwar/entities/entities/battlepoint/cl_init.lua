include("shared.lua")

function ENT:Draw()
	
	self:DrawModel()

	if LocalPlayer():GetPos():Distance(self:GetPos()) <= 500 then

		local ang = self:GetAngles()
		
		ang:RotateAroundAxis(self:GetAngles():Forward(),90)
		ang:RotateAroundAxis(self:GetAngles():Up(), -1 * (self:GetAngles().y - LocalPlayer():GetAngles().y) - 90)

		cam.Start3D2D(self:GetPos(),ang,0.1)
			
			drawTextWithShadow('Контролирует: ' .. self:GetNWString('ControlledByTeam'), "SplashFont", 0, -450, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)	
			drawTextWithShadow('Точка захвата #' .. self:GetNWInt('PointIdentificator', 'nil'), "SplashFont", 0, -400, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			
			if self:GetNWBool('ActiveCapture') then
				
				draw.RoundedBox(0, -476 / 2, -350, 476, 36, Color(0, 0, 0, 115))
				draw.RoundedBox(0, -473 / 2, -348, math.Clamp(self:GetNWInt('CapturePercents'), 0, 100) * 4.72, 32, Color(75, 200, 0, 225))
				drawTextWithShadow(self:GetNWInt('CapturePercents', 0) .. '%', "SplashFont", 0, -332, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			
			elseif not self:GetNWBool('CanCapture') then

				draw.RoundedBox(0, -476 / 2, -350, 476, 36, Color(0, 0, 0, 115))
				draw.RoundedBox(0, -473 / 2, -348, math.Clamp(self:GetNWInt('CapturePercents'), 0, 100) * 4.72, 32, Color(200, 75, 0, 225))
				drawTextWithShadow(self:GetNWInt('CapturePercents', 0) .. '%', "SplashFont", 0, -332, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			end
			
		cam.End3D2D()
	
	end

end

hook.Add('HUDPaint', 'BattlepointWallhack', function()

	if not LocalPlayer():GetAuthorised() then return end

	for k,v in pairs(ents.FindByClass('battlepoint')) do

		if not IsValid(v) then continue end
		if LocalPlayer():GetPos():Distance(v:GetPos()) <= 500 and LocalPlayer():IsLineOfSightClear(v:GetPos()) then continue end
		if LocalPlayer():GetPos():Distance(v:GetPos()) > 1500 and not LocalPlayer():GetPlayerIsAdmin() then continue end

		local pos = v:GetPos()
		local Position = (pos):ToScreen()

		drawCircle(Position.x, Position.y, 7, 180, Color(0, 0, 0, 255))

		if LocalPlayer():GetPlayerTeam() == v:GetNWString('ControlledByTeam') then
			
			drawCircle(Position.x, Position.y, 4, 180, Color(0, 75, 225, 255))

		else

			drawCircle(Position.x, Position.y, 4, 180, Color(225, 35, 0, 255))

		end

	end

end)

function ENT:OnRemove()

	hook.Remove('BattlepointWallhack')

end