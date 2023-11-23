local panel = FindMetaTable('Panel')

function panel:addNotifyToPanel(text, soundShow)

	if not IsValid(self) then return end

	surface.PlaySound(soundShow)

	local newNotify = self:Add('DButton')
	newNotify:SetText('')
	newNotify:SetFont('SMenuFont')
	newNotify:SetColor(Color(200, 200, 200, 255))
	newNotify:SetSize(self:GetWide(), 30)
	newNotify:Dock(TOP)
	newNotify:DockMargin(0, 0, 0, 1)
	newNotify:SetEnabled(false)
	newNotify.deleteCurTime = CurTime() + 5

	self.VBar:AnimateTo(30 * #self:GetChildren(), 0, 0, -1)

	newNotify.Paint = function(selfN, x, y)

		draw.RoundedBox(0, 0, 0, selfN:GetWide(), selfN:GetTall(), Color(0, 0, 0, 175))
		drawTextWithShadow(text, selfN:GetFont(), selfN:GetWide() / 2, selfN:GetTall() / 2, selfN:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	end

	newNotify.OnCursorEntered = function(selfN)

		selfN:SetCursor("arrow")

	end

	newNotify.DoClick = function(selfN)

		return

	end

	newNotify.Think = function(selfN)

		if CurTime() >= selfN.deleteCurTime then if IsValid(selfN) then selfN:Remove() end end

	end

end

function panel:addNotifyDeathToPanel(text)

	if not IsValid(self) then return end

	local newNotifyDeath = self:Add('DButton')
	newNotifyDeath:SetText('')
	newNotifyDeath:SetFont('SMenuFont')
	newNotifyDeath:SetColor(Color(200, 200, 200, 255))
	newNotifyDeath:SetSize(self:GetWide(), 30)
	newNotifyDeath:Dock(TOP)
	newNotifyDeath:DockMargin(0, 0, 0, 1)
	newNotifyDeath:SetEnabled(false)
	newNotifyDeath.deleteCurTime = CurTime() + 5

	self.VBar:AnimateTo(30 * #self:GetChildren(), 0, 0, -1)

	newNotifyDeath.Paint = function(selfDN, x, y)

		draw.RoundedBox(0, 0, 0, selfDN:GetWide(), selfDN:GetTall(), Color(0, 0, 0, 175))
		drawTextWithShadow(text, selfDN:GetFont(), selfDN:GetWide() / 2, selfDN:GetTall() / 2, selfDN:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	end

	newNotifyDeath.OnCursorEntered = function(selfDN)

		selfDN:SetCursor("arrow")

	end

	newNotifyDeath.DoClick = function(selfDN)

		return

	end

	newNotifyDeath.Think = function(selfDN)

		if CurTime() >= selfDN.deleteCurTime then if IsValid(selfDN) then selfDN:Remove() end end

	end

end

function panel:addDamageNotifyToPanel(text)

	if not IsValid(self) then return end

	local newDamageNotify = self:Add('DButton')
	newDamageNotify:SetText('')
	newDamageNotify:SetFont('SMenuFont')
	newDamageNotify:SetColor(Color(200, 200, 200, 255))
	newDamageNotify:SetSize(self:GetWide(), 30)
	newDamageNotify:Dock(TOP)
	newDamageNotify:DockMargin(0, 0, 0, 1)
	newDamageNotify:SetEnabled(false)
	newDamageNotify.deleteCurTime = CurTime() + 5

	self.VBar:AnimateTo(30 * #self:GetChildren(), 0, 0, -1)

	newDamageNotify.Paint = function(selfDN, x, y)

		draw.RoundedBox(0, 0, 0, selfDN:GetWide(), selfDN:GetTall(), Color(0, 0, 0, 175))
		drawTextWithShadow(text, selfDN:GetFont(), selfDN:GetWide() / 2, selfDN:GetTall() / 2, selfDN:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	end

	newDamageNotify.OnCursorEntered = function(selfDN)

		selfDN:SetCursor("arrow")

	end

	newDamageNotify.DoClick = function(selfDN)

		return

	end

	newDamageNotify.Think = function(selfDN)

		if CurTime() >= selfDN.deleteCurTime then if IsValid(selfDN) then selfDN:Remove() end end

	end

end

function panel:AddRemoveItemFromChest(class, name, fScroll, sScroll, netFirst, netSecond)

	if not IsValid(self) then return end

	local itemButton = self:Add('DButton')
	itemButton:SetText('')
	itemButton:SetFont('SMenuFont')
	itemButton:SetColor(Color(200, 200, 200, 255))
	itemButton:SetSize(self:GetWide(), 30)
	itemButton:Dock(TOP)
	itemButton:DockMargin(0, 0, 0, 1)
	itemButton.weaponClassSave = class
	itemButton.weaponNameSave = name

	itemButton.Paint = function(selfB, x, y)

		draw.RoundedBox(0, 0, 0, selfB:GetWide(), selfB:GetTall(), Color(0, 0, 0, 115))
		drawTextWithShadow(selfB.weaponNameSave, selfB:GetFont(), selfB:GetWide() / 2, selfB:GetTall() / 2, selfB:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		selfB:SetColor(Color(200, 200, 200, 255))

		if selfB:IsHovered() then

			selfB:SetColor(Color(255, 255, 170, 255))

		end

	end

	itemButton.OnCursorEntered = function()

		surface.PlaySound('garrysmod/ui_return.wav')

	end

	itemButton.DoClick = function(selfB)

		surface.PlaySound('garrysmod/ui_click.wav')

		if selfB:GetParent():GetParent() == fScroll then
						
			net.Start(netFirst)

				net.WriteString(selfB.weaponClassSave)
				net.WriteString(selfB.weaponNameSave)

			net.SendToServer()

			sScroll:Add(selfB)

			for k,v in pairs(fScroll:GetChildren()) do

				v:Dock(TOP)
				v:DockMargin(0, 0, 0, 1)

			end

		elseif selfB:GetParent():GetParent() == sScroll then

			net.Start(netSecond)

				net.WriteString(selfB.weaponClassSave)

			net.SendToServer()

			fScroll:Add(selfB)

			for k,v in pairs(sScroll:GetChildren()) do

				v:Dock(TOP)
				v:DockMargin(0, 0, 0, 1)

			end

		end

	end

end

function panel:AddCustomColorPicker(txt, x, y, w, h, r, g, b, func)

	local redColor, greenColor, blueColor = r, g, b

	local textColorPicker = self:Add('DLabel')
	textColorPicker:SetText(txt)
	textColorPicker:SetFont('SMenuFont')
	textColorPicker:SetSize(w / 2.35, h)
	textColorPicker:SetPos(x, y)
	textColorPicker:SetColor(Color(200, 200, 200, 255))

	for i = 1, 3 do
		
		local textEntryColor = vgui.Create('DTextEntry', self)
		if i == 1 then textEntryColor:SetText(redColor) end
		if i == 2 then textEntryColor:SetText(greenColor) end
		if i == 3 then textEntryColor:SetText(blueColor) end
		textEntryColor:SetFont('SMenuFont')
		textEntryColor:SetSize(35, 20)
		textEntryColor:SetPos(x + textColorPicker:GetWide() + 40 * (i - 1), y)
		textEntryColor:SetNumeric(true)
		textEntryColor:SetUpdateOnType(true)
		textEntryColor:SetMultiline(false)
		textEntryColor:SetTextColor(Color(200, 200, 200, 255))
		textEntryColor:SetPaintBorderEnabled(false)
		textEntryColor:SetPaintBackgroundEnabled(false)
		textEntryColor:SetDrawBorder(false)
		textEntryColor:SetPaintBackground(false)
		textEntryColor:SetAllowNonAsciiCharacters(false)

		textEntryColor.OnGetFocus = function(selfB)

			hook.Remove('ScoreboardHide', 'PlayerInterface_AutoCloseMenu')

		end

		textEntryColor.OnValueChange = function(selfB)

			if i == 1 then redColor = selfB:GetText() end
			if i == 2 then greenColor = selfB:GetText() end
			if i == 3 then blueColor = selfB:GetText() end

			func(selfB, redColor, greenColor, blueColor)

		end

		textEntryColor.OnLoseFocus = function(selfB)

			if selfB:GetText() == '' then selfB:SetText(1) end
			if tonumber(selfB:GetText()) > 255 then selfB:SetText(255) end
			if tonumber(selfB:GetText()) < 1 then selfB:SetText(1) end

		end

	end

	local colorPreview = vgui.Create('DPanel', self)
	colorPreview:SetSize(20, 20)
	colorPreview:SetPos(x + textColorPicker:GetWide() + 120, y)

	colorPreview.Paint = function(selfB, x, y)

		draw.RoundedBox(0, 0, 0, selfB:GetWide(), selfB:GetTall(), Color(155, 155, 155, 255))

		if redColor ~= '' and greenColor ~= '' and blueColor ~= '' then

			draw.RoundedBox(0, 1, 1, selfB:GetWide() - 2, selfB:GetTall() - 2, Color(redColor, greenColor, blueColor, 255))

		end

	end

end

local vguiCreate = vgui.Create

function vgui.Create(classname, parent, name, ...)

	hook.Call('OpenSomeDermaWindow', nil, classname, parent, name)

	return vguiCreate(classname, parent, name, {...})

end

function panel:CustomClose()

	hook.Call('CloseSomeDermaWindow', nil, self)

	self:Close()

end

local pmeta = FindMetaTable('Player')

function pmeta:LockControls(b)

	self:SetNWBool('LockedControls', b)

end

function pmeta:GetLockControls()

	return self:GetNWBool('LockedControls', false)

end