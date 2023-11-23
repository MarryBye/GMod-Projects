include("shared.lua")
include('autorun/sh_config.lua')

surface.CreateFont( "DEALER_HEAD_NAME", { font = "Trebuchet MS", size = 35, weight = 1000 } )
surface.CreateFont( "ButtonFont", { font = "Trebuchet MS", size = 20, weight = 500, outline = true } )
surface.CreateFont( "Main_Trade", { font = "Trebuchet MS", extended = true, size = 18, weight = 1000, outline = true })

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

function ENT:Draw()

	self:DrawModel()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Forward(),90)
	ang:RotateAroundAxis(self:GetAngles():Up(),90)
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 500 then

		cam.Start3D2D(self:GetPos() + ang:Right() + ang:Up()* 0,ang,0.1)
			
			draw.SimpleTextOutlined("Торговец оружием", "DEALER_HEAD_NAME", -150, -800,  Color(255,255,255,220), 0, 0, 2,Color(0,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT )
		
		cam.End3D2D()
	
	end

	net.Receive("SGUI", function()

		local frm = vgui.Create("DFrame")
		frm:SetSize(500, 500)
		frm:SetPos(ScrW() * 0 - 500, ScrH() / 2 - 250)
		frm:SetVisible(true)
		frm:MakePopup()
		frm:SetTitle("Торговля")
		frm:SetSizable(false)
		frm:SetDraggable(false)
		frm:ShowCloseButton(false)

		frm.Paint = function()
			
			blur(frm, 5, 5, 255)
			draw.RoundedBox(3, 0, 0, frm:GetWide(), frm:GetTall(), Color(0, 0, 0, 200))
			draw.DrawText("Иконка", "Main_Trade", 30, 25, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER)
			draw.DrawText("Название", "Main_Trade", 250, 25, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER)
			draw.DrawText("Цена", "Main_Trade", 460, 25, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER)

		end

		local scr = vgui.Create("DScrollPanel", frm)
		scr:Dock(BOTTOM)
		scr:SetSize(500, 445)

		local sbar = scr:GetVBar()
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

		scr.VBar:SetWide(0)

    	local Close_Button = vgui.Create("DButton", frm)
    	Close_Button:SetSize(35, 15)
    	Close_Button:SetPos(frm:GetWide() / 2 + Close_Button:GetWide() / 2 + 193, frm:GetTall() / 2 + Close_Button:GetTall() / 2 - 253)
    	Close_Button:SetText("")
    	
    	Close_Button.Paint = function()

        	if Close_Button:IsHovered() then
            
            	draw.RoundedBox(3, 0, 0, frm:GetWide() - 5, frm:GetTall(), Color(200,50,50,175))

        	else

            	draw.RoundedBox(3, 0, 0, frm:GetWide() - 5, frm:GetTall(), Color(200,200,200,175))

        	end

    	end
    
    	Close_Button.DoClick = function()

        	frm:Close()

    	end

		button = function(btn_name, btn_gun_name, btn_gun_class, btn_gun_cost, btn_gun_model)

			local btn_name = scr:Add("DButton")
			btn_name:Dock(TOP)
			btn_name:DockMargin( 0, 0, 0, 1 )
			btn_name:SetSize(500, 50)
			btn_name:SetText("")
			local btn_background = vgui.Create("DPanel", btn_name)
			btn_background:SetSize(50, 50)
			btn_background:SetBackgroundColor(Color(255,255,255,255))
			btn_background:Dock(LEFT)
			
			btn_background.Paint = function()

				draw.RoundedBox(3, 0, 0, btn_name:GetWide(), btn_name:GetTall(), Color(45,45,45,175))

			end

			local btn_model = vgui.Create("SpawnIcon", btn_background)
			btn_model:SetModel(btn_gun_model)
			btn_model:SetSize(50, 50)
			btn_model:SetDisabled(true)

			btn_name.Paint = function()

				draw.SimpleText(btn_gun_name, "ButtonFont", btn_name:GetWide() / 2, btn_name:GetTall() - 35, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
				draw.SimpleText(btn_gun_cost .. "$", "ButtonFont", 475, btn_name:GetTall() - 35, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT)

				if btn_name:IsHovered() then
					
					draw.RoundedBox(3, 0, 0, btn_name:GetWide(), btn_name:GetTall(), Color(175,175,175,175))
				
				end

				if LocalPlayer():getDarkRPVar("money") >= btn_gun_cost then
					
					draw.RoundedBox(3, 0, 0, btn_name:GetWide(), btn_name:GetTall(), Color(45, 45, 45, 175))

				else

					draw.RoundedBox(3, 0, 0, btn_name:GetWide(), btn_name:GetTall(), Color(175, 0, 0, 175))

				end

			end

			btn_name.OnCursorEntered = function()

				surface.PlaySound("ambient/water/rain_drip1.wav")

			end
			
			btn_name.DoClick = function()

				surface.PlaySound("ambient/water/rain_drip3.wav")
				net.Start("SGUI")
				net.WriteString(btn_gun_class)
				net.WriteInt(btn_gun_cost, 32)
				net.WriteEntity(LocalPlayer())
				net.SendToServer()

			end

		end
		
		for i = 1, table.maxn(CONFIG.gun_shop) do

			if table.HasValue(CONFIG.gun_shop[i].allowed, LocalPlayer():Team()) then
			
				button(tostring(i) .. "_button", CONFIG.gun_shop[i].name, CONFIG.gun_shop[i].class, CONFIG.gun_shop[i].cost, CONFIG.gun_shop[i].model)
			
			end

		end

		frm:MoveTo(ScrW() / 2 - 250, ScrH() / 2 - 250, 0.5, 0, -1, function ()
    
    	end)
	
	end)

end
