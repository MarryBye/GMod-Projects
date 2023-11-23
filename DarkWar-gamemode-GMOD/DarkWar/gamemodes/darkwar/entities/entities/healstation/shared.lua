ENT.Base = "base_gmodentity"
ENT.Type = "anim"

ENT.PrintName = "Станция лечения"

ENT.Category = "MarryBye"
ENT.Purpose = "Выдает ХП"

ENT.Author = "MarryBye"

ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:GetReadyToHeal()

	if SERVER then return self.ReadyToHeal end
	if CLIENT then return self:GetNWBool('ReadyToHeal', true) end

end