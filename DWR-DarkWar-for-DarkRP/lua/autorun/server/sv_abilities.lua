include("autorun/sh_config.lua")
AddCSLuaFile("autorun/sh_config.lua")

function DarkWar.Ability(ply, move)

	if CONFIG.abilities then

		if not timer.Exists('ability_cast') and not timer.Exists('ability_cooldown') then
	 		
	 		ply:SetNWBool('canCast', true)

	 	end

		if move:KeyPressed(IN_ZOOM) then

			if ply:GetNWBool('canCast') then

				ply:EmitSound('buttons/weapon_confirm.wav')

				timer.Create('ability_cast', 1, 10, function()

					ply:SetNWBool('canCast', false)
						
					ply:SetHealth(ply:Health() + 3)

				end)

				timer.Create('ability_cooldown', 60, 1, function() 
					
					ply:SetNWBool('canCast', true)
					ply:EmitSound('buttons/blip2.wav')

				end)

			else

				return

			end

		end
	
	end

end

hook.Add('PlayerTick', 'Ability', DarkWar.Ability)