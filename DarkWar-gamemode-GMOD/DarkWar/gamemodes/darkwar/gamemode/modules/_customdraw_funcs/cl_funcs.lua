surface.CreateFont( "SplashFont", {
	
	font = "Marlett", 
	extended = true,
	size = 32,
	weight = 1000,
	outline = false,

})

surface.CreateFont( "MenuFont", {
		
	font = "Roboto", 
	extended = true,
	size = 24,
	weight = 1000,
	outline = false,

})

surface.CreateFont( "SMenuFont", {
		
	font = "Roboto", 
	extended = true,
	size = 18,
	weight = 1000,
	outline = false,

})

surface.CreateFont( "HUDBigFont", {
		
	font = "Roboto", 
	extended = true,
	size = 42,
	weight = 1000,
	outline = false,

})

surface.CreateFont( "HUDSmallFont", {
		
	font = "Roboto", 
	extended = true,
	size = 22,
	weight = 1000,
	outline = false,

})

function getTextSize(txt, font)

	surface.SetFont(font)
		
	local x = surface.GetTextSize(txt)
		
	return x + 5, 30

end

function drawIcon(x, y, w, h, m, c)

	surface.SetDrawColor(c)
	surface.SetMaterial(Material(m))
	surface.DrawTexturedRect(x, y, w, h)

end

function drawTextWithShadow(t, f, x, y, c, t1, t2)

	draw.SimpleText(t, f, x + 1, y + 2, Color(0, 0, 0, 255), t1, t2)
	draw.SimpleText(t, f, x, y, c, t1, t2)

end

function drawCircle(x, y, radius, seg, c)

	surface.SetDrawColor(c)
	draw.NoTexture()
	
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 )
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )

end

-- thx to GMod developers for this fix https://github.com/Facepunch/garrysmod/blob/be251723824643351cb88a969818425d1ddf42b3/garrysmod/gamemodes/sandbox/gamemode/commands.lua

function fixupProp( ply, ent, hitpos, mins, maxs )
    local entPos = ent:GetPos()
    local endposD = ent:LocalToWorld( mins )
    local tr_down = util.TraceLine( {
        start = entPos,
        endpos = endposD,
        filter = { ent, ply }
    } )

    local endposU = ent:LocalToWorld( maxs )
    local tr_up = util.TraceLine( {
        start = entPos,
        endpos = endposU,
        filter = { ent, ply }
    } )

    -- Both traces hit meaning we are probably inside a wall on both sides, do nothing
    if ( tr_up.Hit && tr_down.Hit ) then return end

    if ( tr_down.Hit ) then ent:SetPos( entPos + ( tr_down.HitPos - endposD ) ) end
    if ( tr_up.Hit ) then ent:SetPos( entPos + ( tr_up.HitPos - endposU ) ) end
end

function TryFixPropPosition( ply, ent, hitpos )
    fixupProp( ply, ent, hitpos, Vector( ent:OBBMins().x, 0, 0 ), Vector( ent:OBBMaxs().x, 0, 0 ) )
    fixupProp( ply, ent, hitpos, Vector( 0, ent:OBBMins().y, 0 ), Vector( 0, ent:OBBMaxs().y, 0 ) )
    fixupProp( ply, ent, hitpos, Vector( 0, 0, ent:OBBMins().z ), Vector( 0, 0, ent:OBBMaxs().z ) )
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------