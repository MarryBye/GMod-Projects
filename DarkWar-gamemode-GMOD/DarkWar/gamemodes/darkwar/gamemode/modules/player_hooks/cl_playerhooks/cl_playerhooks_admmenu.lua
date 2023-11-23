net.Receive('OpenAdminMenu', function()

	local playerChoosed = 'NONE'

	hook.Add('HUDPaint', 'PlayerInterface_DrawAdminMenu', function()

		if not cl_VarsLoaded then return end
		if IsValid(adminMenuMainWindow) then adminMenuMainWindow:Remove() return end

		--LocalPlayer():LockControls(true)

        adminMenuMainWindow = vgui.Create('DPanel')
        adminMenuMainWindow:MakePopup()
        adminMenuMainWindow:SetSize(scrw / 3, 500)
        adminMenuMainWindow:SetPos(scrw / 2 - adminMenuMainWindow:GetWide() / 2, scrh / 2 - adminMenuMainWindow:GetTall() / 2)
        adminMenuMainWindow:Center()

        adminMenuMainWindow.Paint = function(self, x, y)

            draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 175))

        end

       	local closeMenuButton = vgui.Create('DButton')
		closeMenuButton:SetText('')
		closeMenuButton:SetFont('MenuFont')
		closeMenuButton:SetColor(Color(200, 200, 200, 255))
		closeMenuButton:SetSize(getTextSize('Закрыть меню', closeMenuButton:GetFont()))
		closeMenuButton:SetPos(scrw * 0.5 - closeMenuButton:GetWide() * 0.5, adminMenuMainWindow:GetTall() + adminMenuMainWindow:GetY() + 30)

		closeMenuButton.Paint = function(selfB, x, y)

			draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 0))
			drawTextWithShadow('Закрыть меню', selfB:GetFont(), x / 2, y / 2, selfB:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							
			selfB:SetColor(Color(200, 200, 200, 255))

			if selfB:IsHovered() then

				selfB:SetColor(Color(255, 255, 170, 255))

			end

		end

		closeMenuButton.OnCursorEntered = function()

			surface.PlaySound('garrysmod/ui_return.wav')

		end

		closeMenuButton.DoClick = function(selfB)

			surface.PlaySound('garrysmod/ui_click.wav')
			--LocalPlayer():LockControls(false)
			adminMenuMainWindow:Remove()
			selfB:Remove()

		end

        local playerDBLabel = vgui.Create('DButton', adminMenuMainWindow)
		playerDBLabel:SetText('')
		playerDBLabel:SetFont('MenuFont')
		playerDBLabel:SetColor(Color(200, 200, 200, 255))
		playerDBLabel:SetSize(adminMenuMainWindow:GetWide() / 2 - 1, 35)
		playerDBLabel:SetPos(0, 0)

		playerDBLabel.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 175))
			drawTextWithShadow('Игроки', self:GetFont(), x / 2, y / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		end

		playerDBLabel.OnCursorEntered = function()

			playerDBLabel:SetCursor("arrow")

		end

		playerDBLabel.DoClick = function(self)

			return

		end

		local commandsDBLabel = vgui.Create('DButton', adminMenuMainWindow)
		commandsDBLabel:SetText('')
		commandsDBLabel:SetFont('MenuFont')
		commandsDBLabel:SetColor(Color(200, 200, 200, 255))
		commandsDBLabel:SetSize(adminMenuMainWindow:GetWide() / 2 - 1, 35)
		commandsDBLabel:SetPos(adminMenuMainWindow:GetWide() / 2 + 1, 0)

		commandsDBLabel.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 175))
			drawTextWithShadow('Действия над ' .. playerChoosed, self:GetFont(), x / 2, y / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		end

		commandsDBLabel.OnCursorEntered = function()

			commandsDBLabel:SetCursor("arrow")

		end

		commandsDBLabel.DoClick = function(self)

			return

		end

        local playersButtonsScroll = vgui.Create('DScrollPanel', adminMenuMainWindow)
		playersButtonsScroll:SetPos(0, 35)
		playersButtonsScroll:SetSize(adminMenuMainWindow:GetWide() / 2 - 1, adminMenuMainWindow:GetTall())
		playersButtonsScroll.VBar:SetWide(0)

		local commandsButtonsScroll = vgui.Create('DScrollPanel', adminMenuMainWindow)
		commandsButtonsScroll:SetPos(adminMenuMainWindow:GetWide() / 2 + 1, 35)
		commandsButtonsScroll:SetSize(adminMenuMainWindow:GetWide() / 2 - 1, adminMenuMainWindow:GetTall())
		commandsButtonsScroll.VBar:SetWide(0)

		for k,v in pairs(player.GetAll()) do

			local ranply_name = v:Name()
			local ranply_shortName = utf8.sub(ranply_name, 0, 15)
			local ranply_class = v:GetPlayerClass()
			local ranply_team = v:GetPlayerTeam()

			playerButton = playersButtonsScroll:Add('DButton')
			playerButton:SetText('')
			playerButton:SetFont('SMenuFont')
			playerButton:SetColor(Color(200, 200, 200, 255))
			playerButton:SetSize(30, 30)
			playerButton:Dock(TOP)
			playerButton:DockMargin(1, 1, 1, 1)
			playerButton.playerSaved = v

			playerButton.Paint = function(self, x, y)

				if not IsValid(v) then self:Remove() commandsButtonsScroll:Clear() return end

				draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 115))
				drawTextWithShadow(ranply_shortName .. ' | ' .. ranply_team .. ', ' .. ranply_class, self:GetFont(), x / 2, y / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					
				self:SetColor(Color(200, 200, 200, 255))

				if self:IsHovered() then

					self:SetColor(Color(255, 255, 170, 255))

				end

			end

			playerButton.OnCursorEntered = function()

				surface.PlaySound('garrysmod/ui_return.wav')

			end

			playerButton.DoClick = function(self)

				surface.PlaySound('garrysmod/ui_click.wav')

				playerChoosed = ranply_shortName

				commandsButtonsScroll:Clear()

				for i = 1, #GAMEMODE.Config.adminButtonsCommands do

		        	local commandButton = commandsButtonsScroll:Add('DButton')
					commandButton:SetText('')
					commandButton:SetFont('SMenuFont')
					commandButton:SetColor(Color(200, 200, 200, 255))
					commandButton:SetSize(30, 30)
					commandButton:Dock(TOP)
					commandButton:DockMargin(1, 1, 1, 1)
					commandButton.name = GAMEMODE.Config.adminButtonsCommands[i].name
					commandButton.func = i
					commandButton.player = self.playerSaved

					commandButton.Paint = function(selfB, x, y)

						draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 115))
						drawTextWithShadow(selfB.name, selfB:GetFont(), x / 2, y / 2, selfB:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							
						selfB:SetColor(Color(200, 200, 200, 255))

						if selfB:IsHovered() then

							selfB:SetColor(Color(255, 255, 170, 255))

						end

					end

					commandButton.OnCursorEntered = function()

						surface.PlaySound('garrysmod/ui_return.wav')

					end

					commandButton.DoClick = function(selfB)

						surface.PlaySound('garrysmod/ui_click.wav')

						net.Start('ExecuteAdminCommand')

							net.WriteString(selfB.name)
							net.WriteEntity(selfB.player)
							net.WriteInt(selfB.func, 32)

						net.SendToServer()

					end

	        	end

			end

		end

		hook.Remove('HUDPaint', 'PlayerInterface_DrawAdminMenu')

	end)

end)