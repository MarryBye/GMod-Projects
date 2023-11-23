AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("autorun/sh_config.lua")
include("shared.lua")
include("autorun/sh_config.lua")
--include("autorun/server/sv_funcs.lua")

function ents.checkPlayer(pos, r, team)
	
	local tEntities = ents.FindInSphere(pos, r)
	local tPlayers = {}
	local iPlayers = 0
	
	for i = 1, #tEntities do
		
		if tEntities[i]:IsPlayer() then

			if tEntities[i]:getJobTable()['category'] == team and tEntities[i]:Health() > 0 then
			
				iPlayers = iPlayers + 1
				tPlayers[iPlayers] = tEntities[i]
		
			end

		end
	
	end
	
	return tPlayers, iPlayers

end

function ENT:Initialize()

	self:SetModel("models/props_wasteland/laundry_washer003.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:GetPhysicsObject():SetMass(10)
	self:DropToFloor()
	self:SetNWString('pointTeam', 'No team')
	self:SetNWBool('captureActive', false)
	self:SetNWInt('capture', -1)
	self:SetNWInt('cooldown', -1)
	self.timerName_cooldown = tostring(math.random(1000000000,9999999999))
	self.timerName_capture = tostring(math.random(1000000000,9999999999))
	self.timerName_prise = tostring(math.random(1000000000,9999999999))
	self.delay_capture = CONFIG.point_capture_delay
	self.delay_cooldown = CONFIG.point_cooldown_delay
	self.delay_prise = CONFIG.point_prise_delay
	self.teamCapture = 'No team'
	self:SetNWString('teamCapture', self.teamCapture)
	self.radius = CONFIG.point_radius
	self.battle = false
	self.canCapture = false
	self.prise = CONFIG.capture_prise
	self.SOCC = true
	self:SetNWInt('pointNum', math.random(100000, 999999))

	timer.Create(self.timerName_prise, self.delay_prise, 0, function()

		for k,v in pairs(player.GetAll()) do

			if v:getJobTable()['category'] == self:GetNWString('pointTeam') then

				DarkRP.notify(v, 0, 3, 'Вы получили ' .. self.prise .. '$ за захват точки!')
				v:addMoney(self.prise)

			end

		end

	end)

end

function ENT:AcceptInput(name, ply, caller)

	if ply:IsPlayer() == false then 
		
		return 
	
	end

	if self:GetNWString('pointTeam') == caller:getJobTable()['category'] then
		
		return

	else

		self.battle = true

	end

	if timer.Exists(self.timerName_cooldown) or timer.Exists(self.timerName_capture) then
		
		return

	else

		self.canCapture = true

	end

end

function ENT:Use(ply, caller)

	if self.battle and self.canCapture then

		if self.SOCC then
		
			self.SOCC = false
			self.battle = false
			self.canCapture = false
			self.teamCapture = caller:getJobTable()['category']
			self:SetNWBool('captureActive', true)
			self:SetNWString('teamCapture', self.teamCapture)
			self:EmitSound('buttons/weapon_confirm.wav')

			for k,v in pairs(player.GetAll()) do

				if v:getJobTable()['category'] == self:GetNWString('pointTeam') then
			
					DarkRP.notify(v, 0, 3, 'Точку BP-' .. tonumber(self:GetNWInt('pointNum', 0)) .. ' пытаются захватить ' .. self.teamCapture .. '!')

				end

			end

			timer.Create(self.timerName_capture, self.delay_capture, 1, function()

				if not table.IsEmpty(ents.checkPlayer(self:GetPos(), self.radius, self.teamCapture)) then

					if self.teamCapture == CONFIG.f_faction then

						DarkWar.f_faction_kills = DarkWar.f_faction_kills + CONFIG.capture_goal

						for k,v in pairs(player.GetAll()) do
						
							v:SetNWInt(CONFIG.f_faction, DarkWar.f_faction_kills)

						end

					elseif self.teamCapture == CONFIG.s_faction then

						DarkWar.s_faction_kills = DarkWar.s_faction_kills + CONFIG.capture_goal

						for k,v in pairs(player.GetAll()) do
						
							v:SetNWInt(CONFIG.s_faction, DarkWar.s_faction_kills)

						end

					end

					self.SOCC = true 
					self:SetNWString('pointTeam', self.teamCapture)
					self:SetNWString('teamCapture', 'No team')
					self:SetNWBool('captureActive', false)
					self:EmitSound('buttons/blip2.wav')

				else

					self.SOCC = true 
					self.teamCapture = 'No team'
					self:SetNWString('teamCapture', self.teamCapture)
					self:SetNWBool('captureActive', false)
					self:EmitSound('buttons/weapon_cant_buy.wav')

				end
				
				for k,v in pairs(player.GetAll()) do

					if v:getJobTable()['category'] == self:GetNWString('pointTeam') then
						
						DarkRP.notify(v, 0, 3, 'Вы получили ' .. self.prise .. '$ за захват точки!')
						v:addMoney(self.prise)

					end

				end
				
				timer.Create(self.timerName_cooldown, self.delay_cooldown, 1, function() self:EmitSound('buttons/bell1.wav') end)
			
			end)

		end

	else 

		self:EmitSound('buttons/weapon_cant_buy.wav')

	end

end

function ENT:Think()

	self:SetNWInt('capture', math.floor(timer.TimeLeft(self.timerName_capture)))
	self:SetNWInt('cooldown', math.floor(timer.TimeLeft(self.timerName_cooldown)))

end

function ENT:OnRemove()

	timer.Remove(self.timerName_capture)
	timer.Remove(self.timerName_cooldown)
	timer.Remove(self.timerName_prise)

end