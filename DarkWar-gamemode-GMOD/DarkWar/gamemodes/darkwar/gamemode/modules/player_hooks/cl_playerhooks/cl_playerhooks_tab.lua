local models = {}
local classSave = ''

local menuButtons = {

	[1] = { text = 'Выбрать команду', fClick = function(panel) 

		local leftTeam = vgui.Create('DPanel', panel)
		leftTeam:SetSize(panel:GetWide() / 2 - 1, panel:GetTall() - 30)
		leftTeam:SetPos(0, 0)

		leftTeam.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 115))

		end

		local chooseLeftTeam = vgui.Create('DButton', panel)
		chooseLeftTeam:SetText('')
		chooseLeftTeam:SetFont('MenuFont')
		chooseLeftTeam:SetColor(Color(200, 200, 200, 255))
		chooseLeftTeam:SetSize(leftTeam:GetWide(), 30)
		chooseLeftTeam:SetPos(0, panel:GetTall() - 30)

		chooseLeftTeam.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 175))
			drawTextWithShadow('Зайти за ' .. GAMEMODE.Config.firstTeamName, self:GetFont(), x / 2, y / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				
			self:SetColor(Color(200, 200, 200, 255))

			if self:IsHovered() then

				self:SetColor(Color(255, 255, 170, 255))

			end

		end

		chooseLeftTeam.OnCursorEntered = function()

			surface.PlaySound('garrysmod/ui_return.wav')

		end

		chooseLeftTeam.DoClick = function(self)

			if not lcply_canchtm then return end
			if lcply_team == GAMEMODE.Config.firstTeamName then return end

			surface.PlaySound('garrysmod/ui_click.wav')

			net.Start('JoinTeam')

				net.WriteString(GAMEMODE.Config.firstTeamName)

			net.SendToServer()

			panel:Clear()

		end

		local leftTeamScroll = vgui.Create('DScrollPanel', leftTeam)
		leftTeamScroll:SetPos(0, 0)
		leftTeamScroll:SetSize(leftTeam:GetWide(), leftTeam:GetTall())
		leftTeamScroll.VBar:SetWide(0)

		local rightTeam = vgui.Create('DPanel', panel)
		rightTeam:SetSize(panel:GetWide() / 2 - 1, panel:GetTall() - 30)
		rightTeam:SetPos(panel:GetWide() / 2 + 2, 0)

		rightTeam.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 115))

		end

		local chooseRightTeam = vgui.Create('DButton', panel)
		chooseRightTeam:SetText('')
		chooseRightTeam:SetFont('MenuFont')
		chooseRightTeam:SetColor(Color(200, 200, 200, 255))
		chooseRightTeam:SetSize(rightTeam:GetWide(), 30)
		chooseRightTeam:SetPos(panel:GetWide() / 2 + 2, panel:GetTall() - 30)

		chooseRightTeam.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 175))
			drawTextWithShadow('Зайти за ' .. GAMEMODE.Config.secondTeamName, self:GetFont(), x / 2, y / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				
			self:SetColor(Color(200, 200, 200, 255))

			if self:IsHovered() then

				self:SetColor(Color(255, 255, 170, 255))

			end

		end

		chooseRightTeam.OnCursorEntered = function()

			surface.PlaySound('garrysmod/ui_return.wav')

		end

		chooseRightTeam.DoClick = function(self)

			if not lcply_canchtm then return end
			if lcply_team == GAMEMODE.Config.secondTeamName then return end

			surface.PlaySound('garrysmod/ui_click.wav')

			net.Start('JoinTeam')

				net.WriteString(GAMEMODE.Config.secondTeamName)

			net.SendToServer()

			panel:Clear()

		end

		local rightTeamScroll = vgui.Create('DScrollPanel', rightTeam)
		rightTeamScroll:SetPos(0, 0)
		rightTeamScroll:SetSize(rightTeam:GetWide(), rightTeam:GetTall())
		rightTeamScroll.VBar:SetWide(0)

		for k,v in pairs(player.GetAll()) do

			if v:GetPlayerTeam() == GAMEMODE.Config.firstTeamName then 

				local buttontest = leftTeamScroll:Add('DButton')
			    buttontest:SetText('')
				buttontest:SetFont('SMenuFont')
				buttontest:SetColor(Color(200, 200, 200, 255))
				buttontest:SetSize(leftTeamScroll:GetWide(), 30)
				buttontest:Dock(TOP)
				buttontest:DockMargin(0, 0, 0, 1)
				buttontest:SetEnabled(false)

				buttontest.Paint = function(self, x, y)

					draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 0))
					drawTextWithShadow(utf8.sub(v:Name(), 0, 15) .. ' | ' .. v:GetPlayerClass(), self:GetFont(), x / 2, y / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

				end

				buttontest.OnCursorEntered = function()

					buttontest:SetCursor("arrow")

				end

				buttontest.DoClick = function(self)

					return

				end

			elseif v:GetPlayerTeam() == GAMEMODE.Config.secondTeamName then

				local buttontest = rightTeamScroll:Add('DButton')
			    buttontest:SetText('')
				buttontest:SetFont('SMenuFont')
				buttontest:SetColor(Color(200, 200, 200, 255))
				buttontest:SetSize(rightTeamScroll:GetWide(), 30)
				buttontest:Dock(TOP)
				buttontest:DockMargin(0, 0, 0, 1)
				buttontest:SetEnabled(false)

				buttontest.Paint = function(self, x, y)

					draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 0))
					drawTextWithShadow(utf8.sub(v:Name(), 0, 15) .. ' | ' .. v:GetPlayerClass(), self:GetFont(), x / 2, y / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

				end

				buttontest.OnCursorEntered = function()

					buttontest:SetCursor("arrow")

				end

				buttontest.DoClick = function(self)

					return

				end

			end

		end

	end },

	[2] = { text = 'Изменить персонажа', fClick = function(panel) 

		local modelPanel = vgui.Create('DPanel', panel)
		modelPanel:SetSize(panel:GetWide() / 3, panel:GetTall() - 35)
		modelPanel:SetPos(0, 0)

		modelPanel.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 115))

		end

		local modelChoose = vgui.Create("DModelPanel", modelPanel)
		modelChoose:SetSize(modelPanel:GetWide(), modelPanel:GetTall())
		modelChoose:SetFOV( 60 )
		modelChoose:SetCamPos(Vector( -50, 0, 50 ))
		modelChoose:SetModel(lcply_model)
		modelChoose:SetCursor("sizewe")
		modelChoose.Angles = Angle(0, 0, 0)

		function modelChoose:DragMousePress()
				
			self.PressX, self.PressY = mouse_x, mouse_y
			self.Pressed = true
			
		end

		function modelChoose:DragMouseRelease() 

			self.Pressed = false 

		end

		function modelChoose:LayoutEntity(ent)
				
			if self.bAnimated then self:RunAnimation() end

			if self.Pressed then
					
				local mx = gui.MousePos()
				self.Angles = self.Angles - Angle(0, ((self.PressX or mx) - mx) / 2, 0)

				self.PressX, self.PressY = gui.MousePos()
				
			end

			ent:SetAngles(self.Angles)
			
		end

		local modelButton = vgui.Create('DButton', panel)
		modelButton:SetText('')
		modelButton:SetFont('MenuFont')
		modelButton:SetColor(Color(200, 200, 200, 255))
		modelButton:SetSize(panel:GetWide() / 3 * 2, 35)
		modelButton:SetPos(panel:GetWide() / 3, panel:GetTall() - 35)

		modelButton.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 175))
			drawTextWithShadow('Установить персонажа', self:GetFont(), x / 2, y / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				
			self:SetColor(Color(200, 200, 200, 255))

			if self:IsHovered() then

				self:SetColor(Color(255, 255, 170, 255))

			end

		end

		modelButton.OnCursorEntered = function()

			surface.PlaySound('garrysmod/ui_return.wav')

		end

		local modelScroll = vgui.Create('DScrollPanel', panel)
		modelScroll:SetPos(panel:GetWide() / 3, 0)
		modelScroll:SetSize(panel:GetWide() / 3 * 2, panel:GetTall() - 35)
		modelScroll.VBar:SetWide(0)

		for i = 1, #GAMEMODE.Config.playerClasses do

			local classChooseButton = vgui.Create('DButton', panel)
		    classChooseButton:SetText('')
			classChooseButton:SetFont('SMenuFont')
			classChooseButton:SetColor(Color(0, 0, 0, 175))
			classChooseButton:SetSize(panel:GetWide() / 3 / 6 + 0.5, 35)
			classChooseButton:SetPos(classChooseButton:GetWide() * (i - 1), panel:GetTall() - 35)
			
			classChooseButton.classSave = GAMEMODE.Config.playerClasses[i].class

			classChooseButton.Paint = function(self, x, y)

				draw.RoundedBox(0, 0, 0, x, y, self:GetColor())
				drawIcon(x / 2 - 14, y / 2 - 14, 28, 28, GAMEMODE.Config.playerClasses[i].icon, Color(lcply_IcoCol.r, lcply_IcoCol.g, lcply_IcoCol.b, 255))
				
				self:SetColor(Color(0, 0, 0, 175))

				if self:IsHovered() then

					self:SetColor(Color(155, 35, 35, 175))

				end

			end

			classChooseButton.OnCursorEntered = function()

				surface.PlaySound('garrysmod/ui_return.wav')

			end

			classChooseButton.DoClick = function(self)

				surface.PlaySound('garrysmod/ui_click.wav')

				classSave = self.classSave

				modelScroll:Clear()

				for i = 1, #GAMEMODE.Config.playerClasses do

					if GAMEMODE.Config.playerClasses[i].class == self.classSave then

						models = table.Copy(GAMEMODE.Config.playerClasses[i].models[lcply_team])

						break

					end

				end

				modelChoose:SetModel(table.Random(models))

				for k,v in pairs(models) do

				    local modelChooseButton = modelScroll:Add('DButton')
				    modelChooseButton:SetText('')
					modelChooseButton:SetFont('SMenuFont')
					modelChooseButton:SetColor(Color(200, 200, 200, 255))
					modelChooseButton:SetSize(modelScroll:GetWide(), 30)
					modelChooseButton:Dock(TOP)
					modelChooseButton:DockMargin(0, 0, 0, 1)
					modelChooseButton.modelPath = v

					modelChooseButton.Paint = function(self, x, y)

						draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 0))
						drawTextWithShadow(v, self:GetFont(), x / 2, y / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						
						self:SetColor(Color(200, 200, 200, 255))

						if self:IsHovered() then

							self:SetColor(Color(255, 255, 170, 255))

						end

					end

					modelChooseButton.OnCursorEntered = function()

						surface.PlaySound('garrysmod/ui_return.wav')

					end

					modelChooseButton.DoClick = function(self)

						surface.PlaySound('garrysmod/ui_click.wav')
						modelChoose:SetModel(self.modelPath)

					end

					local modelIcon = vgui.Create("SpawnIcon", modelChooseButton)
				   	modelIcon:SetModel(v)
				    modelIcon:SetTooltip(v)
				    modelIcon:Dock(LEFT)
				   	modelIcon:SetSize(30, 30)

				end

			end

			modelButton.DoClick = function(self)

				if lcply_team == 'None' or lcply_admin then return end
				if lcply_class == classSave then return end

				surface.PlaySound('garrysmod/ui_click.wav')

				net.Start('CharEdit')

					net.WriteString(modelChoose:GetModel())
					net.WriteString(classSave)

				net.SendToServer()

			end

		end

	end },

	[3] = { text = 'Статистика', fClick = function(panel) 

		local tableStats = {

			[0] = 'Никнейм',
			[1] = 'Команда',
			[2] = 'Класс',
			[3] = 'Звание',
			[4] = 'K/D | NPC'
		
		}

		local playersList = vgui.Create("DListView", panel)
		playersList:SetSize(panel:GetWide() + 21, panel:GetTall())
		playersList:SetPos(0, 0)
		playersList:SetMultiSelect(false)
		playersList:SetHeaderHeight(25)
		playersList:SetDataHeight(25)
		playersList:SetSortable(false)

		for i = 0, #tableStats do
		
			local columns = playersList:AddColumn(tableStats[i])
			columns:GetChild(0):SetEnabled(false)
			columns:GetChild(0):SetFont('MenuFont')
			columns:GetChild(0):SetColor(Color(200, 200, 200, 255))

			columns:GetChild(0).Paint = function(self, x, y)

				draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 175))

			end

			columns:GetChild(0).OnCursorEntered = function(self)

				self:SetCursor("arrow")

			end

			columns:GetChild(0).DoClick = function(self)

				return

			end
			
			columns:GetChild(1):SetText('')
			columns:GetChild(1).Paint = function(self, x, y)

				draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 115))

			end

		end

		for k,v in pairs(player.GetAll()) do

			local ranply_nick = v:Nick()
			local ranply_team = v:GetPlayerTeam()
			local ranply_class = v:GetPlayerClass()
			local ranply_rank = v:GetPlayerRank()
			local ranply_kills = v:GetPlayerKills()
			local ranply_deaths = v:Deaths()
			local ranply_npckills = v:GetPlayerNPCKills()
			local ranply_kddiv = math.min(math.Round(ranply_kills / ranply_deaths, 1), ranply_kills)

			local lines = playersList:AddLine(ranply_nick, ranply_team, ranply_class, ranply_rank.rankName, ranply_kills .. '/' .. ranply_deaths .. ' ( ' ..  ranply_kddiv .. ' ) | ' .. ranply_npckills)
			lines.savedPlayer = v
			
			lines:SetSize(lines:GetWide(), 55)
			lines:SetSize(lines:GetWide(), 55)
			lines:SetSize(lines:GetWide(), 55)

			lines:Dock(TOP)
			lines:DockMargin(0, 0, 0, 0)

			for i = 0, #tableStats do

				lines:GetChild(i):SetFont('SMenuFont')
				lines:GetChild(i):SetPos(lines:GetWide() / 2, 1)

			end

			local panelMeta = FindMetaTable('Panel')

			function panelMeta:selectCustomLine(b)

				for i = 0, #tableStats do

					if b then 

						self:GetChild(i):SetColor(Color(255, 255, 175, 255))

					else

						self:GetChild(i):SetColor(Color(200, 200, 200, 255))

					end

				end

			end

			lines:selectCustomLine(false)

			lines.OnSelect = function(self)

				surface.PlaySound('garrysmod/ui_click.wav')
				self.savedPlayer:ShowProfile()

			end

			lines.OnCursorEntered = function(self)

				self:SetCursor("hand")
				surface.PlaySound('garrysmod/ui_return.wav')
				lines:selectCustomLine(true)

			end

			lines.OnCursorExited = function(self)

				self:SetCursor("arrow")
				lines:selectCustomLine(false)

			end

			lines.Paint = function(self, x, y)

				draw.RoundedBox(0, 0, -1, x, y - 1, Color(0, 0, 0, 115))

			end

		end

		playersList.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 0))

		end

	end },

	[4] = { text = 'Настройки', fClick = function(panel) 

		local optionsScroll = vgui.Create('DScrollPanel', panel)
		optionsScroll:SetPos(0, 0)
		optionsScroll:SetSize(panel:GetWide(), panel:GetTall())
		optionsScroll.VBar:SetWide(0)

		local changeCrosshair = optionsScroll:Add("DNumSlider")
		changeCrosshair:SetPos( 25, 25 )
		changeCrosshair:SetSize( panel:GetWide() / 1.2, 25 )
		changeCrosshair:SetText( "Вариант прицела" )
		changeCrosshair:GetChildren()[1]:SetFont('SMenuFont')
		changeCrosshair:GetChildren()[3]:SetFont('SMenuFont')
		changeCrosshair:SetMin( 1 )
		changeCrosshair:SetMax( 7 )
		changeCrosshair:SetDecimals( 0 )
		changeCrosshair:SetConVar( "dwr_crosshair" )

		local changeCrosshairSize = optionsScroll:Add("DNumSlider")
		changeCrosshairSize:SetPos( 25, 50 )
		changeCrosshairSize:SetSize( panel:GetWide() / 1.2, 25 )
		changeCrosshairSize:SetText( "Размер прицела" )
		changeCrosshairSize:GetChildren()[1]:SetFont('SMenuFont')
		changeCrosshairSize:GetChildren()[3]:SetFont('SMenuFont')
		changeCrosshairSize:SetMin( 16 )
		changeCrosshairSize:SetMax( 256 )
		changeCrosshairSize:SetDecimals( 0 )
		changeCrosshairSize:SetConVar( "dwr_crosshair_size" )

		local changeIndicator = optionsScroll:Add("DNumSlider")
		changeIndicator:SetPos( 25, 75 )
		changeIndicator:SetSize( panel:GetWide() / 1.2, 25 )
		changeIndicator:SetText( "Вариант индикатора урона" )
		changeIndicator:GetChildren()[1]:SetFont('SMenuFont')
		changeIndicator:GetChildren()[3]:SetFont('SMenuFont')
		changeIndicator:SetMin( 1 )
		changeIndicator:SetMax( 7 )
		changeIndicator:SetDecimals( 0 )
		changeIndicator:SetConVar( "dwr_indicator" )

		local changeIndicatorSize = optionsScroll:Add("DNumSlider")
		changeIndicatorSize:SetPos( 25, 100 )
		changeIndicatorSize:SetSize( panel:GetWide() / 1.2, 25 )
		changeIndicatorSize:SetText( "Размер индикатора урона" )
		changeIndicatorSize:GetChildren()[1]:SetFont('SMenuFont')
		changeIndicatorSize:GetChildren()[3]:SetFont('SMenuFont')
		changeIndicatorSize:SetMin( 64 )
		changeIndicatorSize:SetMax( 256 )
		changeIndicatorSize:SetDecimals( 0 )
		changeIndicatorSize:SetConVar( "dwr_indicator_size" )

		local crossColor = string.ToColor(GetConVar('dwr_color'):GetString())

		panel:AddCustomColorPicker('Цвет прицела', 25, 125, panel:GetWide() / 1.2, 25, crossColor.r, crossColor.g, crossColor.b, 
			
			function(slf, r, g, b) 
				
				lcply_cvarCrossCol:SetString(r .. ' ' .. g .. ' ' .. b .. ' 255')
			
			end
		
		)

		local indicatorColor = string.ToColor(GetConVar('dwr_color_ind'):GetString())
		
		panel:AddCustomColorPicker('Цвет индикатора урона', 25, 150, panel:GetWide() / 1.2, 25, indicatorColor.r, indicatorColor.g, indicatorColor.b,
			
			function(slf, r, g, b) 
				
				lcply_cvarDmgCol:SetString(r .. ' ' .. g .. ' ' .. b .. ' 255')
			
			end
		
		)

		local iconColor = string.ToColor(GetConVar('dwr_color_ico'):GetString())
		
		panel:AddCustomColorPicker('Цвет иконок', 25, 175, panel:GetWide() / 1.2, 25, iconColor.r, iconColor.g, iconColor.b,
			
			function(slf, r, g, b) 
				
				lcply_cvarIcoCol:SetString(r .. ' ' .. g .. ' ' .. b .. ' 255')
			
			end
		
		)

	end },

	[5] = { text = 'Закрыть меню', fClick = function(panel) 

		MainWindow:CustomClose()

	end },

	[6] = { text = 'Выйти с сервера', fClick = function(panel) 

		local quitLabel = vgui.Create('DLabel', panel)
		quitLabel:SetText('Вы точно уверены?')
		quitLabel:SetFont('SplashFont')
		quitLabel:SetSize(getTextSize(quitLabel:GetText(), 'SplashFont'))
		quitLabel:SetPos(panel:GetWide() / 2 - quitLabel:GetWide() / 2, panel:GetTall() / 4)

		local quitButton = vgui.Create('DButton', panel)
		quitButton:SetText('')
		quitButton:SetFont('MenuFont')
		quitButton:SetColor(Color(200, 200, 200, 255))
		quitButton:SetSize(getTextSize('Да, я хочу выйти', quitButton:GetFont()))
		quitButton:SetPos(panel:GetWide() / 2 - quitButton:GetWide() / 2, panel:GetTall() / 1.5)

		quitButton.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 0))
			drawTextWithShadow('Да, я хочу выйти', self:GetFont(), x / 2, y / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				
			self:SetColor(Color(200, 200, 200, 255))

			if self:IsHovered() then

				self:SetColor(Color(255, 255, 170, 255))

			end

		end

		quitButton.OnCursorEntered = function()

			surface.PlaySound('garrysmod/ui_return.wav')

		end

		quitButton.DoClick = function()

			surface.PlaySound('garrysmod/ui_click.wav')
			lcply:ConCommand('killserver')

		end

	end }

}

local splashes = {

	"Зачем ты открыл меню? Устал убивать?",
	"Это DarkWar, детка!",
	"Кодер дибил...",
	"Закрой уже это чертово меню и иди убивать",
	"Здесь могла быть ваша реклама..",
	"Приходите на локалки Фруса!!!"

}

local function openTabFunc()

	if IsValid(MainWindow) then return end
			
	MainWindow = vgui.Create('DFrame')
	MainWindow:SetTitle('')
	MainWindow:MakePopup()
	MainWindow:ShowCloseButton(false)
	MainWindow:SetSize(scrw, scrh)
	MainWindow:Center()
	MainWindow:SetDraggable(false)
	MainWindow:SetSizable(false)

	MainWindow.blurStartTime = SysTime()
	MainWindow.activeSplash = table.Random(splashes)

	MainWindow.Paint = function(self, x, y)

		Derma_DrawBackgroundBlur(self, self.blurStartTime)
		draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 0))

		drawIcon(x / 2 - 250, y - y + 25, 500, 250, 'materials/menu_logo.png', Color(255, 255, 255, 255))

		drawTextWithShadow(self.activeSplash, 'SplashFont', x / 2, y / 4, Color(255, 255, 170, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	end

	MainWindowSmall = vgui.Create('DPanel', MainWindow)
	MainWindowSmall:SetSize(MainWindow:GetWide() / 3 + 27, MainWindow:GetTall() / 3)
	MainWindowSmall:SetPos(MainWindow:GetWide() / 2 - MainWindowSmall:GetWide() / 2, MainWindow:GetTall() / 2 - MainWindowSmall:GetTall() / 2)

	MainWindowSmall.Paint = function(self, x, y)

		draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 115))

	end

	for i = 1, #menuButtons do

		MainWindow_Button = vgui.Create('DButton', MainWindow)
		MainWindow_Button:SetText('')
		MainWindow_Button:SetFont('MenuFont')
		MainWindow_Button:SetColor(Color(200, 200, 200, 255))
		MainWindow_Button:SetSize(getTextSize(menuButtons[i].text, MainWindow_Button:GetFont()))
		MainWindow_Button:SetPos(scrw / 2 - MainWindow_Button:GetWide() / 2, scrh / 1.5 + 37 * i)

		MainWindow_Button.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 0))
			drawTextWithShadow(menuButtons[i].text, self:GetFont(), x / 2, y / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					
			self:SetColor(Color(200, 200, 200, 255))

			if self:IsHovered() then

				self:SetColor(Color(255, 255, 170, 255))

			end

		end

		MainWindow_Button.OnCursorEntered = function()

			surface.PlaySound('garrysmod/ui_return.wav')

		end

		MainWindow_Button.DoClick = function(self)

			surface.PlaySound('garrysmod/ui_click.wav')
					
			MainWindowSmall:Clear()

			menuButtons[i].fClick(MainWindowSmall)

		end

	end

end

hook.Add('HUDPaint', 'PlayerInterface_MenuOnJoin', function()

	openTabFunc()

	hook.Remove('HUDPaint', 'PlayerInterface_MenuOnJoin')

end)

hook.Add("ScoreboardShow", "PlayerInterface_OpenMenu", function()

	hook.Add('HUDPaint', 'PlayerInterface_OnJoin', function()

		openTabFunc()

		hook.Remove('HUDPaint', 'PlayerInterface_OnJoin')

	end)

	hook.Add("ScoreboardHide", "PlayerInterface_AutoCloseMenu", function()

		if IsValid(MainWindow) then MainWindow:CustomClose() end

		return false

	end)

	return false

end)