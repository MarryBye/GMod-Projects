AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("autorun/sh_config.lua")
include("shared.lua")
include('autorun/sh_config.lua')

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

	if ply:IsPlayer() == false then 

		return 

	end

end

function ENT:Use(ply, caller)

	if ply:Frags() == 0 then

		DarkRP.notify(ply, 1, 3, "Вы не можете обменять так мало убийств!")

		self:EmitSound("buttons/weapon_cant_buy.wav")

	else

		ply:addMoney(ply:Frags() * CONFIG.frag_cost)
		DarkRP.notify(ply, 0, 3, "Вы обменяли " .. ply:Frags() .. " убийств на " .. ply:Frags() * CONFIG.frag_cost .. "$")
		ply:SetFrags(0)

		self:EmitSound("buttons/weapon_confirm.wav")

	end
	
end