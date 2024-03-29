TerminalR.Programs["disk_read"] = {}

TerminalR.Programs["disk_read"].Init = function( self )
	if ( self:GetMemory( "DiskText" ) == nil ) then
		self:LaunchProgram( "menu" )
		return
	end
	self:SetMemoryIfEmpty( "CharLine", 1 )
	self:SetMemoryIfEmpty( "LineDistance", ScrH()*0.05 )
	self:SetMemoryIfEmpty( "DiskText", {} )
	self:SetMemory( "CamY", 0 )
	
	local SW, SH = TerminalRGetTextSize( "> " .. TerminalR.Lang.Cancel, "TrmR_Medium" )
	local MenuButton = self:CreateMenuButton( "WriteOnDisk", "> " .. TerminalR.Lang.Cancel )
	MenuButton:SetPos( ScrW()*0.01, ScrH()*0.925 )
	MenuButton:SetSize( SW + 40, SH + 10 )
	MenuButton.DoClick = function( selfB )
		self:RemoveParent()
		self:RemoveAllMemoryNamed( { "CharPosX", "CharLine", "LineDistance", "CamY" } )
		self:LaunchProgram( "menu" )
	end
	
	local ParentTable = self:GetParentTable()
	ParentTable["TE"] = vgui.Create( "DTextEntry", self )
	ParentTable["TE"]:SetText( "" )
	ParentTable["TE"]:SetSize( 1, 1 )
	ParentTable["TE"].NextTyping = CurTime()
	ParentTable["TE"].Paint = function( TE )
	end
	ParentTable["TE"].OnLoseFocus = function( TE )
		TE:RequestFocus()
	end
	
	ParentTable["TE"].Think = function( selfD )
		if ( CurTime() > selfD.NextTyping ) then
			local Text = self:GetMemory("DiskText")[self:GetMemory("CharLine")]
			if ( input.IsMouseDown( MOUSE_LEFT ) ) then
				local NewCamY = self:GetMemory("CamY") + self:GetMemory("LineDistance")
				if ( #self:GetMemory( "DiskText" ) < 10 ) then return end
				if ( NewCamY > #self:GetMemory( "DiskText" ) * self:GetMemory( "LineDistance" ) ) then return end
				self:SetMemory( "CamY", NewCamY )
				selfD.NextTyping = CurTime() + 0.1	
			elseif ( input.IsMouseDown( MOUSE_RIGHT ) ) then
				local NewCamY = self:GetMemory("CamY") - self:GetMemory("LineDistance")
				if ( NewCamY < 0 ) then return end
				self:SetMemory( "CamY", NewCamY )
				selfD.NextTyping = CurTime() + 0.1	
			end
		end
	end
	ParentTable["TE"]:RequestFocus()
end

TerminalR.Programs["disk_read"].Paint = function( self, w, h )
	local cr, cg, cb, ca = self:GetMemory("TerminalColor").r, self:GetMemory("TerminalColor").g, self:GetMemory("TerminalColor").b, math.random(230, 255)
	local cclr = Color(math.random(cr - 35, cr), math.random(cg - 35, cg), math.random(cb - 35, cb), ca)
	local Text = self:GetMemory("DiskText")[self:GetMemory("CharLine")]
	local CharX = self:GetMemory( "CharPosX" )
	local CharLine = self:GetMemory( "CharLine" )
	-- draw.DrawText( Text, "TrmR_Medium", 200, 200, Color( 0, math.random(210,255), 0, 255 ), 0 )
	
	render.SetScissorRect( 0, 0, w, h*0.9, true )
	local posy = self:GetMemory( "LineDistance" )
	for k , v in pairs ( self:GetMemory("DiskText") ) do
		local CamY = self:GetMemory( "CamY" )
		draw.DrawText( v, "TrmR_Medium", w*0.05, posy - CamY, cclr, 0 )
		posy = ( posy + self:GetMemory( "LineDistance" ) )
	end
	render.SetScissorRect( 0, 0, 0, 0, false )
	
	local AC = self:GetMemory( "CamY", 0 ) -- Actual Cam
	local MC = ( self:GetMemory("CamY") / self:GetMemory("LineDistance") ) -- Max Cam
	draw.DrawText( MC .. "/" .. #self:GetMemory("DiskText"), "TrmR_Medium", w*0.5, h*0.94, cclr, 1, 1)

end

TerminalR.Programs["disk_read"].OnRemove = function( self )
	self:RemoveAllMemoryNamed( { "CharPosX", "CharLine", "LineDistance", "CamY" } )
end

TerminalR.Programs["disk_read"].Launch = function( self )
	self:RemoveParent()
	self:RemoveAllMemoryNamed( { "CharPosX", "CharLine", "LineDistance", "CamY" } )
end