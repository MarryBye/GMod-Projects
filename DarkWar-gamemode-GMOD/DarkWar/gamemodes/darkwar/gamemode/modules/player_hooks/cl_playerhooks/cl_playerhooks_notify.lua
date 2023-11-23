hook.Add('HUDPaint', 'PlayerInterface_Notifications', function()

	if not cl_VarsLoaded then return end
	if not lcply:GetAuthorised() or IsValid(notifyMainPanel) then return end

	notifyMainPanel = vgui.Create('DPanel')
	notifyMainPanel:SetSize(380, 100)
	notifyMainPanel:SetPos(5, 5)

	notifyMainPanel.Paint = function(self, x, y)

		draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 0))

	end

	local notifyScroll = vgui.Create('DScrollPanel', notifyMainPanel)
	notifyScroll:Dock(FILL)
	notifyScroll.VBar:SetWide(0)

	net.Receive('NotificattionsNet', function()

		local txt = net.ReadString()
		local snd = net.ReadString()

		notifyScroll:addNotifyToPanel(txt, snd)

	end)

end)