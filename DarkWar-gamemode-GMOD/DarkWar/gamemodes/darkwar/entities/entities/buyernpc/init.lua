AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("GunBuy")

local replics = {

	[1] = 'lo/scales/bandit/enemy_11.wav',
	[2] = 'lo/scales/bandit/weapon_1.wav',
	[3] = 'lo/scales/bandit/kill_wounded_1.wav'
}

function ENT:Initialize()
	
	self:SetModel("models/stalker_bandit_veteran.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:AddFlags(FL_NOTARGET)

	self.replic = ''

end

function ENT:AcceptInput(name, ply, caller)

	self:StopSound(self.replic)

	self.replic = replics[math.random(1, #replics)]
	
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if ply:GetEyeTrace().Entity:GetClass() ~= 'buyernpc' then return end
	if ply:GetPlayerIsAdmin() then return end

	net.Start('GunBuy')
	net.Send(ply)

	self:EmitSound(self.replic)

end

net.Receive('GunBuy', function(_, ply)

	if not IsValid(ply) or not ply:IsPlayer() then return end
	if ply:GetEyeTrace().Entity:GetClass() ~= 'buyernpc' then return end
	if ply:GetPlayerIsAdmin() then return end

	local gun = net.ReadString()
	local price = net.ReadInt(32)

	local validGun = false
	local validPrice = false

	if price <= 0 then 

		print('[WARNING] Игрок ' .. ply:SteamID64() .. ' пытается купить ' .. gun .. ' За цену <= 0 ! Возможно читер.')

		return

	end

	for i = 1, #GAMEMODE.Config.gunsCategories do

		for j = 1, #GAMEMODE.Config.gunsCategories[i].guns do 

			if gun ~= GAMEMODE.Config.gunsCategories[i].guns[j].gun then continue end

			validGun = true

			if price ~= GAMEMODE.Config.gunsCategories[i].guns[j].price then continue end

			validPrice = true

			if IsValid(ply) then

				if ply:GetPlayerMoney() >= price then

					if not ply:HasWeapon(gun) then

						ply:AddPlayerMoney(-price)
						ply:Give(gun)
						ply:EmitSound('items/ammo_pickup.wav')

						return

					end

				end

			end

		end

	end

	if not validGun then

		print('[WARNING] Выбранное игроком ' .. ply:SteamID64() .. ' оружие ' .. gun .. ' не совпало с существующими! Возможно читер.')

	end

	if not validPrice then

		print('[WARNING] Цена в ' .. price .. '$ на оружие ' .. gun .. ' у ' .. ply:SteamID64() .. ' не совпала с существующими! Возможно читер.')

	end

end)