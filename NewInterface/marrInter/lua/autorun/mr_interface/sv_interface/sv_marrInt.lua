hook.Add('PlayerInitialSpawn', 'SV_Interface', function(ply)

    timer.Simple(0.1, function()
        
        if ply:GetNWInt('hasAgilityPoints', -1) == -1 then

            ply:SetNWInt('hasAgilityPoints', 100)

        end

        ply.oldSpeed = ply:GetMaxSpeed()

    end)

end)

local delay = 0.1
local curtime = CurTime() + delay

hook.Add('PlayerPostThink', 'Agility_Hook', function(ply)

    if ply:GetNWInt('hasAgilityPoints', -1) == -1 then return end

    if ply:GetNWInt('hasAgilityPoints') == 0 then

        ply:SetMaxSpeed(90)

    elseif ply:GetMaxSpeed() != ply.oldSpeed then

        ply:SetMaxSpeed(ply.oldSpeed)

    end

    if ply:KeyDown(IN_SPEED) and ply:GetVelocity():Length() > 90 then

        if CurTime() >= curtime and ply:GetNWInt('hasAgilityPoints') > 0 then

            ply:SetNWInt('hasAgilityPoints', ply:GetNWInt('hasAgilityPoints') - 1)
            curtime = CurTime() + delay

        end

    elseif ply:GetNWInt('hasAgilityPoints') < 100 and ply:GetNWInt('hasAgilityPoints') >= 0 then

        if CurTime() >= curtime and ply:GetNWInt('hasAgilityPoints') < 100 then

            ply:SetNWInt('hasAgilityPoints', ply:GetNWInt('hasAgilityPoints') + 1)
            curtime = CurTime() + delay

        end

    end

end)