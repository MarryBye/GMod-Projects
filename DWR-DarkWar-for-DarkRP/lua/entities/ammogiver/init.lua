AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/Items/ammocrate_smg1.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:GetPhysicsObject():SetMass(10)
	self:DropToFloor()
	self.delay = 3
	self.lastOccurance = -self.delay

end

function ENT:AcceptInput(name, ply, caller)

	if ply:IsPlayer() == false then 
		
		return 
	
	end

end

function ENT:Use(ply, caller)

	local timeElapsed = CurTime() - self.lastOccurance	
	
	if game.GetAmmoName(ply:GetActiveWeapon():GetPrimaryAmmoType()) != nil then
		
		if timeElapsed < self.delay then
			
			return
		
		else
			
			ply:GiveAmmo(150, game.GetAmmoName(ply:GetActiveWeapon():GetPrimaryAmmoType()), true)
			self:EmitSound("items/ammocrate_close.wav")
			self:EmitSound("items/ammo_pickup.wav")
			self.lastOccurance = CurTime()
		
		end
	
	else
		
		ply:ChatPrint("Неверный тип оружия!")
	
	end

end