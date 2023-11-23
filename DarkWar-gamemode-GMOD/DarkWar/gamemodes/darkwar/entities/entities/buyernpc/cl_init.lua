include("shared.lua")

function ENT:Draw()

	self:DrawModel()
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) <= 500 then

		local ang = self:GetAngles()
		
		ang:RotateAroundAxis(self:GetAngles():Forward(),90)
		ang:RotateAroundAxis(self:GetAngles():Up(), -1 * (self:GetAngles().y - LocalPlayer():GetAngles().y) - 90)

		cam.Start3D2D(self:GetPos(),ang,0.1)

			draw.RoundedBox(0, -140, -770, 280, 50, Color(55, 55, 55, 115))
			draw.RoundedBox(0, -139, -769, 278, 48, Color(0, 0, 0, 175))
			drawTextWithShadow("Торговец оружием", "SplashFont", 0, -745, Color(200,200,200,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
		cam.End3D2D()
	
	end

end

local buyerSplashes = {

	'Размер пушки не имеет значения, а умение использовать - имеет.',
	'Самые маленькие цены на самые большие пушки!',
	'Привет, не желаешь купить что-то для унижения своего недруга?'

}

local weaponNameToBuy = ''
local weaponToBuy = ''
local weaponPrice = 0

net.Receive('GunBuy', function(_, ply)

	if not IsValid(buyerMainFrame) then
		
		buyerMainFrame = vgui.Create('DFrame')
		buyerMainFrame:SetTitle('')
		buyerMainFrame:MakePopup()
		buyerMainFrame:ShowCloseButton(false)
		buyerMainFrame:SetSize(ScrW(), ScrH())
		buyerMainFrame:Center()
		buyerMainFrame:SetDraggable(false)
		buyerMainFrame:SetSizable(false)

		buyerMainFrame.blurStartTime = SysTime()
		buyerMainFrame.activeSplash = table.Random(buyerSplashes)

		buyerMainFrame.Paint = function(self, x, y)

			Derma_DrawBackgroundBlur(self, self.blurStartTime)
			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))

			drawIcon(self:GetWide() / 2 - 250, self:GetTall() - self:GetTall() + 25, 500, 250, 'materials/menu_logo.png', Color(255, 255, 255, 255))

			drawTextWithShadow(self.activeSplash, 'SplashFont', self:GetWide() / 2, self:GetTall() / 4, Color(255, 255, 170, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		end

		buyerWindowSmall = vgui.Create('DPanel', buyerMainFrame)
		buyerWindowSmall:SetSize(buyerMainFrame:GetWide() / 3 + 27, buyerMainFrame:GetTall() / 3)
		buyerWindowSmall:SetPos(buyerMainFrame:GetWide() / 2 - buyerWindowSmall:GetWide() / 2, buyerMainFrame:GetTall() / 2 - buyerWindowSmall:GetTall() / 2)

		buyerWindowSmall.Paint = function(self)

			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 115))

		end

		buyerCloseButton = vgui.Create('DButton', buyerMainFrame)
		buyerCloseButton:SetText('')
		buyerCloseButton:SetFont('MenuFont')
		buyerCloseButton:SetColor(Color(200, 200, 200, 255))
		buyerCloseButton:SetSize(getTextSize('Закрыть меню', buyerCloseButton:GetFont()))
		buyerCloseButton:SetPos(ScrW() / 2 - buyerCloseButton:GetWide() / 2, ScrH() / 1.5 + 37)

		buyerCloseButton.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))
			drawTextWithShadow('Закрыть меню', self:GetFont(), self:GetWide() / 2, self:GetTall() / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					
			self:SetColor(Color(200, 200, 200, 255))

			if self:IsHovered() then

				self:SetColor(Color(255, 255, 170, 255))

			end

		end

		buyerCloseButton.OnCursorEntered = function()

			surface.PlaySound('garrysmod/ui_return.wav')

		end

		buyerCloseButton.DoClick = function(self)

			surface.PlaySound('garrysmod/ui_click.wav')

			buyerMainFrame:CustomClose()

		end

	end

	local tableGunStats = {

		[0] = 'Название',
		[1] = 'Классификация',
		[2] = 'У/Р/О',
		[3] = 'Цена'
		
	}
	
	local function refreshAssortiment()

		local gunList = vgui.Create("DListView", buyerWindowSmall)
		gunList:SetSize(buyerWindowSmall:GetWide() + 21, buyerWindowSmall:GetTall())
		gunList:SetPos(0, 0)
		gunList:SetMultiSelect(false)
		gunList:SetHeaderHeight(25)
		gunList:SetDataHeight(25)
		gunList:SetSortable(true)

		gunList.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))

		end

		for i = 0, #tableGunStats do
			
			local columns = gunList:AddColumn(tableGunStats[i])
			columns:GetChild(0):SetEnabled(false)
			columns:GetChild(0):SetFont('MenuFont')
			columns:GetChild(0):SetColor(Color(200, 200, 200, 255))

			columns:GetChild(0).Paint = function(self, x, y)

				draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 175))

			end

			columns:GetChild(0).OnCursorEntered = function(self)

				self:SetCursor("arrow")

			end

			columns:GetChild(0).DoClick = function(self)

				return

			end
				
			columns:GetChild(1):SetText('')
			columns:GetChild(1).Paint = function(self, x, y)

				draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 115))

			end

		end

		for j = 1, #GAMEMODE.Config.gunsCategories do
				
			if GAMEMODE.Config.gunsCategories[j].canUse[LocalPlayer():GetPlayerClass()] then

				for i = 1, #GAMEMODE.Config.gunsCategories[j].guns do

					local damage = 0
					local spread = 0
					local recoil = 0
					local price = 0
					local name = 'No name'
					local classification = 'No classification'
					local class = 'No class'
					local model = 'models/weapons/w_pistol.mdl'
					local desc = 'У оружия нет особого описания'

					if weapons.Get(GAMEMODE.Config.gunsCategories[j].guns[i].gun).PrintName ~= nil then

						name = weapons.Get(GAMEMODE.Config.gunsCategories[j].guns[i].gun).PrintName

					end

					if weapons.Get(GAMEMODE.Config.gunsCategories[j].guns[i].gun).WorldModel ~= nil then
						
						model = weapons.Get(GAMEMODE.Config.gunsCategories[j].guns[i].gun).WorldModel

					end

					if weapons.Get(GAMEMODE.Config.gunsCategories[j].guns[i].gun).Damage ~= nil then
						
						damage = weapons.Get(GAMEMODE.Config.gunsCategories[j].guns[i].gun).Damage

					end

					if weapons.Get(GAMEMODE.Config.gunsCategories[j].guns[i].gun).HipSpread ~= nil then
						
						spread = weapons.Get(GAMEMODE.Config.gunsCategories[j].guns[i].gun).HipSpread

					end

					if weapons.Get(GAMEMODE.Config.gunsCategories[j].guns[i].gun).Recoil ~= nil then
						
						recoil = weapons.Get(GAMEMODE.Config.gunsCategories[j].guns[i].gun).Recoil

					end

					classification = GAMEMODE.Config.gunsCategories[j].guns[i].classification
					price = GAMEMODE.Config.gunsCategories[j].guns[i].price
					class = GAMEMODE.Config.gunsCategories[j].guns[i].gun
					desc = GAMEMODE.Config.gunsCategories[j].guns[i].desc

					local lines = gunList:AddLine(name, classification, damage .. ' / ' .. spread .. ' / ' .. recoil, price)
					
					lines.savedGunName = name
					lines.savedGunClass = class
					lines.savedGunPrice = price
					
					lines:SetSize(lines:GetWide(), 55)
					lines:SetSize(lines:GetWide(), 55)
					lines:SetSize(lines:GetWide(), 55)

					lines:Dock(TOP)
					lines:DockMargin(0, 0, 0, 0)

					for i = 0, #tableGunStats do

						lines:GetChild(i):SetFont('SMenuFont')
						lines:GetChild(i):SetPos(lines:GetWide() / 2, 1)

					end

					local panelMeta = FindMetaTable('Panel')

					function panelMeta:selectCustomLine(b)

						for i = 0, #tableGunStats do

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
						
						weaponNameToBuy = self.savedGunName
						weaponToBuy = self.savedGunClass
						weaponPrice = self.savedGunPrice

						gunList:Remove()

						local modelPanel = vgui.Create('DPanel', buyerWindowSmall)
						modelPanel:SetSize(buyerWindowSmall:GetWide() / 3, buyerWindowSmall:GetTall())
						modelPanel:SetPos(0, 0)

						modelPanel.Paint = function(self, x, y)

							draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 115))

						end

						local modelChoose = vgui.Create("DModelPanel", modelPanel)
						modelChoose:SetSize(modelPanel:GetWide(), modelPanel:GetTall())
						modelChoose:SetFOV( 25 )
						modelChoose:SetCamPos(Vector( -50, 0, 10 ))
						modelChoose:SetModel(model)
						modelChoose:SetCursor("sizewe")
						modelChoose.Angles = Angle(0, 0, 0)
						modelChoose:SetLookAt(modelChoose.Entity:GetPos())

						function modelChoose:DragMousePress()
								
							self.PressX, self.PressY = gui.MousePos()
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

						local nameLabel = vgui.Create('DLabel', buyerWindowSmall)
						nameLabel:SetText('Покупка ' .. weaponNameToBuy)
						nameLabel:SetFont('SplashFont')
						nameLabel:SetSize(getTextSize(nameLabel:GetText(), 'SplashFont'), 100)
						nameLabel:SetPos(buyerWindowSmall:GetWide() - buyerWindowSmall:GetWide() / 3 - nameLabel:GetWide() / 2, 0)

						local priceLabel = vgui.Create('DLabel', buyerWindowSmall)
						priceLabel:SetText(weaponPrice .. '$')
						priceLabel:SetFont('SplashFont')
						priceLabel:SetSize(getTextSize(priceLabel:GetText(), 'SplashFont'), 100)
						priceLabel:SetPos(buyerWindowSmall:GetWide() - buyerWindowSmall:GetWide() / 3 - priceLabel:GetWide() / 2, 35)
						priceLabel:SetColor(Color(255, 255, 175, 255))

						local descLabel = vgui.Create('DTextEntry', buyerWindowSmall)
						descLabel:SetText(desc)
						descLabel:SetFont('MenuFont')
						descLabel:SetSize(buyerWindowSmall:GetWide() / 2, buyerWindowSmall:GetWide() / 4)
						descLabel:SetPos(buyerWindowSmall:GetWide() - buyerWindowSmall:GetWide() / 3 - descLabel:GetWide() / 2, 135)
						descLabel:SetMultiline(true)
					    descLabel:SetTextColor(Color(200, 200, 200, 255))
					    descLabel:SetCursorColor(Color(255, 255, 255, 255))
					    descLabel:SetPaintBorderEnabled(false)
					    descLabel:SetPaintBackgroundEnabled(false)
					    descLabel:SetDrawBorder(false)
					    descLabel:SetPaintBackground(false)
					    descLabel:SetEditable(false)

						local butButtonYes = vgui.Create('DButton', buyerWindowSmall)
						butButtonYes:SetText('')
						butButtonYes:SetFont('MenuFont')
						butButtonYes:SetColor(Color(200, 200, 200, 255))
						butButtonYes:SetSize(getTextSize('Купить', butButtonYes:GetFont()))
						butButtonYes:SetPos(buyerWindowSmall:GetWide() - buyerWindowSmall:GetWide() / 3 - butButtonYes:GetWide() / 2, buyerWindowSmall:GetTall() / 1.35)

						butButtonYes.Paint = function(self, x, y)

							draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))
							drawTextWithShadow('Купить', self:GetFont(), self:GetWide() / 2, self:GetTall() / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
								
							self:SetColor(Color(200, 200, 200, 255))

							if self:IsHovered() then

								self:SetColor(Color(255, 255, 170, 255))

							end

						end

						butButtonYes.OnCursorEntered = function()

							surface.PlaySound('garrysmod/ui_return.wav')

						end

						butButtonYes.DoClick = function()

							surface.PlaySound('garrysmod/ui_click.wav')

							net.Start('GunBuy')

								net.WriteString(weaponToBuy)
								net.WriteInt(weaponPrice, 32)

							net.SendToServer()

							buyerWindowSmall:Clear()

							weaponNameToBuy = ''
							weaponToBuy = ''
							weaponPrice = 0
							
							refreshAssortiment()

						end

						local butButtonNo = vgui.Create('DButton', buyerWindowSmall)
						butButtonNo:SetText('')
						butButtonNo:SetFont('MenuFont')
						butButtonNo:SetColor(Color(200, 200, 200, 255))
						butButtonNo:SetSize(getTextSize('Отмена', butButtonNo:GetFont()))
						butButtonNo:SetPos(buyerWindowSmall:GetWide() - buyerWindowSmall:GetWide() / 3 - butButtonNo:GetWide() / 2, buyerWindowSmall:GetTall() / 1.2)

						butButtonNo.Paint = function(self, x, y)

							draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))
							drawTextWithShadow('Отмена', self:GetFont(), self:GetWide() / 2, self:GetTall() / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
								
							self:SetColor(Color(200, 200, 200, 255))

							if self:IsHovered() then

								self:SetColor(Color(255, 255, 170, 255))

							end

						end

						butButtonNo.OnCursorEntered = function()

							surface.PlaySound('garrysmod/ui_return.wav')

						end

						butButtonNo.DoClick = function()

							surface.PlaySound('garrysmod/ui_click.wav')

							buyerWindowSmall:Clear()
							
							weaponNameToBuy = ''
							weaponToBuy = ''
							weaponPrice = 0

							refreshAssortiment()

						end

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

						draw.RoundedBox(0, 0, -1, self:GetWide(), self:GetTall() - 1, Color(0, 0, 0, 115))

					end

				end

			end

		end

	end

	refreshAssortiment()

end)