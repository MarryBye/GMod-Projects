AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self:SetModel("models/hunter/plates/plate05x05.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(CONTINUOUS_USE)
	self:GetPhysicsObject():SetMass(10)
	self:SetColor(Color(50, 200, 0))
	self:SetMaterial('models/debug/debugwhite')
	self.ReadyToHeal = true

	self.delay = 15
	self.hCurTime = nil

end

function ENT:SetReadyToHeal(b)

	self.ReadyToHeal = b
	self:SetNWBool('ReadyToHeal', b)

end

function ENT:Think()

	if self:GetReadyToHeal() then 

		self:SetColor(Color(50, 200, 0))
		self.hCurTime = CurTime() + self.delay 

		for k,v in pairs(ents.FindInSphere(self:GetPos(), 25)) do

			if v:IsPlayer() and v:Armor() < v:GetMaxArmor() then 

				v:SetArmor(v:Armor() + 50) 
				self:SetReadyToHeal(false) 
				self:EmitSound('items/suitchargeok1.wav')

			end

		end

	else self:SetColor(Color(200, 50, 0)) end

	if self.hCurTime == nil or self.hCurTime < CurTime() then

		self:SetReadyToHeal(true)

	end

end