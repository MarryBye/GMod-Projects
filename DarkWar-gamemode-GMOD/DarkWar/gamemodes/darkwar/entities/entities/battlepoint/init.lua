AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ents.checkPlayer(pos, r, team)
	
	local tEntities = ents.FindInSphere(pos, r)
	local tPlayers = {}
	local iPlayers = 0
	
	for i = 1, #tEntities do
		
		if tEntities[i]:IsPlayer() then

			if tEntities[i]:GetPlayerTeam() == team and tEntities[i]:Health() > 0 then
			
				iPlayers = iPlayers + 1
		
			end

		end
	
	end
	
	return iPlayers

end

function ENT:Initialize()

	self:SetModel("models/props_wasteland/laundry_washer003.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:GetPhysicsObject():SetMass(10)
	self:SetColor(Color(255, 255, 175))

	self:SetNWString('ControlledByTeam', 'None')
	self:SetNWString('CaptureByTeam', 'None')

	self:SetNWBool('ActiveCapture', false)
	self:SetNWBool('CanCapture', true)
	self:SetNWInt('CapturePercents', 0)
		
	self:SetNWInt('PointIdentificator', math.random(100, 999))

	self.warnings = 0

	self.wDelay = 0.3
	self.wCurTime = CurTime() + self.wDelay

	self.tDelay = 0.3
	self.tCurTime = CurTime() + self.tDelay

	self.pDelay = 5
	self.pCurTime = CurTime() + self.pDelay

	self.nDelay = 30
	self.nCurTime = CurTime() + self.nDelay

end

function ENT:AcceptInput(name, ply, caller)

	if not CanContinueMatch() then return end
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if self:GetNWBool('ActiveCapture') then return end
	if not self:GetNWBool('CanCapture') then return end
	if ply:GetPlayerTeam() == self:GetNWString('ControlledByTeam') then return end
	if ply:GetEyeTrace().Entity:GetClass() ~= self:GetClass() then return end
	if ply:GetPlayerIsAdmin() then return end

	self:SetNWBool('ActiveCapture', true)
	self:SetNWString('CaptureByTeam', ply:GetPlayerTeam())
	self:EmitSound('buttons/weapon_confirm.wav')

end

function ENT:Think()

	if GetMatchFinal() then

		self:SetNWString('ControlledByTeam', 'None')
		self:SetNWString('CaptureByTeam', 'None')

		self:SetNWBool('ActiveCapture', false)
		self:SetNWBool('CanCapture', true)
		self:SetNWInt('CapturePercents', 0)

		self.warnings = 0

	end

	if not CanContinueMatch() then return end

	if not self:GetNWBool('ActiveCapture') then

		if CurTime() >= self.pCurTime then

			for k,v in pairs(player.GetAll()) do

				if v:GetPlayerTeam() ~= self:GetNWString('ControlledByTeam') or v:GetPlayerTeam() == 'None' then continue end

				v:AddPlayerMoney(5)
				v:AddPlayerExperience(5)

			end

			AddScoreTeam(self:GetNWString('ControlledByTeam'), 1)

			self.pCurTime = CurTime() + self.pDelay

		end

		if self:GetNWString('ControlledByTeam') ~= 'None' then

			if IsValid(self.npcDefender) then
			
				for k,v in pairs(ents.GetAll()) do
					
					if v:IsPlayer()	then
						
						if v:GetPlayerTeam() == self.npcDefender:GetNPCDefenderTeam() then 				

							self.npcDefender:AddEntityRelationship(v, D_LI, 99)

							continue 

						end
					
						self.npcDefender:AddEntityRelationship(v, D_HT, 99)

					end

					if v:IsNPC() then

						if v:GetNWString('DefenderTeam', 'None') == self.npcDefender:GetNPCDefenderTeam() then 

							self.npcDefender:AddEntityRelationship(v, D_LI, 99) 

							continue 

						end

						self.npcDefender:AddEntityRelationship(v, D_HT, 99)

					end

				end

			end

			if CurTime() >= self.nCurTime then 

				if not IsValid(self.npcDefender) then

					self.npcDefender = ents.Create('npc_Combine_S')
					
					self.npcDefender:SetDefender(self:GetNWString('ControlledByTeam'))

					self.npcDefender:SetPos(Vector(self:GetPos().x, self:GetPos().y, self:GetPos().z + 50))
					self.npcDefender:Give('weapon_ar2')
					self.npcDefender:SetKeyValue("spawnflags", bit.bor(SF_NPC_NO_WEAPON_DROP))
					self.npcDefender:Spawn()

					self.npcDefender:SetModel('models/stalker_antigas_killer.mdl')
					self.npcDefender:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_GOOD)
					self.npcDefender:SetHealth(200)

				end

				self.nCurTime = CurTime() + self.nDelay

			end

		end

	end

	if self:GetNWBool('ActiveCapture') then

		if ents.checkPlayer(self:GetPos(), 400, self:GetNWString('CaptureByTeam')) <= 0 then

			if CurTime() >= self.wCurTime then

				self.warnings = self.warnings + 1

				self.wCurTime = CurTime() + self.wDelay

			end

			if self.warnings >= 15 then

				self:SetNWBool('ActiveCapture', false)
				self:SetNWBool('CanCapture', true)
				self:SetNWInt('CapturePercents', 0)
				self:SetNWString('CaptureByTeam', 'None')

				self.warnings = 0
				
				self:EmitSound('buttons/weapon_cant_buy.wav')

			end

		end

		if CurTime() >= self.tCurTime and self:GetNWInt('CapturePercents') <= 100 then

			self:SetNWInt('CapturePercents', self:GetNWInt('CapturePercents') + 1)
			self.tCurTime = CurTime() + self.tDelay

		end

		if self:GetNWInt('CapturePercents') >= 100 then
			
			if ents.checkPlayer(self:GetPos(), 400, self:GetNWString('CaptureByTeam')) > 0 then
				
				self:SetNWString('ControlledByTeam', self:GetNWString('CaptureByTeam'))
				self:EmitSound('buttons/blip2.wav')

			else

				self:EmitSound('buttons/weapon_cant_buy.wav')

			end

			self:SetNWBool('ActiveCapture', false)
			self:SetNWBool('CanCapture', true)
			self:SetNWInt('CapturePercents', 0)
			self:SetNWString('CaptureByTeam', 'None')
			
			self.warnings = 0

		end

	end

end