AddCSLuaFile("cl_fonts.lua")

admins = {
    ["superadmin"] = true,
    ["admin"] = true,
    ["operator"] = true
}

groups = {
    ["superadmin"] = "Супер-администратор",
    ["admin"] = "Администратор",
    ["operator"] = "Оператор",
    ["user"] = "Игрок"
}

local blur_mat = Material( "pp/blurscreen" )

blur = function( panel, layers, density, alpha )

    local x, y = panel:LocalToScreen(0, 0)
    surface.SetDrawColor( 255, 255, 255, alpha )
    surface.SetMaterial( blur_mat )
    
    for i = 1, 3 do

        blur_mat:SetFloat( "$blur", ( i / layers ) * density )
        blur_mat:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect( -x, -y, ScrW(), ScrH() )

    end

end

local Request = function(title, title_2, confirm)

    R_Window = vgui.Create("DFrame")
    R_Window:MakePopup()
    R_Window:SetSize(300, 200)
    R_Window:SetPos(ScrW() * 0 - 500, ScrH() / 2 - 100)
    R_Window:SetTitle("")
    R_Window:SetDraggable(false)
    R_Window:ShowCloseButton(false)
    R_Window:SetSizable(false)
    
    R_Window.Paint = function()

        blur(R_Window, 5, 5, 255)
        draw.RoundedBox(3, 0, 0, R_Window:GetWide(), R_Window:GetTall(), Color(0,0,0,200))
        draw.DrawText(title, "Main_Title", R_Window:GetWide() / 2, R_Window:GetTall() / 2 - 50, Color(255,255,255,200), TEXT_ALIGN_CENTER)
        draw.DrawText(" " .. title_2, "Main_Reason", R_Window:GetWide() / 2, R_Window:GetTall() / 2 + 30, Color(255,255,255,200), TEXT_ALIGN_CENTER)

    end

    local R_Logo = vgui.Create("DImage", R_Window)
    R_Logo:SetSize(128, 128)
    R_Logo:SetPos(R_Window:GetWide() / 2 + R_Logo:GetWide() / 2 - 125, R_Window:GetTall() / 2 - R_Logo:GetTall() / 2 - 100)
    R_Logo:SetImage("icons/W_LOGO_S.png")
    
    local R_Text = vgui.Create("DTextEntry", R_Window)
    R_Text:SetSize(250, 30)
    R_Text:SetPos(R_Window:GetWide() / 2 - R_Text:GetWide() / 2, R_Window:GetTall() / 2 + R_Text:GetTall() / 2 + 45)
    R_Text:SetValue("")
   
    R_Text.Paint = function()

        if R_Text:IsEditing() then
            
            draw.RoundedBox(3, 0, 0, R_Window:GetWide() - 5, R_Window:GetTall(), Color(255,255,255,200))
            draw.DrawText(R_Text:GetValue(), "Main_Request", R_Text:GetWide() / 2, R_Text:GetTall() / 2 - 10, Color(0,0,0,200), TEXT_ALIGN_CENTER)
        
        else

            draw.RoundedBox(3, 0, 0, R_Window:GetWide() - 5, R_Window:GetTall(), Color(210,210,210,200))
            draw.DrawText(R_Text:GetValue(), "Main_Request", R_Text:GetWide() / 2, R_Text:GetTall() / 2 - 10, Color(0,0,0,200), TEXT_ALIGN_CENTER)

        end

    end

    R_Text.OnEnter = function()

        surface.PlaySound("ambient/water/rain_drip3.wav")
        R_Window:Close()
        confirm(R_Text:GetValue())

    end

    local Cancel_Button = vgui.Create("DButton", R_Window)
    Cancel_Button:SetSize(35, 15)
    Cancel_Button:SetPos(R_Window:GetWide() / 2 + Cancel_Button:GetWide() / 2 + 95, R_Window:GetTall() / 2 + Cancel_Button:GetTall() / 2 - 100)
    Cancel_Button:SetText("")
    
    Cancel_Button.Paint = function()

        if Cancel_Button:IsHovered() then
            
            draw.RoundedBox(3, 0, 0, R_Window:GetWide() - 5, R_Window:GetTall(), Color(200,50,50,175))

        else

            draw.RoundedBox(3, 0, 0, R_Window:GetWide() - 5, R_Window:GetTall(), Color(200,200,200,175))

        end

    end
    
    Cancel_Button.DoClick = function()

        R_Window:Close()

    end
    
    R_Window:MoveTo(ScrW() / 2 - R_Window:GetWide() / 2, ScrH() / 2 - R_Window:GetTall() / 2, 0.5, 0, -1, function ()
    
    end)

end

DarkWar.ScoreboardOpen = function()
        
        sb = vgui.Create("DFrame")
        sb:SetSize(500, 600)
        sb:SetPos(ScrW() * 0 - 500, ScrH() / 2 - 300)
        sb:MakePopup()
        sb:SetTitle("HL: DarkWar " .. "| Игроков: " .. #player.GetAll() .. " / " .. game.MaxPlayers())
        sb:SetDraggable(false)
        sb:SetBackgroundBlur(false)
        sb:ShowCloseButton(false)
        
        sb.Paint = function()

            blur(sb, 5, 5, 255)
            draw.RoundedBox(12, 0, 0, sb:GetWide(), sb:GetTall(), Color(0,0,0,200))
            draw.DrawText("                     Игрок", "Main_Small", 0, 25, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT)
            draw.DrawText("K        D        P", "Main_Small", 380, 25, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT)

        end
 
        local sb_scr = vgui.Create("DScrollPanel", sb)
        sb_scr:Dock(BOTTOM)
        sb_scr:SetSize(500, 545)
        
        local sbar = sb_scr:GetVBar()
        sbar.LerpTarget = 0

        function sbar:AddScroll(dlta)

            local OldScroll = self.LerpTarget or self:GetScroll()
            dlta = dlta * 25
            self.LerpTarget = math.Clamp(self.LerpTarget + dlta, -self.btnGrip:GetTall(), self.CanvasSize + self.btnGrip:GetTall())

            return OldScroll ~= self:GetScroll()
        
        end

        sbar.Think = function(s)
        
            local frac = FrameTime() * 5 

            if (math.abs(s.LerpTarget - s:GetScroll()) <= (s.CanvasSize / 10)) then

                frac = FrameTime() * 2 

            end

            local newpos = Lerp(frac, s:GetScroll(), s.LerpTarget)
            s:SetScroll(math.Clamp(newpos, 0, s.CanvasSize))

            if (s.LerpTarget < 0 and s:GetScroll() <= 0) then
            
                s.LerpTarget = 0
        
            elseif (s.LerpTarget > s.CanvasSize and s:GetScroll() >= s.CanvasSize) then

                s.LerpTarget = s.CanvasSize

            end

        end    

        sb_scr.VBar:SetWide(0)

        local players = table.Copy(player.GetAll())
        table.sort(players, function(a, b) 

            return a:Team() < b:Team()
        
        end)

    for k,v in pairs(players) do
        
        local sb_ply = sb_scr:Add("DButton")
        sb_ply:Dock(TOP)
        sb_ply:DockMargin(0, 0, 0, 1)
        sb_ply:SetSize(500, 30)
        sb_ply:SetText("")
        
        sb_ply.Paint = function()

            if sb_ply:IsHovered() then
                
                draw.RoundedBox(12, 0, 0, sb:GetWide(), sb:GetTall(), Color(175,175,175,255))
                draw.DrawText(v:Nick(), "Main_Small", 40, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT)
                draw.DrawText(v:GetNWInt('kills_dwr'), "Main_Small", 380, 5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
                draw.DrawText(v:Deaths(), "Main_Small", 430, 5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
                draw.DrawText(v:Ping(), "Main_Small", 477, 5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
            
            else

                draw.RoundedBox(12, 0, 0, sb:GetWide(), sb:GetTall(), team.GetColor(v:Team()))
                draw.DrawText(v:Nick(), "Main_Small", 40, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT)
                draw.DrawText(v:GetNWInt('kills_dwr'), "Main_Small", 380, 5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
                draw.DrawText(v:Deaths(), "Main_Small", 430, 5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
                draw.DrawText(v:Ping(), "Main_Small", 477, 5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)

            end
        
        end

        sb_ply.OnCursorEntered = function()

            surface.PlaySound("ambient/water/rain_drip1.wav")

        end
        
        sb_ply.DoRightClick = function()

            surface.PlaySound("ambient/water/rain_drip3.wav")
            
            local Menu = DermaMenu(sb_ply)
            
            Menu.Paint = function()
                
                draw.RoundedBox(12, 0, 0, Menu:GetWide(), Menu:GetTall(), Color(255,255,255,200))
            
            end
            
            local player_info, player_info_cfg = Menu:AddSubMenu("Информация")
            player_info_cfg:SetIcon("icon16/information.png")
            
            player_info.Paint = function()
                
                draw.RoundedBox(12, 0, 0, player_info:GetWide(), player_info:GetTall(), Color(255,255,255,200))
            
            end

            local inf_1 = player_info:AddOption("Привелегия: " .. groups[LocalPlayer():GetUserGroup()])
            inf_1:SetIcon("icon16/award_star_gold_3.png")
            local inf_2 = player_info:AddOption("Профессия: " .. v:getDarkRPVar("job"))
            inf_2:SetIcon("icon16/bug.png")
            local inf_3 = player_info:AddOption("Звание: " .. v:GetNWString('Rank', 'No value'))
            inf_3:SetIcon(v:GetNWString('Icon', 'No value'))
            local inf_4 = player_info:AddOption("Наличные: " .. v:getDarkRPVar("money") .. "$")
            inf_4:SetIcon("icon16/coins.png")
            local inf_5 = player_info:AddOption("Статистика: " .. v:Health() .. "/" .. v:Armor())
            inf_5:SetIcon("icon16/heart.png")

            local player_acts, player_acts_cfg = Menu:AddSubMenu("Действия")
            player_acts_cfg:SetIcon("icon16/brick.png")
            
            player_acts.Paint = function()

                draw.RoundedBox(12, 0, 0, player_acts:GetWide(), player_acts:GetTall(), Color(255,255,255,200))

            end

            local act_1 = player_acts:AddOption("Скопировать SteamID", function() SetClipboardText(v:SteamID()) end)
            act_1:SetIcon("icon16/book_go.png")
            local act_2 = player_acts:AddOption("Скопировать имя", function() SetClipboardText(v:Nick()) end)
            act_2:SetIcon("icon16/book_addresses.png")
            local act_3 = player_acts:AddOption("Посмотреть профиль", function() v:ShowProfile() end)
            act_3:SetIcon("icon16/group_go.png")
            local act_4 = player_acts:AddOption("Заглушить", function() v:SetMuted(true) end)
            act_4:SetIcon("icon16/bell_add.png")
            local act_5 = player_acts:AddOption("Разглушить", function() v:SetMuted(false) end)
            act_5:SetIcon("icon16/bell_delete.png")

            if admins[LocalPlayer():GetUserGroup()] then
                
                local admin_acts, admin_acts_cfg = Menu:AddSubMenu("Администратор")
                admin_acts_cfg:SetIcon("icon16/cog.png")
                
                admin_acts.Paint = function()

                    draw.RoundedBox(12, 0, 0, admin_acts:GetWide(), admin_acts:GetTall(), Color(255,255,255,200))

                end

                local admin_category_1, admin_category_1_cfg = admin_acts:AddSubMenu("Телепорты")
                admin_category_1_cfg:SetIcon("icon16/arrow_refresh_small.png")
                
                admin_category_1.Paint = function()

                    draw.RoundedBox(12, 0, 0, admin_category_1:GetWide(), admin_category_1:GetTall(), Color(255,255,255,200))

                end

                local admin_act_1 = admin_category_1:AddOption("Телепортироваться", function() RunConsoleCommand("ulx", "goto", v:Nick()) end)
                admin_act_1:SetIcon("icon16/arrow_up.png")
                local admin_act_2 = admin_category_1:AddOption("Телепортировать", function() RunConsoleCommand("ulx", "bring", v:Nick()) end)
                admin_act_2:SetIcon("icon16/arrow_down.png")
                local admin_category_2, admin_category_2_cfg = admin_acts:AddSubMenu("Ограничения")
                admin_category_2_cfg:SetIcon("icon16/delete.png")
                
                admin_category_2.Paint = function()

                    draw.RoundedBox(12, 0, 0, admin_category_2:GetWide(), admin_category_2:GetTall(), Color(255,255,255,200))

                end

                local admin_act_3 = admin_category_2:AddOption("Замутить", function() RunConsoleCommand("ulx", "mute", v:Nick()) end)
                admin_act_3:SetIcon("icon16/control_stop_blue.png")
                local admin_act_4 = admin_category_2:AddOption("Размутить", function() RunConsoleCommand("ulx", "unmute", v:Nick()) end)
                admin_act_4:SetIcon("icon16/control_play_blue.png")
                local admin_act_5 = admin_category_2:AddOption("Зафризить", function() RunConsoleCommand("ulx", "freeze", v:Nick()) end)
                admin_act_5:SetIcon("icon16/keyboard_mute.png")
                local admin_act_6 = admin_category_2:AddOption("Разфризить", function() RunConsoleCommand("ulx", "unfreeze", v:Nick()) end)
                admin_act_6:SetIcon("icon16/keyboard.png")
                local admin_category_3, admin_category_3_cfg = admin_acts:AddSubMenu("Наказания")
                admin_category_3_cfg:SetIcon("icon16/anchor.png")
                
                admin_category_3.Paint = function()

                    draw.RoundedBox(12, 0, 0, admin_category_3:GetWide(), admin_category_3:GetTall(), Color(255,255,255,200))

                end
                
                local admin_act_7 = admin_category_3:AddOption("Кикнуть", function()
                
                    Request("Кикнуть", "Вы хотите кикнуть по причине: ", function(t)
                        
                        RunConsoleCommand("ulx", "kick", v:Nick(), t) 
                
                    end)
                
                end)
                
                admin_act_7:SetIcon("icon16/disconnect.png")
                local admin_act_8 = admin_category_3:AddOption("Посадить в тюрьму", function()
                
                    Request("Посадить в тюрьму", "Вы хотите посадить в тюрьму на: ", function(t)
                        
                        RunConsoleCommand("ulx", "jail", v:Nick(), t) 
                
                    end)
                
                end)

                admin_act_8:SetIcon("icon16/clock.png")
                local admin_act_9 = admin_category_3:AddOption("Забанить", function() 
                
                    Request("Забанить", "Вы хотите забанить на: ", function(t)
                        
                        Request("Забанить", "Вы хотите забанить по причине: ", function(s)
                            
                            RunConsoleCommand("ulx", "ban", v:Nick(), t, s) 
                
                        end)
                
                    end)
                
                end)
                
                admin_act_9:SetIcon("icon16/clock_red.png")
                local admin_category_4, admin_category_4_cfg = admin_acts:AddSubMenu("Другое")
                admin_category_4_cfg:SetIcon("icon16/briefcase.png")
                
                admin_category_4.Paint = function()

                    draw.RoundedBox(12, 0, 0, admin_category_4:GetWide(), admin_category_4:GetTall(), Color(255,255,255,200))

                end
                
                local admin_act_9 = admin_category_4:AddOption("Убить", function() RunConsoleCommand("ulx", "slay", v:Nick()) end)
                admin_act_9:SetIcon("icon16/cross.png")

            end

            Menu:Open()
        
        end
        
        local sb_ply_av = vgui.Create("AvatarImage", sb_ply)
        sb_ply_av:Dock(LEFT)
        sb_ply_av:SetSize(30, 30)
        sb_ply_av:SetPlayer(v, 64)
    
    end
    
    sb:MoveTo(ScrW() / 2 - 250, ScrH() / 2 - 300, 0.5, 0, -1, function ()
    
    end)

    return false

end

hook.Add("ScoreboardShow", "ScoreboardOpen", DarkWar.ScoreboardOpen)

DarkWar.ScoreboardClose = function()
        
        sb:MoveTo(ScrW() + 500, ScrH() / 2 - 300, 0.5, 0, -1, function ()
            
            sb:Close()

        end)

end

hook.Add("ScoreboardHide", "ScoreboardClose", DarkWar.ScoreboardClose)