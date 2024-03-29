TerminalR.Programs["disk_eject"] = {}

TerminalR.Programs["disk_eject"].Init = function( self )
	self:SetMemory( "EjectPercent", 0 )
	self:SetMemory( "TimerMenu", 0 )
	self:SetMemory( "TimerEnabled", false )
	
	local LoadingText = { 
		[0] = "Подготовка диска ...",
		[1] = "Запись данных на диск ( 1/7 ) ...",
		[2] = "Запись данных на диск ( 2/7 ) ...",
		[3] = "Запись данных на диск ( 3/7 ) ...",
		[4] = "Запись данных на диск ( 4/7 ) ...",
		[5] = "Запись данных на диск ( 5/7 ) ...",
		[6] = "Запись данных на диск ( 6/7 ) ...",
		[7] = "Запись данных на диск ( 7/7 ) ...",
		[8] = "Проверка корректности данных на диске ...",
		[9] = "Вытаскиваю диск ...",
		[10] = "Вытаскиваю диск ..."
	}
	self:SetMemoryIfEmpty( "TextEject", LoadingText )
	LocalPlayer():EmitSound( "terminalr/disk/eject/" .. math.random( 1, 3 ) .. ".wav" )
end

TerminalR.Programs["disk_eject"].Paint = function( self, w, h )
	local cr, cg, cb, ca = self:GetMemory("TerminalColor").r, self:GetMemory("TerminalColor").g, self:GetMemory("TerminalColor").b, math.random(230, 255)
	local cclr = Color(math.random(cr - 35, cr), math.random(cg - 35, cg), math.random(cb - 35, cb), ca)
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0 ) )
	local Percent = math.Clamp( self:GetMemory( "EjectPercent" ), 0, 100 )
	draw.RoundedBox( 0, w*0.2, h*0.5, (Percent/100)*(w*0.6), h*0.05, cclr )

	local Text = self:GetMemory( "TextEject" )[ math.Round( Percent * 0.1  ) ]
	draw.DrawText( Text, "TrmR_Medium", ScrW() * 0.5, ScrH() * 0.45, cclr, 1 )
end

TerminalR.Programs["disk_eject"].Think = function( self, dt )
	if ( self:GetMemory( "EjectPercent" ) < 100 ) then
		local NewPercent
		if ( math.random( 0, 100 ) > 10 ) then
			NewPercent = self:GetMemory( "EjectPercent" ) + ( math.random( 0, 10 ) * dt )
		else
			NewPercent = self:GetMemory( "EjectPercent" ) + ( 400 * dt )
		end
		self:SetMemory( "EjectPercent", NewPercent)
	else
		if ( not self:GetMemory("TimerEnabled") )then
			self:SetMemory("TimerMenu", CurTime() + 1 )
			self:SetMemory("TimerEnabled", true)
		else
			if ( CurTime() > self:GetMemory("TimerMenu") ) then
				local NTab = {
					DiskText = self:GetMemory("DiskText"),
					DiskTitle = self:GetMemory("DiskTitle"),				
					DiskPass = ( self:GetMemory("DiskPass") or nil ),				
				}
				net.Start( "Net_TerminalR:EjectDisk" )
					net.WriteInt( self.EntIndex, 32 )
					net.WriteTable( NTab )
				net.SendToServer()
			
				self:RemoveAllMemoryNamed( { "DiskPass", "DiskTitle", "DiskText", "EjectPercent", "TimerMenu", "TimerEnabled", "TextEject" } )
				self:LaunchProgram( "menu" )
			end
		end
	end
end

TerminalR.Programs["disk_eject"].OnRemove = function( self )
	self:RemoveAllMemoryNamed( { "EjectPercent", "TimerMenu", "TimerEnabled", "TextEject" } )
end