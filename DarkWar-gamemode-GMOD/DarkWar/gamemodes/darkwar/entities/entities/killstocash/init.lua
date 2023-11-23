AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()

	self:SetModel("models/props_combine/combine_interface001.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:GetPhysicsObject():SetMass(10)
	self:GetPhysicsObject():SetVelocity((self:GetUp() * 10))

end

function ENT:AcceptInput(name, ply, caller)

	if not IsValid(ply) or not ply:IsPlayer() then return end
	if ply:GetEyeTrace().Entity:GetClass() ~= self:GetClass() then return end
	if ply:GetPlayerIsAdmin() then return end

	if ply:Frags() <= 0 then

		self:EmitSound("buttons/weapon_cant_buy.wav")

	else

		ply:AddPlayerMoney(ply:Frags() * 50)
		ply:SetFrags(0)

		self:EmitSound("buttons/weapon_confirm.wav")

	end

end