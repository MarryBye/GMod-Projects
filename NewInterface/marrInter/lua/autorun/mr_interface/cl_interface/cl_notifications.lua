local notification = notification

function notification.AddLegacy(text)

    if !IsValid(notification.notifyScroll) then

        notification.notifyScroll = vgui.Create("DScrollPanel")
        notification.notifyScroll:SetPos(0, 0)
        notification.notifyScroll:SetSize(scrw * 0.25, scrh * 0.15)
        
        notification.notifyScroll.Paint = function(pnl, w, h)

            mr.Box(0, 0, w, h, clrs['TRANSPARENT'])

        end

    end

    local notifyScroll_Children = notification.notifyScroll:GetChildren()
    notifyScroll_Children[2]:SetWidth(0)

    notifyInScroll = notification.notifyScroll:Add('DButton')
    notifyInScroll:Dock(TOP)
    notifyInScroll:DockMargin(1,1,1,1)
    notifyInScroll:SetText('')
    notifyInScroll:SetTall(25)
    notifyInScroll.lerpAnimation = -notification.notifyScroll:GetWide()
    notifyInScroll.panelAlive = true

    notifyInScroll.lifeTime = CurTime() + 5

    notifyInScroll.Think = function(pnl)

        if pnl.panelAlive then

            pnl.lerpAnimation = Lerp(0.1, pnl.lerpAnimation, 0)

        else

            pnl.lerpAnimation = -Lerp(0.05, -pnl.lerpAnimation, pnl:GetWide())

        end

        if pnl.lifeTime <= CurTime() then 

            pnl.panelAlive = false

            if -pnl.lerpAnimation > notification.notifyScroll:GetWide() - 3 then

                pnl:Remove()

            end

        end

    end

    notifyInScroll.Paint = function(pnl, w, h)
        
        mr.Box(pnl.lerpAnimation, 0, w, h, clrs['BLACK']:colorAlphaChange(255), mats['GRADIENT'])
        mr.Box(pnl.lerpAnimation + 2, 2, w - 4, h - 4, clrs['NAVY']:colorAlphaChange(155), mats['GRADIENT'])
        mr.SimpleText(text, 'NormalFontNotify', pnl.lerpAnimation + 2, 0, clrs['WHITE'], false, 0, 0)

    end
    
    MsgC(clrs['RED'], '[NOTIFY] ', clrs['WHITE'], text, '\n')
    
    timer.Remove('SmoothScrollTimer')
    timer.Create('SmoothScrollTimer', 0.1, 1, function()
        
        notification.notifyScroll:ScrollToChild(notifyInScroll)

    end)

end
--notification.notifyScroll:Remove()