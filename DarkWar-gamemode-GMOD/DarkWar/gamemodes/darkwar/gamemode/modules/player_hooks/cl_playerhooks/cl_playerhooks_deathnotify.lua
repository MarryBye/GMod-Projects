hook.Add('HUDPaint', 'PlayerInterface_NotificationsDeath', function()

	if not cl_VarsLoaded then return end
	if not lcply:GetAuthorised() or IsValid(notifyDeathMainPanel) then return end

	notifyDeathMainPanel = vgui.Create('DPanel')
	notifyDeathMainPanel:SetSize(380, 100)
	notifyDeathMainPanel:SetPos(scrw - 385, 5)

	notifyDeathMainPanel.Paint = function(self, x, y)

		draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 0))

	end

	local notifyDeathScroll = vgui.Create('DScrollPanel', notifyDeathMainPanel)
	notifyDeathScroll:Dock(FILL)
	notifyDeathScroll.VBar:SetWide(0)

	net.Receive('NotificattionsDeathNet', function()

		local txt = net.ReadString()

		notifyDeathScroll:addNotifyDeathToPanel(txt)

	end)

end)