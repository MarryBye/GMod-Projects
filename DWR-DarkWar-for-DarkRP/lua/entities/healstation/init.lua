AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self:SetModel("models/props_combine/health_charger001.mdl")
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
	
	if ply:Health() < 100 then
		
		if timeElapsed < self.delay then
			
			return
		
		else
			
			self:EmitSound("items/medshot4.wav")
			ply:SetHealth(ply:Health() + 5)
			self.lastOccurance = CurTime()
		
		end
	
	else
		
		if timeElapsed < self.delay then
			
			return
		
		else
			
			self:EmitSound("items/medshotno1.wav")
			ply:ChatPrint("У вас уже полное кол-во HP!")
			self.lastOccurance = CurTime()
		
		end	
	
	end

end