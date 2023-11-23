AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/xqm/jetbody3_s2.mdl")
	self:PhysicsInit(SOLID_NONE)
	self:EmitSound('npc/attack_helicopter/aheli_rotor_loop1.wav', 511, 100, 1)

end

function ENT:OnRemove()

	self:StopSound('npc/attack_helicopter/aheli_rotor_loop1.wav')

end