include("shared.lua")

function ENT:Draw()

	self:DrawModel()
	
	if LocalPlayer():GetPos():Distance(self:GetPos()) <= 500 then

		local ang = self:GetAngles()
		
		ang:RotateAroundAxis(self:GetAngles():Forward(),90)
		ang:RotateAroundAxis(self:GetAngles():Up(), -1 * (self:GetAngles().y - LocalPlayer():GetAngles().y) - 90)

		cam.Start3D2D(self:GetPos(),ang,0.1)
			
			draw.RoundedBox(0, -125, -300, 250, 50, Color(55, 55, 55, 115))
			draw.RoundedBox(0, -124, -299, 248, 48, Color(0, 0, 0, 175))
			drawTextWithShadow('Склад ' .. GAMEMODE.Config.secondTeamName, "SplashFont", 0, -275, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		cam.End3D2D()
	
	end

end

local svobodaChestSplashes = {

	'Сталкер, жизнь дарит тебе возможность найти верных товарищей в рядах «Свободы».',
	'Только здесь ты найдешь тех кто прикроет тебе спину и поделится последним куском хлеба!'
}

local plInv = {}
local svInv = {}

net.Receive('ChestUseSvoboda', function(_, ply)

	plInv = net.ReadTable()
	svInv = net.ReadTable()

	if not IsValid(svobodaChestFrame) then
		
		svobodaChestFrame = vgui.Create('DFrame')
		svobodaChestFrame:SetTitle('')
		svobodaChestFrame:MakePopup()
		svobodaChestFrame:ShowCloseButton(false)
		svobodaChestFrame:SetSize(ScrW(), ScrH())
		svobodaChestFrame:Center()
		svobodaChestFrame:SetDraggable(false)
		svobodaChestFrame:SetSizable(false)

		svobodaChestFrame.blurStartTime = SysTime()
		svobodaChestFrame.activeSplash = table.Random(svobodaChestSplashes)

		svobodaChestFrame.Paint = function(self, x, y)

			Derma_DrawBackgroundBlur(self, self.blurStartTime)
			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))

			drawIcon(self:GetWide() / 2 - 250, self:GetTall() - self:GetTall() + 25, 500, 250, 'materials/menu_logo.png', Color(255, 255, 255, 255))

			drawTextWithShadow(self.activeSplash, 'SplashFont', self:GetWide() / 2, self:GetTall() / 4, Color(255, 255, 170, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		end

		svobodaChestWindowSmall = vgui.Create('DPanel', svobodaChestFrame)
		svobodaChestWindowSmall:SetSize(svobodaChestFrame:GetWide() / 3 + 27, svobodaChestFrame:GetTall() / 3)
		svobodaChestWindowSmall:SetPos(svobodaChestFrame:GetWide() / 2 - svobodaChestWindowSmall:GetWide() / 2, svobodaChestFrame:GetTall() / 2 - svobodaChestWindowSmall:GetTall() / 2)

		svobodaChestWindowSmall.Paint = function(self)

			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 115))

		end

		svobodaChestClose = vgui.Create('DButton', svobodaChestFrame)
		svobodaChestClose:SetText('')
		svobodaChestClose:SetFont('MenuFont')
		svobodaChestClose:SetColor(Color(200, 200, 200, 255))
		svobodaChestClose:SetSize(getTextSize('Закрыть меню', svobodaChestClose:GetFont()))
		svobodaChestClose:SetPos(ScrW() / 2 - svobodaChestClose:GetWide() / 2, ScrH() / 1.5 + 37)

		svobodaChestClose.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))
			drawTextWithShadow('Закрыть меню', self:GetFont(), self:GetWide() / 2, self:GetTall() / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					
			self:SetColor(Color(200, 200, 200, 255))

			if self:IsHovered() then

				self:SetColor(Color(255, 255, 170, 255))

			end

		end

		svobodaChestClose.OnCursorEntered = function()

			surface.PlaySound('garrysmod/ui_return.wav')

		end

		svobodaChestClose.DoClick = function(self)

			surface.PlaySound('garrysmod/ui_click.wav')

			svobodaChestFrame:CustomClose()

		end

		local svobodaChestInventory = vgui.Create( "DPanel", svobodaChestWindowSmall )
		svobodaChestInventory:SetSize(svobodaChestWindowSmall:GetWide() / 2 - 1, svobodaChestWindowSmall:GetTall() - 35)
		svobodaChestInventory:SetPos(0, svobodaChestWindowSmall:GetTall() - svobodaChestWindowSmall:GetTall() + 35)

		svobodaChestInventory.Paint = function(self)

			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))

		end

		local svobodaInventoryDBLabel = vgui.Create('DButton', svobodaChestWindowSmall)
		svobodaInventoryDBLabel:SetText('')
		svobodaInventoryDBLabel:SetFont('MenuFont')
		svobodaInventoryDBLabel:SetColor(Color(200, 200, 200, 255))
		svobodaInventoryDBLabel:SetSize(svobodaChestWindowSmall:GetWide() / 2 - 1, 35)
		svobodaInventoryDBLabel:SetPos(0, 0)

		svobodaInventoryDBLabel.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 175))
			drawTextWithShadow('Инвентарь ' .. GAMEMODE.Config.secondTeamName, self:GetFont(), self:GetWide() / 2, self:GetTall() / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		end

		svobodaInventoryDBLabel.OnCursorEntered = function()

			svobodaInventoryDBLabel:SetCursor("arrow")

		end

		svobodaInventoryDBLabel.DoClick = function(self)

			return

		end
		
		local playerInventory = vgui.Create( "DPanel", svobodaChestWindowSmall )
		playerInventory:SetSize(svobodaChestWindowSmall:GetWide() / 2 - 1, svobodaChestWindowSmall:GetTall() - 35)
		playerInventory:SetPos(svobodaChestWindowSmall:GetWide() / 2 + 2, svobodaChestWindowSmall:GetTall() - svobodaChestWindowSmall:GetTall() + 35)

		playerInventory.Paint = function(self)

			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))

		end

		local playerInventoryDBLabel = vgui.Create('DButton', svobodaChestWindowSmall)
		playerInventoryDBLabel:SetText('')
		playerInventoryDBLabel:SetFont('MenuFont')
		playerInventoryDBLabel:SetColor(Color(200, 200, 200, 255))
		playerInventoryDBLabel:SetSize(svobodaChestWindowSmall:GetWide() / 2 - 1, 35)
		playerInventoryDBLabel:SetPos(svobodaChestWindowSmall:GetWide() / 2 + 2, 0)

		playerInventoryDBLabel.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 175))
			drawTextWithShadow('Инвентарь игрока', self:GetFont(), self:GetWide() / 2, self:GetTall() / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		end

		playerInventoryDBLabel.OnCursorEntered = function()

			playerInventoryDBLabel:SetCursor("arrow")

		end

		playerInventoryDBLabel.DoClick = function(self)

			return

		end

		local svobodaInventoryScroll = vgui.Create('DScrollPanel', svobodaChestInventory)
		svobodaInventoryScroll:SetPos(0, 0)
		svobodaInventoryScroll:SetSize(svobodaChestInventory:GetWide(), svobodaChestInventory:GetTall())
		svobodaInventoryScroll.VBar:SetWide(0)

		local playerInventoryScroll = vgui.Create('DScrollPanel', playerInventory)
		playerInventoryScroll:SetPos(0, 0)
		playerInventoryScroll:SetSize(playerInventory:GetWide(), playerInventory:GetTall())
		playerInventoryScroll.VBar:SetWide(0)

		for i = 1, table.maxn(svInv) do

			if svInv[i] == nil then continue end

			svobodaInventoryScroll:AddRemoveItemFromChest(svInv[i].class, weapons.Get(svInv[i].class).PrintName, playerInventoryScroll, svobodaInventoryScroll, 'ChestUseSvoboda', 'ChestUseFromSvoboda')

		end

		for i = 1, table.maxn(plInv) do

			if plInv[i] == nil then continue end

			playerInventoryScroll:AddRemoveItemFromChest(plInv[i].class, weapons.Get(plInv[i].class).PrintName, playerInventoryScroll, svobodaInventoryScroll, 'ChestUseSvoboda', 'ChestUseFromSvoboda')

		end

	end

end)