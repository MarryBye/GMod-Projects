AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

game.AddParticles( "particles/explosion.pcf" )

function ENT:Initialize()

	self:SetModel("models/Items/item_item_crate.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetGravity(0)
	self:PhysWake()

	self.Hitpoints = 150

	self.loot = ''

end

function ENT:AcceptInput(name, ply, caller)

	if not IsValid(ply) or not ply:IsPlayer() then return end
	if ply:GetEyeTrace().Entity:GetClass() ~= self:GetClass() then return end
	if ply:GetPlayerIsAdmin() then return end

	self:EmitSound("items/ammo_pickup.wav")

	ply:Give(self.loot)

	self:Remove()

end

function ENT:OnTakeDamage(dmg)

	self.Hitpoints = self.Hitpoints - dmg:GetDamage()

end

function ENT:Think()

	if self.Hitpoints <= 0 then

		self:Explode()

	end

end

function ENT:SetLoot(loot)

	self.loot = loot

end

function ENT:Explode()

	if not IsValid(self) then return end

	local effectData = EffectData()
	effectData:SetOrigin(self:GetPos())

	util.Effect("Explosion", effectData)

	util.BlastDamage(self, self, self:GetPos(), 256, 50)

	self:Remove()

end