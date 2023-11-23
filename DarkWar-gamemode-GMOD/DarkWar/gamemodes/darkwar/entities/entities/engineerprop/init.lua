AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:GetPhysicsObject():SetMass(10)
	
	self.Hitpoints = 250

end

function ENT:SetHP(hp)

	self.Hitpoints = hp

end

function ENT:GetHP()

	return self.Hitpoints

end

function ENT:OnTakeDamage(dmg)

    self.Hitpoints = self.Hitpoints - dmg:GetDamage()

end

function ENT:Think()

	if self.Hitpoints <= 0 then

		self:GetNWEntity('PropOwner'):SetNWInt('OwnerPropAmount', self:GetNWEntity('PropOwner'):GetNWInt('OwnerPropAmount', 0) - 1)

		self:Remove()

	end

end

function ENT:OnRemove()

	if self.Hitpoints > 0 then 

		self:GetNWEntity('PropOwner'):SetNWInt('OwnerPropAmount', self:GetNWEntity('PropOwner'):GetNWInt('OwnerPropAmount', 0) - 1)

		return true 

	end

end