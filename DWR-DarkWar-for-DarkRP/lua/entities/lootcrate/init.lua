AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("autorun/sh_config.lua")
include("shared.lua")
include('autorun/sh_config.lua')
include('autorun/server/sv_funcs.lua')

function ENT:Initialize()

	self:SetModel("models/Items/item_item_crate.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:GetPhysicsObject():SetMass(10)
	self:GetPhysicsObject():SetVelocity((self:GetUp() * 10))
	self.loot = table.Copy(crate_weapons)
	self:SetNWString('lootOwner', crate_owner)

end

function ENT:AcceptInput(name, ply, caller)

	if ply:IsPlayer() then 

		for k,v in pairs(self.loot) do

			self:EmitSound("items/ammo_pickup.wav")
			ply:Give(self.loot[k])

		end

		self:Remove()

	end

end