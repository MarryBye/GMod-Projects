AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString('ChestUseDolg')
util.AddNetworkString('ChestUseFromDolg')

function ENT:Initialize()

	self:SetModel("models/props_junk/wood_crate001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:GetPhysicsObject():SetMass(10)
	self:GetPhysicsObject():SetVelocity((self:GetUp() * 10))
	self:SetMaterial('phoenix_storms/cube')
	self:SetColor(Color(55, 55, 55, 255))

	self.dolgInventory = {}

end

function ENT:AcceptInput(name, ply, caller)

	if not IsValid(ply) or not ply:IsPlayer() then return end
	if ply:GetPlayerTeam() ~= GAMEMODE.Config.firstTeamName then return end
	if ply:GetEyeTrace().Entity:GetClass() ~= self:GetClass() then return end
	if ply:GetPlayerIsAdmin() then return end

	net.Start('ChestUseDolg')

		net.WriteTable(ply:GetSeqWepTable())
		net.WriteTable(self.dolgInventory)
	
	net.Send(ply)

end

net.Receive('ChestUseFromDolg', function(_, ply)

	if ply:GetEyeTrace().Entity:GetClass() == nil then return end
	if ply:GetEyeTrace().Entity:GetClass() ~= 'dolgchest' then return end
	if ply:GetPlayerTeam() ~= GAMEMODE.Config.firstTeamName then return end

	local _class = net.ReadString()

	if IsValid(ply) and ply:Alive() then

		for i = 1, table.maxn(ply:GetEyeTrace().Entity.dolgInventory) do

			if ply:GetEyeTrace().Entity.dolgInventory[i] == nil then continue end

			if ply:GetEyeTrace().Entity.dolgInventory[i].class == _class then

				ply:GetEyeTrace().Entity.dolgInventory[i] = nil

				ply:Give(_class)

				break

			end

		end

	end

end)

net.Receive('ChestUseDolg', function(_, ply)

	if ply:GetEyeTrace().Entity:GetClass() == nil then return end
	if ply:GetEyeTrace().Entity:GetClass() ~= 'dolgchest' then return end
	if ply:GetPlayerTeam() ~= GAMEMODE.Config.firstTeamName then return end

	local _class = net.ReadString()
	local _name = net.ReadString()

	if IsValid(ply) and ply:HasWeapon(_class) and ply:Alive() then

		ply:GetEyeTrace().Entity.dolgInventory[#ply:GetEyeTrace().Entity.dolgInventory + 1] = { class = _class, name = _name}

		ply:StripWeapon(_class)
		
	end
		
end)

function ENT:Think()

	if GetMatchFinal() then

		self.dolgInventory = {}

	end

end