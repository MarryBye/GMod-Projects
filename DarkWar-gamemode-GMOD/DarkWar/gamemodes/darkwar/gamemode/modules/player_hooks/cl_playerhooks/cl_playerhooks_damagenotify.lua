local boneName = {

    [HITGROUP_HEAD] = 'Голова',
    [HITGROUP_CHEST] = 'Тело',
    [HITGROUP_STOMACH] = 'Живот',
    [HITGROUP_LEFTARM] = 'Левая рука',
    [HITGROUP_RIGHTARM] = 'Правая рука',
    [HITGROUP_LEFTLEG] = 'Левая нога',
    [HITGROUP_RIGHTLEG] = 'Правая нога'

}

local damage = 0

hook.Add('HUDPaint', 'PlayerInterface_DrawVisualDamage', function()

    if not cl_VarsLoaded then return end
    if not lcply:GetAuthorised() then return end

    --local mx, my = gui.MousePos()

    -- For isometric camera (in development)
    --drawIcon(mx - indicatorSize / 2, my - indicatorSize / 2, indicatorSize, indicatorSize, 'materials/indicator' .. indicatorVar ..'.png', hitIndicatorColor)
    
    if lcply_damaged then

        local hitIndicatorColor = Color(lcply_DmgCol.r, lcply_DmgCol.g, lcply_DmgCol.b, 255)
        drawIcon(scrw / 2 - lcply_DmgSize / 2, scrh / 2 - lcply_DmgSize / 2, lcply_DmgSize, lcply_DmgSize, 'materials/indicator' .. lcply_DmgVar ..'.png', hitIndicatorColor)

    end

    if IsValid(damageNotifyMainPanel) then return end

    damageNotifyMainPanel = vgui.Create('DPanel')
    damageNotifyMainPanel:SetSize(380, 250)
    damageNotifyMainPanel:SetPos(scrw - damageNotifyMainPanel:GetWide() - 5, scrh - damageNotifyMainPanel:GetTall() - 5)

    damageNotifyMainPanel.Paint = function(self, x, y)

        draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 0))

    end

    damageNotifyScroll = vgui.Create('DScrollPanel', damageNotifyMainPanel)
    damageNotifyScroll:Dock(FILL)
    damageNotifyScroll.VBar:SetWide(0)

end)

--damageNotifyScroll:addDamageNotifyToPanel('Вы попали в ' .. utf8.sub(ply:Nick(), 0, 15) .. ' нанеся ' .. math.floor(damage) .. ' урона в ' .. boneName[hitgroup])