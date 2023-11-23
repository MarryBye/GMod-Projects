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
	self:GetPhysicsObject():SetMass(10)
	self:GetPhysicsObject():SetVelocity((self:GetUp() * 10))
	self:SetMaterial('models/props_pipes/GutterMetal01a')

	self.Hitpoints = 150
	self.loot = {}

end

function ENT:AcceptInput(name, ply, caller)

	if not IsValid(ply) or not ply:IsPlayer() then return end
	if ply:GetEyeTrace().Entity:GetClass() ~= self:GetClass() then return end
	if ply:GetPlayerIsAdmin() then return end

	if ply:IsPlayer() then 

		self:EmitSound("items/ammo_pickup.wav")

		for i = 1, #self.loot do

			if self.loot and self.loot[i] then

				ply:Give(self.loot[i].class)

			end

		end

		self:Remove()

	end

end

function ENT:OnTakeDamage(dmg)

	self.Hitpoints = self.Hitpoints - dmg:GetDamage()

end

function ENT:Think()

	if self.Hitpoints <= 0 then

		self:Explode()

	end

end

function ENT:SetLoot(tableLoot)

	self.loot = table.Copy(tableLoot)

end

function ENT:Explode()

	if not IsValid(self) then return end

	local effectData = EffectData()
	effectData:SetOrigin(self:GetPos())

	util.Effect("Explosion", effectData)

	util.BlastDamage(self, self, self:GetPos(), 256, 50)

	self:Remove()

end