AddCSLuaFile("cl_fonts.lua")

jobCounter = function(team)

    local count = 0

    for k,v in pairs(player.GetAll()) do

        if v:Team() == team then
           
            count = count + 1
        
        end

    end

    return count

end

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

net.Receive("f4menu", function() 

    local f4 = vgui.Create("DFrame")
    f4:SetSize(750, 750)
    f4:SetPos(ScrW() * 0 - 750, ScrH() / 2 - 375)
    f4:SetTitle("Выбор роли")
    f4:MakePopup()
    f4:SetDraggable(false)
    f4:ShowCloseButton(false)
    
    f4.Paint = function()

        blur(f4, 5, 5, 255)
        draw.RoundedBox(3, 0, 0, f4:GetWide(), f4:GetTall(), Color(0,0,0,200))
        draw.DrawText("Модель", "F4_Main", 35, 25, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
        draw.DrawText("Роль и зарплата", "F4_Main", f4:GetWide() / 2, 25, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
        draw.DrawText("Места", "F4_Main", f4:GetWide() / 2 + 340, 25, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)

    end

    local scroller = vgui.Create("DScrollPanel", f4)
    local sbar = scroller:GetVBar()
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

    scroller:Dock(BOTTOM)
    scroller:SetSize(750, 695)
    sbar:SetWide(0)

    local Close_Button = vgui.Create("DButton", f4)
    Close_Button:SetSize(35, 15)
    Close_Button:SetPos(f4:GetWide() / 2 + Close_Button:GetWide() / 2 + 315, f4:GetTall() / 2 + Close_Button:GetTall() / 2 - 375)
    Close_Button:SetText("")
    
    Close_Button.Paint = function()

        if Close_Button:IsHovered() then
            
            draw.RoundedBox(3, 0, 0, f4:GetWide() - 5, f4:GetTall(), Color(200,50,50,175))

        else

            draw.RoundedBox(3, 0, 0, f4:GetWide() - 5, f4:GetTall(), Color(200,200,200,175))

        end

    end
    
    Close_Button.DoClick = function()

        f4:Close()

    end

    for i = 1,table.maxn(RPExtraTeams) do

        local job_button = vgui.Create("DButton", scroller)
        job_button:SetSize(750, 75)
        job_button:Dock(TOP)
        job_button:DockMargin(0, 0, 0, 1)
        job_button:SetText("")

        job_button.Paint = function()
                    
            if job_button:IsHovered() then
					
				draw.RoundedBox(3, 0, 0, job_button:GetWide(), job_button:GetTall(), Color(175,175,175,255))
				
			else
                    
                draw.RoundedBox(3, 0, 0, job_button:GetWide(), job_button:GetTall(), RPExtraTeams[i]["color"])

            end

			draw.DrawText(RPExtraTeams[i]["name"], "F4_Main", job_button:GetWide() / 2, job_button:GetTall() / 2 - 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
            draw.DrawText(jobCounter(RPExtraTeams[i]["team"]) .. " / " .. RPExtraTeams[i]["max"], "F4_Main", job_button:GetWide() - 30, job_button:GetTall() / 2 - 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
            draw.DrawText("+" .. RPExtraTeams[i]["salary"] .. "$", "F4_Main", job_button:GetWide() / 2, job_button:GetTall() / 2 - 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)

        end

        job_button.OnCursorEntered = function()

			surface.PlaySound("ambient/water/rain_drip1.wav")

		end
			
		job_button.DoClick = function()

			surface.PlaySound("ambient/water/rain_drip3.wav")
            RunConsoleCommand("say", "/" .. RPExtraTeams[i]["command"])

		end

        local model_bg = vgui.Create("DPanel", job_button)
        model_bg:SetSize(75, 75)
        model_bg:SetBackgroundColor(Color(255,255,255,255))
        model_bg:SetPos(0, 0)
        model_bg.Paint = function()

			draw.RoundedBox(3, 0, 0, job_button:GetWide(), job_button:GetTall(), Color(45,45,45,255))

		end
        
        local model_img = vgui.Create("SpawnIcon", model_bg)
        model_img:SetModel(RPExtraTeams[i]["model"][1])
	    model_img:SetSize(75, 75)
        model_img:Dock(LEFT)
	    model_img:SetDisabled(true)

    end

    f4:MoveTo(ScrW() / 2 - 375, ScrH() / 2 - 375, 0.5, 0, -1, function ()
    
    end)

end)