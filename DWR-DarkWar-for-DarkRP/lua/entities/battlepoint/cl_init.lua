include("shared.lua")

surface.CreateFont( "BattlePoint_Main", { font = "Trebuchet24", size = 50, weight = 1000 } )

local cin = 0

function ENT:Draw()
	
	self:DrawModel()

	cin = (math.sin(CurTime()) + 1) / 2

	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Forward(),90)
	ang:RotateAroundAxis(self:GetAngles():Up(),180)
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 500 then

		cam.Start3D2D(self:GetPos() + ang:Right() + ang:Up()* 0,ang,0.1)
					
			draw.SimpleTextOutlined('Точка захвата | BP-' .. self:GetNWInt('pointNum', 0), "BattlePoint_Main", -245, -400,  Color(255,255,255,220), 0, 0, 2,Color(0,0,0,255), TEXT_ALIGN_CENTER )
					
			draw.SimpleTextOutlined('Точка принадлежит: ' .. "'" .. self:GetNWString('pointTeam') .. "'", "BattlePoint_Main", -275, -335,  Color(255,255,255,220), 0, 0, 2,Color(0,0,0,255), TEXT_ALIGN_CENTER )
			
			if self:GetNWInt('capture') > 0 then
				
				draw.SimpleTextOutlined('До захвата точки: ' .. self:GetNWInt('capture') .. ' секунд! Захватывают: ' .. self:GetNWString('teamCapture', 'No team'), "BattlePoint_Main", -500, -475,  Color(cin * 255, 0, 255 - (cin * 255)), 0, 0, 2,Color(0,0,0,255), TEXT_ALIGN_CENTER )

			end

			if self:GetNWInt('cooldown') > 0 then
				
				draw.SimpleTextOutlined('До следующего перехвата: ' .. self:GetNWInt('cooldown') .. ' секунд.', "BattlePoint_Main", -360, -475,  Color(cin * 255, 0, 255 - (cin * 255)), 0, 0, 2,Color(0,0,0,255), TEXT_ALIGN_CENTER )

			end

		cam.End3D2D()
	
	end

end