AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/props_combine/suit_charger001.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(CONTINUOUS_USE)
	self:GetPhysicsObject():SetMass(10)
	self.delay = 0.5
	self.lastOccurance = -self.delay

end

function ENT:AcceptInput(name, ply, caller)

	if ply:IsPlayer() == false then 
		
		return 
	
	end

end

function ENT:Use(ply, caller)

	local timeElapsed = CurTime() - self.lastOccurance	
	
	if ply:Armor() < 100 then
		
		if timeElapsed < self.delay then
			
			return
		
		else
			
			self:EmitSound("items/suitchargeok1.wav")
			ply:SetArmor(ply:Armor() + 5)
			self.lastOccurance = CurTime()
		
		end
	
	else
		
		if timeElapsed < self.delay then
			
			return
		
		else
			
			self:EmitSound("items/suitchargeno1.wav")
			ply:ChatPrint("Ваша броня в порядке!")
			self.lastOccurance = CurTime()
		
		end	
	
	end

end