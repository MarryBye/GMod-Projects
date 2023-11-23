include("shared.lua")

function ENT:Draw()

	self:DrawModel()

	if self.angleRotate == nil then

		self.angleRotate = Angle(0, 0, 0)
		self.entColor = Color(255, 255, 255, 255)

		self.delay = 0
		self.nowCurTime = CurTime() + self.delay

	end

	self.sinMove = math.sin(CurTime()) * 8

	self.angleRotate = Angle(0, self.angleRotate.y + 1, 0)

	if self.angleRotate.y >= 360 then

		self.angleRotate = Angle(0, 0, 0)

	end

	self.pos = self:GetPos()

	self.PropAngle = Angle(0, self.angleRotate.y, 0)
	self.PropPos = Vector(self.pos.x, self.pos.y, self.pos.z + 45 + self.sinMove)

	if not IsValid(self.med_Model) then
		
		self.med_Model = ents.CreateClientProp()
		self.med_Model:SetModel( "models/items/battery.mdl" )
		self.med_Model:SetParent(self)
		self.med_Model:Spawn()
		self.med_Model:PhysicsInit(SOLID_NONE)
		self.med_Model:SetRenderMode(RENDERMODE_TRANSCOLOR)
		self.med_Model:SetModelScale(2)

	end

	self.lightning = DynamicLight(self:EntIndex())
	
	if self.lightning then
		
		self.lightning.pos = self:GetPos()
		
		if self.entColor.g == 255 then

			self.lightning.r = 50
			self.lightning.g = 255
			self.lightning.b = 0
		
		else

			self.lightning.r = self.entColor.r
			self.lightning.g = self.entColor.g
			self.lightning.b = self.entColor.b

		end

		self.lightning.brightness = 2
		self.lightning.Decay = 1000
		self.lightning.Size = 75
		self.lightning.DieTime = CurTime() + 1
	
	end

	if IsValid(self.med_Model) then
		
		self.med_Model:SetPos(self.PropPos)
		self.med_Model:SetAngles(self.PropAngle)
		self.med_Model:SetColor(self.entColor)

	end

	if not self:GetReadyToHeal() and IsValid(self.med_Model) then 

		self.entColor = Color(255, 50, 0, 0)

	else

		self.entColor = Color(255, 255, 255, 255)

	end

end