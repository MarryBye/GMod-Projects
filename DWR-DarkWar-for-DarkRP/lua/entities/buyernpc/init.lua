AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("SGUI")

function ENT:Initialize()
	
	self:SetModel("models/Humans/Group03m/Male_03.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()

end

function ENT:AcceptInput(name, ply, caller)
	
	if not IsValid(ply) and not ply:IsPlayer() then return end

	net.Start("SGUI")
	net.Send(ply)

end

net.Receive("SGUI", function()
		
		local gun = net.ReadString()
		local cost = net.ReadInt(32)
		local ply = net.ReadEntity()
		
		if not ply:HasWeapon(gun) then
			
			if ply:canAfford(cost) then
				
				ply:Give(gun)
				ply:addMoney(-cost)
			
			else
				
				DarkRP.notify(ply, 1, 1, "У вас нехватает денег для покупки этого оружия!")
			
			end
		
		else
			
			DarkRP.notify(ply, 1, 1, "У вас уже есть данное оружие!")
		
		end
	
	end)