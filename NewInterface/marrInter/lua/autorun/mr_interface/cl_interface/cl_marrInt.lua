local function debugTest()

    hook.Remove('HUDPaint', 'Debug')
    timer.Remove('DeleteDebugHook')

    local timesPreficted = 0

    hook.Add('HUDPaint', 'Debug', function()

        timesPreficted = timesPreficted + 1

        if timesPreficted == 1 then

            for i = 0, 5, 0.5 do

                timer.Simple(i, function()
                    
                    notification.AddLegacy('Вы выиграли ' .. i .. ' миллион долларов!')

                end)

            end

        end

        local ply = LocalPlayer()

        local row = 1
        local col = 1

        for k,v in pairs(clrs) do

            if col == 10 then

                col = 1
                row = row + 1

            end
            
            mr.Box(75 * col, 100 + 75 * row, 50, 50, v, mats['GRADIENT'])
            mr.SimpleText(string.sub(k, 0, 5), 'NormalFontNotify', 75 * col, 125 + 75 * row, clrs['WHITE'], false, 0, 0)

            col = col + 1

        end

        mr.SimpleText(1 .. '. Simple Text / outline inversion', 'NormalFontNotify', 75, 75, clrs['CYAN'], true, 0, 0)
        mr.SimpleText(2 .. '. Simple Text / outline without inversion', 'NormalFontNotify', 75, 100, clrs['CYAN'], false, 0, 0)

        mr.SmartText(75, 125, 'NormalFontNotify', true, 0, 0, clrs['CYAN'], 3, '. Smart Text ', clrs['WHITE'], ' / ', clrs['GREEN'], 'outline inversion')
        mr.SmartText(75, 150, 'NormalFontNotify', false, 0, 0, clrs['CYAN'], 4, '. Smart Text ', clrs['WHITE'], ' / ', clrs['RED'], 'outline without inversion')

    end)

    timer.Create('DeleteDebugHook', 10, 1, function() hook.Remove('HUDPaint', 'Debug') end)

end

local toHide = {
	
    ['CHudHealth'] = true,
    ['CHudBattery'] = true,
    ['CHudSuitPower'] = true,
    ['CHudAmmo'] = true,
    ['CHudSecondaryAmmo'] = true,
    ['CHudZoom'] = true,
    ['CHudDeathNotice'] = true,
    ['CHudPoisonDamageIndicator'] = true,
    ['CHudDamageIndicator'] = true,
    ['CHudCrosshair'] = true

}

hook.Add('HUDShouldDraw', 'HideHUD', function(name)
	
    if toHide[name] then
		
        return false
	
    end

end)

local function attHUD()

    if !IsValid(attMainFrame) then

        attMainFrame = vgui.Create('DPanel')
        attMainFrame:SetSize(scrw * 0.1, scrh * 0.12)
        attMainFrame:SetPos(3, scrh - attMainFrame:GetTall() - 3)

        attMainFrame.Paint = function(pnl, w, h)

            mr.Box(0, 0, w, h, clrs['TRANSPARENT'])

        end

        local healthPanel = vgui.Create('DPanel', attMainFrame)
        healthPanel:SetSize(attMainFrame:GetWide(), attMainFrame:GetTall() / 3.15)
        healthPanel:SetPos(0, attMainFrame:GetTall() / 3 * 2)
        healthPanel.lerpAnimationBar = 0
        healthPanel.lerpAnimation = -healthPanel:GetWide()
        healthPanel.panelAlive = true

        healthPanel.Think = function(pnl)

            if hp <= 0 then 

                pnl.lerpAnimation = -Lerp(0.05, -pnl.lerpAnimation, pnl:GetWide())

            else

                pnl.lerpAnimation = Lerp(0.1, pnl.lerpAnimation, 3)

            end

            pnl.lerpAnimationBar = Lerp(0.1, pnl.lerpAnimationBar, hp)

        end

        healthPanel.Paint = function(pnl, w, h)

            mr.Box(pnl.lerpAnimation, 0, w, h, clrs['BLACK']:colorAlphaChange(255), mats['GRADIENT'])
            mr.Box(pnl.lerpAnimation + 2, 2, math.Clamp(pnl.lerpAnimationBar, 0, mhp) * (w / 100) - 4, h - 4, clrs['RED']:colorAlphaChange(155), mats['GRADIENT'])
            mr.SmartText(pnl.lerpAnimation + 2, h / 2, 'NormalFontHUD', false, 0, 1, clrs['RED'], 'HEALTH: ', clrs['WHITE'], hp)

        end

        local armorPanel = vgui.Create('DPanel', attMainFrame)
        armorPanel:SetSize(attMainFrame:GetWide(), attMainFrame:GetTall() / 3.15)
        armorPanel:SetPos(0, attMainFrame:GetTall() / 3)
        armorPanel.lerpAnimationBar = 0
        armorPanel.lerpAnimation = -armorPanel:GetWide()
        armorPanel.panelAlive = true

        armorPanel.Think = function(pnl)
            
            if ar <= 0 then 

                pnl.lerpAnimation = -Lerp(0.05, -pnl.lerpAnimation, pnl:GetWide())

            else

                pnl.lerpAnimation = Lerp(0.1, pnl.lerpAnimation, 3)

            end

            pnl.lerpAnimationBar = Lerp(0.1, pnl.lerpAnimationBar, ar)

        end

        armorPanel.Paint = function(pnl, w, h)

            mr.Box(pnl.lerpAnimation, 0, w, h, clrs['BLACK']:colorAlphaChange(255), mats['GRADIENT'])
            mr.Box(pnl.lerpAnimation + 2, 2, math.Clamp(pnl.lerpAnimationBar, 0, mar) * (w / 100) - 4, h - 4, clrs['NAVY']:colorAlphaChange(155), mats['GRADIENT'])
            mr.SmartText(pnl.lerpAnimation + 2, h / 2, 'NormalFontHUD', false, 0, 1, clrs['BLUE'], 'ARMOR: ', clrs['WHITE'], ar)

        end

        local agilityPanel = vgui.Create('DPanel', attMainFrame)
        agilityPanel:SetSize(attMainFrame:GetWide(), attMainFrame:GetTall() / 3.15)
        agilityPanel:SetPos(0, 0)
        agilityPanel.lerpAnimationBar = 0
        agilityPanel.lerpAnimation = -agilityPanel:GetWide()
        agilityPanel.panelAlive = true

        agilityPanel.Think = function(pnl)
            
            if not ply:KeyDown(IN_SPEED) then 

                pnl.lerpAnimation = -Lerp(0.05, -pnl.lerpAnimation, pnl:GetWide())

            elseif speed > 90 then

                pnl.lerpAnimation = Lerp(0.1, pnl.lerpAnimation, 3)

            end

            pnl.lerpAnimationBar = Lerp(0.1, pnl.lerpAnimationBar, ar)

        end

        agilityPanel.Paint = function(pnl, w, h)

            mr.Box(pnl.lerpAnimation, 0, w, h, clrs['BLACK']:colorAlphaChange(255), mats['GRADIENT'])
            mr.Box(pnl.lerpAnimation + 2, 2, math.Clamp(pnl.lerpAnimationBar, 0, mar) * (w / 100) - 4, h - 4, clrs['YELLOW']:colorAlphaChange(155), mats['GRADIENT'])
            mr.SmartText(pnl.lerpAnimation + 2, h / 2, 'NormalFontHUD', false, 0, 1, clrs['YELLOW'], 'AGILITY: ', clrs['WHITE'], ply:GetNWInt('hasAgilityPoints', -1))

        end

    end

end

hook.Add('HUDPaint', 'DrawMainInterface', function()

    attHUD()

end)

--debugTest()