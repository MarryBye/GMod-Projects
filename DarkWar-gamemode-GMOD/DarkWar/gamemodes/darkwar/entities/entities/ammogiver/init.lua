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
	self:SetSequence( 1 )
	self:SetColor(Color(155, 155, 0))
	
	self.delay = 3
	self.lastOccurance = -self.delay

end

function ENT:AcceptInput(name, ply, caller)

	if not IsValid(ply) or not ply:IsPlayer() then return end
	if ply:GetEyeTrace().Entity:GetClass() ~= self:GetClass() then return end
	if ply:GetPlayerIsAdmin() then return end
	if not IsValid(ply:GetActiveWeapon()) then return end

	local timeElapsed = CurTime() - self.lastOccurance	
	
	if game.GetAmmoName(ply:GetActiveWeapon():GetPrimaryAmmoType()) ~= nil then
		
		if timeElapsed < self.delay then
			
			return
		
		else

			self:SetSequence( 0 )

			timer.Simple(0.1, function()

				self:SetSequence( 2 )

				timer.Simple(2.9, function()

					self:SetSequence( 3 )
					self:SetSequence( 1 )

				end)

			end)

			ply:GiveAmmo(150, game.GetAmmoName(ply:GetActiveWeapon():GetPrimaryAmmoType()))
			
			self.lastOccurance = CurTime()
		
		end
	
	else
		
		return
	
	end

end