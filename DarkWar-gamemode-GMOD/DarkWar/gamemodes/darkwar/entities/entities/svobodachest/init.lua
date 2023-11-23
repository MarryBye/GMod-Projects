AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString('ChestUseSvoboda')
util.AddNetworkString('ChestUseFromSvoboda')

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

	self.svobodaInventory = {}

end

function ENT:AcceptInput(name, ply, caller)

	if not IsValid(ply) or not ply:IsPlayer() then return end
	if ply:GetPlayerTeam() ~= GAMEMODE.Config.secondTeamName then return end
	if ply:GetEyeTrace().Entity:GetClass() ~= self:GetClass() then return end
	if ply:GetPlayerIsAdmin() then return end

	net.Start('ChestUseSvoboda')

		net.WriteTable(ply:GetSeqWepTable())
		net.WriteTable(self.svobodaInventory)
	
	net.Send(ply)

end

net.Receive('ChestUseFromSvoboda', function(_, ply)

	if ply:GetEyeTrace().Entity:GetClass() == nil then return end
	if ply:GetEyeTrace().Entity:GetClass() ~= 'svobodachest' then return end
	if ply:GetPlayerTeam() ~= GAMEMODE.Config.secondTeamName then return end

	local _class = net.ReadString()

	if IsValid(ply) and ply:Alive() then

		for i = 1, table.maxn(ply:GetEyeTrace().Entity.svobodaInventory) do

			if ply:GetEyeTrace().Entity.svobodaInventory[i] == nil then continue end

			if ply:GetEyeTrace().Entity.svobodaInventory[i].class == _class then

				ply:GetEyeTrace().Entity.svobodaInventory[i] = nil

				ply:Give(_class)

				break

			end

		end

	end

end)

net.Receive('ChestUseSvoboda', function(_, ply)

	if ply:GetEyeTrace().Entity:GetClass() == nil then return end
	if ply:GetEyeTrace().Entity:GetClass() ~= 'svobodachest' then return end
	if ply:GetPlayerTeam() ~= GAMEMODE.Config.secondTeamName then return end

	local _class = net.ReadString()
	local _name = net.ReadString()

	if IsValid(ply) and ply:HasWeapon(_class) and ply:Alive() then

		ply:GetEyeTrace().Entity.svobodaInventory[#ply:GetEyeTrace().Entity.svobodaInventory + 1] = { class = _class, name = _name}

		ply:StripWeapon(_class)
		
	end
		
end)

function ENT:Think()

	if GetMatchFinal() then

		self.svobodaInventory = {}

	end

end