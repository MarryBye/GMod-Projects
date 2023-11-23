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
			drawTextWithShadow('Склад ' .. GAMEMODE.Config.firstTeamName, "SplashFont", 0, -275, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		cam.End3D2D()
	
	end

end

local dolgChestSplashes = {

	'Свободные сталкеры, ветераны и охотники — вливайтесь в ряды «Долга»!',
	'Защитить мир от заразы Зоны — наша общая цель и задача!'

}

local plInv = {}
local dlInv = {}

net.Receive('ChestUseDolg', function(_, ply)

	plInv = net.ReadTable()
	dlInv = net.ReadTable()

	if not IsValid(dolgChestFrame) then
		
		dolgChestFrame = vgui.Create('DFrame')
		dolgChestFrame:SetTitle('')
		dolgChestFrame:MakePopup()
		dolgChestFrame:ShowCloseButton(false)
		dolgChestFrame:SetSize(ScrW(), ScrH())
		dolgChestFrame:Center()
		dolgChestFrame:SetDraggable(false)
		dolgChestFrame:SetSizable(false)

		dolgChestFrame.blurStartTime = SysTime()
		dolgChestFrame.activeSplash = table.Random(dolgChestSplashes)

		dolgChestFrame.Paint = function(self, x, y)

			Derma_DrawBackgroundBlur(self, self.blurStartTime)
			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))

			drawIcon(self:GetWide() / 2 - 250, self:GetTall() - self:GetTall() + 25, 500, 250, 'materials/menu_logo.png', Color(255, 255, 255, 255))

			drawTextWithShadow(self.activeSplash, 'SplashFont', self:GetWide() / 2, self:GetTall() / 4, Color(255, 255, 170, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		end

		dolgChestWindowSmall = vgui.Create('DPanel', dolgChestFrame)
		dolgChestWindowSmall:SetSize(dolgChestFrame:GetWide() / 3 + 27, dolgChestFrame:GetTall() / 3)
		dolgChestWindowSmall:SetPos(dolgChestFrame:GetWide() / 2 - dolgChestWindowSmall:GetWide() / 2, dolgChestFrame:GetTall() / 2 - dolgChestWindowSmall:GetTall() / 2)

		dolgChestWindowSmall.Paint = function(self)

			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 115))

		end

		dolgChestClose = vgui.Create('DButton', dolgChestFrame)
		dolgChestClose:SetText('')
		dolgChestClose:SetFont('MenuFont')
		dolgChestClose:SetColor(Color(200, 200, 200, 255))
		dolgChestClose:SetSize(getTextSize('Закрыть меню', dolgChestClose:GetFont()))
		dolgChestClose:SetPos(ScrW() / 2 - dolgChestClose:GetWide() / 2, ScrH() / 1.5 + 37)

		dolgChestClose.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))
			drawTextWithShadow('Закрыть меню', self:GetFont(), self:GetWide() / 2, self:GetTall() / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					
			self:SetColor(Color(200, 200, 200, 255))

			if self:IsHovered() then

				self:SetColor(Color(255, 255, 170, 255))

			end

		end

		dolgChestClose.OnCursorEntered = function()

			surface.PlaySound('garrysmod/ui_return.wav')

		end

		dolgChestClose.DoClick = function(self)

			surface.PlaySound('garrysmod/ui_click.wav')

			dolgChestFrame:CustomClose()

		end

		local dolgChestInventory = vgui.Create( "DPanel", dolgChestWindowSmall )
		dolgChestInventory:SetSize(dolgChestWindowSmall:GetWide() / 2 - 1, dolgChestWindowSmall:GetTall() - 35)
		dolgChestInventory:SetPos(0, dolgChestWindowSmall:GetTall() - dolgChestWindowSmall:GetTall() + 35)

		dolgChestInventory.Paint = function(self)

			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))

		end

		local dolgInventoryDBLabel = vgui.Create('DButton', dolgChestWindowSmall)
		dolgInventoryDBLabel:SetText('')
		dolgInventoryDBLabel:SetFont('MenuFont')
		dolgInventoryDBLabel:SetColor(Color(200, 200, 200, 255))
		dolgInventoryDBLabel:SetSize(dolgChestWindowSmall:GetWide() / 2 - 1, 35)
		dolgInventoryDBLabel:SetPos(0, 0)

		dolgInventoryDBLabel.Paint = function(self, x, y)

			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 175))
			drawTextWithShadow('Инвентарь ' .. GAMEMODE.Config.firstTeamName, self:GetFont(), self:GetWide() / 2, self:GetTall() / 2, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		end

		dolgInventoryDBLabel.OnCursorEntered = function()

			dolgInventoryDBLabel:SetCursor("arrow")

		end

		dolgInventoryDBLabel.DoClick = function(self)

			return

		end
		
		local playerInventory = vgui.Create( "DPanel", dolgChestWindowSmall )
		playerInventory:SetSize(dolgChestWindowSmall:GetWide() / 2 - 1, dolgChestWindowSmall:GetTall() - 35)
		playerInventory:SetPos(dolgChestWindowSmall:GetWide() / 2 + 2, dolgChestWindowSmall:GetTall() - dolgChestWindowSmall:GetTall() + 35)

		playerInventory.Paint = function(self)

			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))

		end

		local playerInventoryDBLabel = vgui.Create('DButton', dolgChestWindowSmall)
		playerInventoryDBLabel:SetText('')
		playerInventoryDBLabel:SetFont('MenuFont')
		playerInventoryDBLabel:SetColor(Color(200, 200, 200, 255))
		playerInventoryDBLabel:SetSize(dolgChestWindowSmall:GetWide() / 2 - 1, 35)
		playerInventoryDBLabel:SetPos(dolgChestWindowSmall:GetWide() / 2 + 2, 0)

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

		local dolgInventoryScroll = vgui.Create('DScrollPanel', dolgChestInventory)
		dolgInventoryScroll:SetPos(0, 0)
		dolgInventoryScroll:SetSize(dolgChestInventory:GetWide(), dolgChestInventory:GetTall())
		dolgInventoryScroll.VBar:SetWide(0)

		local playerInventoryScroll = vgui.Create('DScrollPanel', playerInventory)
		playerInventoryScroll:SetPos(0, 0)
		playerInventoryScroll:SetSize(playerInventory:GetWide(), playerInventory:GetTall())
		playerInventoryScroll.VBar:SetWide(0)

		for i = 1, table.maxn(dlInv) do

			if dlInv[i] == nil then continue end

			dolgInventoryScroll:AddRemoveItemFromChest(dlInv[i].class, weapons.Get(dlInv[i].class).PrintName, playerInventoryScroll, dolgInventoryScroll, 'ChestUseDolg', 'ChestUseFromDolg')

		end

		for i = 1, table.maxn(plInv) do

			if plInv[i] == nil then continue end

			playerInventoryScroll:AddRemoveItemFromChest(plInv[i].class, weapons.Get(plInv[i].class).PrintName, playerInventoryScroll, dolgInventoryScroll, 'ChestUseDolg', 'ChestUseFromDolg')

		end

	end

end)