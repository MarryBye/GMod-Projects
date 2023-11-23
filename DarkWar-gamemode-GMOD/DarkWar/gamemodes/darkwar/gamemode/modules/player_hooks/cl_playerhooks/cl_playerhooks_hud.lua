hook.Add('HUDPaint', 'PlayerInterface_Main', function()

    if not cl_VarsLoaded then return end
    if not lcply:GetAuthorised() then return end

    --local mx, my = gui.MousePos()
    
    -- For isometric camera (in development)
    -- drawIcon(mx - crosshairSize / 2, my - crosshairSize / 2, crosshairSize, crosshairSize, 'materials/crosshair' .. crosshairVar ..'.png', crossColor)
    
    if not lcply_aiming and lcply_alive then
        
        local crossColor = Color(lcply_CrossCol.r, lcply_CrossCol.g, lcply_CrossCol.b, 255)
        drawIcon(scrw / 2 - lcply_CrossSize / 2, scrh / 2 - lcply_CrossSize / 2, lcply_CrossSize, lcply_CrossSize, 'materials/crosshair' .. lcply_CrossVar ..'.png', crossColor)

    end
    
    drawTextWithShadow('K/D: ' .. lcply_kills .. '/' .. lcply_deaths .. ' ( ' .. lcply_kddiv .. ' ) | NPC: ' .. lcply_npcKills, "SMenuFont", scrw / 2, 50, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    
    if not CanContinueMatch() then

        drawTextWithShadow('Начисление статистики приостановлено! Недостаточно игроков!', "MenuFont", scrw / 2, 100, Color(255, 115, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end

    if lcply_spec then

        drawTextWithShadow('Вы в режиме слежки! Для выхода нажмите E.', "MenuFont", scrw / 2, scrh / 1.5, Color(255, 115, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end

    if IsValid(lcply_wep) then
        
        if not lcply_wep_valid then

            drawTextWithShadow('Вы не можете использовать это оружие!', "MenuFont", scrw / 2, scrh / 1.25, Color(255, 115, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        end

    end
    
    -- For isometric camera (in development)
    --[[if not IsValid(cursorHideKostil) then
        
        cursorHideKostil = vgui.Create( "EditablePanel" )
        cursorHideKostil:SetPos(0, 0)
        cursorHideKostil:SetSize(scrw, scrh)
        cursorHideKostil:SetCursor( "blank" )
        
        cursorHideKostil.Paint = function(self, x, y)          
        end

        cursorHideKostil.OnMousePressed = function(self, mkey)

            if lcply:GetLockControls() then return end
        
            if mkey == MOUSE_LEFT then
                
                RunConsoleCommand( "+attack", "" )
            
            end

            if mkey == MOUSE_RIGHT then

                RunConsoleCommand( "+attack2", "" )

            end

            if mkey == MOUSE_MIDDLE then

                lcply:SetEyeAngles(Angle(0, ply:EyeAngles().y, 0))

            end
    
        end

        cursorHideKostil.OnMouseReleased = function(self, mkey )

            if lcply:GetLockControls() then return end
            
            if mkey == MOUSE_LEFT then
                
                RunConsoleCommand( "-attack", "" )
            
            end

            if mkey == MOUSE_RIGHT then

                RunConsoleCommand( "-attack2", "" )

            end
        
        end

        cursorHideKostil.OnMouseWheeled = function(self, dlt)

            if lcply:GetLockControls() then return end

            if dlt == 1 then

                lcply:SetEyeAngles(Angle(ply:EyeAngles().x + 5, ply:EyeAngles().y, 0))

            elseif dlt == -1 then

                lcply:SetEyeAngles(Angle(ply:EyeAngles().x - 5, ply:EyeAngles().y, 0))

            end

        end
    
    end]]

    if IsValid(mainHudFrame) then return end
        
    mainHudFrame = vgui.Create('DFrame')
    mainHudFrame:SetTitle('')
    mainHudFrame:SetSize(200, 180)
    mainHudFrame:SetPos(10, scrh - mainHudFrame:GetTall() - 10)
    mainHudFrame:ShowCloseButton(false)
    mainHudFrame:SetDraggable(false)
    mainHudFrame:SetSizable(false)

    mainHudFrame.Paint = function(self, x, y)

        draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 175))

    end

    local mainHudPanel = vgui.Create('DPanel', mainHudFrame)
    mainHudPanel:SetSize(mainHudFrame:GetWide() - 4, mainHudFrame:GetTall() - 4)
    mainHudPanel:SetPos(2, 2)

    mainHudPanel.Paint = function(self, x, y)

        draw.RoundedBox(0, 0, 0, x, y, Color(25, 25, 25, 115))

        draw.RoundedBox(0, x / 2 - 1, 0, 2, y, Color(0, 0, 0, 115))
        draw.RoundedBox(0, 0, y / 2 - 1, x, 2, Color(0, 0, 0, 115))

        drawTextWithShadow(lcply_hp, "HUDBigFont", 49, 35, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        drawTextWithShadow('Здоровье', "HUDSmallFont", 49, 72, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        drawTextWithShadow(lcply_arm, "HUDBigFont", 49, 120, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        drawTextWithShadow('Броня', "HUDSmallFont", 49, 160, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        drawTextWithShadow(lcply_money, "HUDBigFont", 147, 35, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        drawTextWithShadow('Деньги', "HUDSmallFont", 147, 72, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                
        if lcply_wep_clip1 == -1 or not lcply_wep_valid then 

             drawTextWithShadow('∞', "HUDBigFont", 147, 130, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        else

            drawTextWithShadow(lcply_wep_clip1 or 0, "HUDBigFont", 147, 120, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            drawTextWithShadow(lcply_wep_ammos or 0, "HUDSmallFont", 147, 160, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                
        end
        
    end

    classPanel = vgui.Create('DPanel')
    classPanel:SetSize(mainHudFrame:GetWide(), 30)
    classPanel:SetPos(10, scrh - mainHudFrame:GetTall() - 45)

    classPanel.Paint = function(self, x, y)

        draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 175))
        draw.RoundedBox(0, 2, 2, x - 4, y - 4, Color(25, 25, 25, 115))

        drawTextWithShadow(lcply_class, 'HUDSmallFont', x / 2, y / 2, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end

    rankPanel = vgui.Create('DPanel')
    rankPanel:SetSize(mainHudFrame:GetWide(), 30)
    rankPanel:SetPos(10, scrh - mainHudFrame:GetTall() - 80)

    rankPanel.Paint = function(self, x, y)

        draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 175))
        draw.RoundedBox(0, 2, 2, x - 4, y - 4, Color(25, 25, 25, 115))

        drawTextWithShadow(lcply_rank.rankName, 'HUDSmallFont', x / 2, y / 2, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end

    scorePanel = vgui.Create('DPanel')
    scorePanel:SetSize(100, 30)
    scorePanel:SetPos(scrw / 2 - scorePanel:GetWide() / 2, 5)

    scorePanel.Paint = function(self, x, y)

        draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 175))
        draw.RoundedBox(0, 2, 2, x - 4, y - 4, Color(25, 25, 25, 115))

        drawTextWithShadow(' : ', 'HUDSmallFont', x / 2, y / 2, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        if lcply_team == GAMEMODE.Config.firstTeamName then
    
            drawTextWithShadow(GetConVar(GAMEMODE.Config.firstTeamName):GetInt(), 'HUDSmallFont', x / 2 - 8, y / 2, Color(0, 75, 200, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            drawTextWithShadow(GetConVar(GAMEMODE.Config.secondTeamName):GetInt(), 'HUDSmallFont', x / 2 + 8, y / 2, Color(200, 35, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        elseif lcply_team == GAMEMODE.Config.secondTeamName then

            drawTextWithShadow(GetConVar(GAMEMODE.Config.firstTeamName):GetInt(), 'HUDSmallFont', x / 2 - 8, y / 2, Color(200, 35, 0, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            drawTextWithShadow(GetConVar(GAMEMODE.Config.secondTeamName):GetInt(), 'HUDSmallFont', x / 2 + 8, y / 2, Color(0, 75, 200, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        else

            drawTextWithShadow(GetConVar(GAMEMODE.Config.firstTeamName):GetInt(), 'HUDSmallFont', x / 2 - 8, y / 2, Color(200, 200, 200, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            drawTextWithShadow(GetConVar(GAMEMODE.Config.secondTeamName):GetInt(), 'HUDSmallFont', x / 2 + 8, y / 2, Color(200, 200, 200, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        end

    end

end)

-- For isometric camera (in development)
--[[function GM:CalcView(ply, pos, ang, fov)

    local mx, my = gui.MousePos()
    local mouse3d = gui.ScreenToVector(mx, my)
    local mouse3d_ang = mouse3d:Angle()
    local posHead = ply:GetEyeTrace().StartPos

    local tr = util.TraceLine( {
        
        start = posHead,
        endpos = Vector(posHead.x, posHead.y, posHead.z + 625), 
        filter = function(ply) if ply:IsPlayer() then return false end end
    
    })

    local view = {

        origin = Vector(pos.x - 100, pos.y, pos.z),
        angles = ang,
        fov = fov,
        drawviewer = true

    }

    local view = {

        origin = Vector(pos.x, pos.y, tr.HitPos.z),
        angles = Angle(90, 0, ang.z),
        fov = 60,
        drawviewer = true

    }    

    if not ply:Alive() or not IsValid(ply) or ply:GetLockControls() then return view end

    local cameraPos_x, cameraPos_y = pos.x + mouse3d.x * 100, pos.y + mouse3d.y * 100

    ply:SetEyeAngles(Angle(ply:EyeAngles().x, mouse3d_ang.y, 0))

    if tr.HitPos:Distance(posHead) < 200 then

        fov = 90

    else fov = 60 end

    local view = {

        origin = Vector(cameraPos_x, cameraPos_y, tr.HitPos.z),
        angles = Angle(90, 0, ang.z),
        fov = fov,
        drawviewer = true
    }
            
    gui.EnableScreenClicker(not lcply:GetLockControls())

    return view

end

hook.Add('OpenSomeDermaWindow', 'TEST', function(cl, pn, n, ...)

    if cl == 'DFrame' then

        lcply:LockControls(true)

    end

end)

hook.Add('CloseSomeDermaWindow', 'TEST2', function(panel)

    lcply:LockControls(false)

end)

hook.Add( "PostPlayerDraw" , "manual_model_draw_example" , function( ply )
    
    if ply ~= lcply or lcply:Health() < 0 or not IsValid(lcply) then return end

    if lcply_aiming then
        
        local posHead = ply:GetEyeTrace().StartPos
        local hitPos = ply:GetEyeTrace().HitPos

        local tr = util.TraceLine( {
        
            start = hitPos,
            endpos = Vector(hitPos.x, hitPos.y, 0), 
            filter = function() return true end
    
        })

        local tracerColor = Color(50, 200, 0, 255)

        if lcply:GetEyeTrace().Entity:IsPlayer() or lcply:GetEyeTrace().Entity:IsNPC() then

            tracerColor = Color(200, 50, 0, 255)

        end
        
        render.DrawLine(posHead, hitPos, tracerColor)

    end

end)]]

-- Chatbox (IN DEVELOPMENT! DOES NOT WORKING!!!!!)
--[[local marrychat = {}
marrychat.messages = {}

function GM:StartChat(t)

    if not IsValid(marrychat.chatBoxMainWindow) then 

        marrychat.chatBoxMainWindow = vgui.Create('DPanel')
        marrychat.chatBoxMainWindow:SetSize(600, 250)
        marrychat.chatBoxMainWindow:SetPos(scrw / 2 - marrychat.chatBoxMainWindow:GetWide() / 2, scrh - (marrychat.chatBoxMainWindow:GetTall() + 5))

        marrychat.chatBoxMainWindow.Paint = function(self, x, y)

            draw.RoundedBox(0, 0, 0, x, y, Color(12, 12, 12, 175))

        end

        marrychat.chatBoxTextEntry = vgui.Create('DTextEntry', marrychat.chatBoxMainWindow)
        marrychat.chatBoxTextEntry:SetSize(0, 30)
        marrychat.chatBoxTextEntry:Dock(BOTTOM)
        marrychat.chatBoxTextEntry:DockMargin(3, 3, 3, 3)
        marrychat.chatBoxTextEntry:SetEditable(true)

        marrychat.chatBoxScroll = vgui.Create('DScrollPanel', marrychat.chatBoxMainWindow)
        marrychat.chatBoxScroll:Dock(FILL)
        marrychat.chatBoxScroll:DockMargin(3, 3, 3, 0)
        marrychat.chatBoxScroll.VBar:SetWide(0)

        marrychat.chatBoxScroll.Paint = function(self, x, y)

            draw.RoundedBox(0, 0, 0, x, y, Color(12, 12, 12, 115))

        end

        for i = 1, table.maxn(marrychat.messages) do

            if not marrychat.messages[i] then continue end

            marrychat.oldMessages = marrychat.chatBoxScroll:Add('DLabel')
            marrychat.oldMessages:SetFont("SMenuFont")
            marrychat.oldMessages:SetText(marrychat.messages[i]._str)
            marrychat.oldMessages:SizeToContents()

            marrychat.oldMessages.msg = true

            local toAdd = 0

            for i = 1, table.maxn(marrychat.chatBoxScroll:GetChildren()[1]:GetChildren()) do

                local labelChild = marrychat.chatBoxScroll:GetChildren()[1]:GetChildren()[i]

                if not labelChild then continue end
                if not labelChild:GetClassName() == 'DLabel' then continue end
                if not labelChild.msg then continue end

                toAdd = toAdd + labelChild:GetTall() + 3

            end

            marrychat.oldMessages:SetPos(3, toAdd - 45)

        end

    end

    hook.Call('StartChat')

    return true

end

function GM:ChatTextChanged(str)

    marrychat.chatBoxTextEntry:SetValue(str)

    hook.Call('ChatTextChanged')

end

function GM:FinishChat()

    if IsValid(marrychat.chatBoxMainWindow) then marrychat.chatBoxMainWindow:Remove() end

    hook.Call('FinishChat')

end

function chat.AddText(str)

    marrychat.messages[#marrychat.messages + 1] = {_str = str}

end

function GM:OnPlayerChat(ply, str, t, d)

    chat.AddText(ply:Nick() .. ': ' .. str)

    hook.Call('OnPlayerChat')

    return true

end]]