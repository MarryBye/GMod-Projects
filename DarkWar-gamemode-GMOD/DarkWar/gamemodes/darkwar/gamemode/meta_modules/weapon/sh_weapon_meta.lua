local wmeta = FindMetaTable('Weapon')

function wmeta:CanBeTakedInArms()

	if not IsValid(self) then return true end

	for i = 1, #GAMEMODE.Config.gunsCategories do

		for j = 1, #GAMEMODE.Config.gunsCategories[i].guns do

			if self:GetClass() ~= GAMEMODE.Config.gunsCategories[i].guns[j].gun then continue end
				
			if not GAMEMODE.Config.gunsCategories[i].canUse[self:GetOwner():GetPlayerClass()] then
					
				return false

			end

		end

	end

	return true

end