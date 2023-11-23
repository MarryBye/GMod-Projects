include("autorun/sh_config.lua")
AddCSLuaFile("cl_fonts.lua")

CreateClientConVar("dwr_hud", 2, true, false, nil, 1, 2)

local hp, ar, en, amm, alp, cin = 0, 0, 0, 0, 0, 0

DarkWar.hud_list = {

    ["DarkRP_HUD"] = true,
    ["DarkRP_LocalPlayerHUD"] = true,
    ["DarkRP_EntityDisplay"] = true,
    ["DarkRP_ZombieInfo"] = true,
    ["DarkRP_Hungermod"] = true,
    ["DarkRP_Agenda"] = true,
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudSuitPower"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true

}

DarkWar.HideHUD = function(name)
    
    if DarkWar.hud_list[name] then 
		
        return false 
	
    end

end
    
hook.Add("HUDShouldDraw", "HideHUD", DarkWar.HideHUD)

DarkWar.HideMouseHUD = function()
    
    return false

end

hook.Add("HUDDrawTargetID", "HideMouseHUD", DarkWar.HideMouseHUD)

DarkWar.DisplayNotify = function(msg)
    
    local txt = msg:ReadString()
    GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
    surface.PlaySound("buttons/lightswitch2.wav")
    MsgC(Color(255, 20, 20, 255), "[DarkRP] ", Color(200, 200, 200, 255), txt, "\n")

end

usermessage.Hook("_Notify", DarkWar.DisplayNotify) 

local box = function(r, x, y, w, h, c)
    
    draw.RoundedBox(r, x, y, w, h, c)

end

local rect = function(m, x, y, w, h, c)

    if m == nil then
        
        surface.SetDrawColor(c)
        surface.DrawTexturedRect(x, y, w, h)
    
    else
    
        surface.SetMaterial(Material(m))
        surface.SetDrawColor(c)
        surface.DrawTexturedRect(x, y, w, h)

    end

end

local icon = function(m, x, y, w, h, c)
    
    surface.SetMaterial(Material(m))
    surface.SetDrawColor(c)
    surface.DrawTexturedRect(x, y, w, h)

end

local text = function(s, f, x, y, c, aX, aY)
    
    if aY == nil then

        draw.SimpleText(s, f, x, y, c, aX)

    else
        
        draw.SimpleText(s, f, x, y, c, aX, aY)

    end

end

local ability = function(but, ico, box_color)

    text(but, "LockdownFont", ScrW() / 2, ScrH() / 1.1 - 35, Color(255,255,255,255), TEXT_ALIGN_CENTER)
    box(0, ScrW() / 2 - 37, ScrH() / 1.1 - 1, 74, 74, Color(0,0,0,210))
    box(3, ScrW() / 2 - 35, ScrH() / 1.1, 70, 70, box_color)
    icon(ico, ScrW() / 2 - 32, ScrH() / 1.1 + 5, 64, 64, Color(255, 255, 255, 255))

end

net.Receive('playSoundsUI', function()

	timer.Create("UISounds", CONFIG.music_cooldown, 0, function() 

		surface.PlaySound(CONFIG.war_music[math.random(1, #CONFIG.war_music)])

	 end)

end)

DarkWar.HUD = function()

    if LocalPlayer():Health() > 0 then

        CONFIG.HUD.Logo = true
        CONFIG.HUD.KillBoxColor = Color(0, 0, 0, 230)
        CONFIG.HUD.KillBoxWidth = 100
        CONFIG.HUD.KillBoxHeight = 35

        CONFIG.HUD.HealthColor = Color(150 + (cin * 255), 25, 0, 200)
        CONFIG.HUD.ArmorColor = Color(0, 25, 150 + (cin * 255), 200)
        CONFIG.HUD.AmmoColor = Color(0, 150 + (cin * 255), 25, 200) -- Only MarryBye`s HUD
    
        CONFIG.HUD.MoneyTextColor = Color(255, 255, 255, 255)
        CONFIG.HUD.TimeTextColor = Color(255, 255, 255, 255)
        CONFIG.HUD.NickTextColor = Color(255, 255, 255, 255)
        CONFIG.HUD.AllianceKills = Color(100, 100, 255, 255)
        CONFIG.HUD.RebelsKills = Color(255, 100, 100, 255)

        CONFIG.HUD.WantedColor = Color(cin * 255, 0, 255 - (cin * 255))
        CONFIG.HUD.LockdownColor = Color(cin * 255, 0, 255 - (cin * 255))

        CONFIG.HUD.Wanted = "Вы объявлены в розыск!"
        CONFIG.HUD.Lockdown = "Объявлен комендантский час!"

        CONFIG.HUD.LerpSpeed = 0.2

        -- MarryBye`s HUD CFG
        CONFIG.HUD.MarryBye.MainBoxUnderWidth = 300
        CONFIG.HUD.MarryBye.MainBoxUnderHeight = 180
        CONFIG.HUD.MarryBye.MainBoxWidth = 290
        CONFIG.HUD.MarryBye.MainBoxHeight = 170
    
        CONFIG.HUD.MarryBye.BarsUnderWidth = 280
        CONFIG.HUD.MarryBye.BarsUnderHeight = 25
        CONFIG.HUD.MarryBye.BarsWidth = 270
        CONFIG.HUD.MarryBye.BarsHeight = 15

        CONFIG.HUD.MarryBye.SmallBoxWidth = 150
        CONFIG.HUD.MarryBye.SmallBoxHeight = 25

        CONFIG.HUD.MarryBye.LockdownUnderBoxWidth = 385
        CONFIG.HUD.MarryBye.LockdownUnderBoxHeight = 50
        CONFIG.HUD.MarryBye.LockdownBoxWidth = 375
        CONFIG.HUD.MarryBye.LockdownBoxHeight = 40

        CONFIG.HUD.MarryBye.MainUnderColor = Color(35, 35, 35, 200)
        CONFIG.HUD.MarryBye.MainColor = Color(45, 45, 45, 175)
    
        -- Solyanka`s HUD CFG
        CONFIG.HUD.Solyanka.MainBoxWidth = 205
        CONFIG.HUD.Solyanka.MainBoxHeight = 180

        CONFIG.HUD.Solyanka.JobBoxWidth = 140
        CONFIG.HUD.Solyanka.JobBoxHeight = 30

        CONFIG.HUD.Solyanka.MainColor = Color(0, 0, 0, 230)

        x = ScrW() * 0
        y = ScrH()
        time = os.date("%H:%M",os.time())
        ply = LocalPlayer()
        nick = LocalPlayer():Nick()
        armor = LocalPlayer():Armor()
        health = LocalPlayer():Health()
        money = LocalPlayer():getDarkRPVar("money")
        salary = LocalPlayer():getDarkRPVar("salary")
        justWanted = LocalPlayer():getDarkRPVar("wanted")
        justLockdown = GetGlobalBool("LockDown")
        job = LocalPlayer():getDarkRPVar("job")
        jobColor = team.GetColor(LocalPlayer():Team())
        
        if IsValid(LocalPlayer():GetActiveWeapon()) then

            ammoType = LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()
            ammoClip1 = LocalPlayer():GetActiveWeapon():Clip1()
            ammoClip1Max = LocalPlayer():GetActiveWeapon():GetMaxClip1()
            ammoPocket = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())
            amm = Lerp(CONFIG.HUD.LerpSpeed, amm, ammoClip1 / ammoClip1Max * 100)

        end
        
        cin = (math.sin(CurTime()) + 1) / 2
        alp = Lerp(CONFIG.HUD.LerpSpeed, alp, 255)
        hp = Lerp(CONFIG.HUD.LerpSpeed, hp, ply:Health())
        ar = Lerp(CONFIG.HUD.LerpSpeed, ar, ply:Armor())
        --en = Lerp(CONFIG.HUD.LerpSpeed, en, LocalPlayer():getDarkRPVar("Energy"))

        icon("icons/crosshair.png", ScrW() / 2 - 2, ScrH() / 2 - 2, 4, 4, Color(255, 255, 255, 255))
        box(3, ScrW() / 2 - 50, ScrH() / 5 - 200, CONFIG.HUD.KillBoxWidth, CONFIG.HUD.KillBoxHeight, CONFIG.HUD.KillBoxColor)
        text(' : ', "Goals", ScrW() / 2, ScrH() / 5 - 195, Color(255,255,255,255), TEXT_ALIGN_CENTER)

        box(3, ScrW() / 2 - 225, ScrH() - 35, 450, 25, Color(0, 0, 0, 230))

        text(ply:GetNWInt(CONFIG.f_faction, 0), "Goals", ScrW() / 2 - 12, ScrH() / 5 - 195, CONFIG.HUD.AllianceKills, TEXT_ALIGN_RIGHT)
        text(ply:GetNWInt(CONFIG.s_faction, 0), "Goals", ScrW() / 2 + 12, ScrH() / 5 - 195, CONFIG.HUD.RebelsKills, TEXT_ALIGN_LEFT)

        text(ply:GetNWString('Rank', 'No value'), "Rank", ScrW() / 2 - 205, ScrH() - 33, Color(255,255,255,255), TEXT_ALIGN_LEFT)
        text(ply:GetNWString('NextRank', 'No value'), "Rank", ScrW() / 2 + 205, ScrH() - 33, Color(255,255,255,255), TEXT_ALIGN_RIGHT)
        text(ply:GetNWInt('Exp', 0) .. ' / ' .. ply:GetNWInt('NextExp', 0), "Rank", ScrW() / 2, ScrH() - 33, Color(255,255,255,255), TEXT_ALIGN_CENTER)
        icon(ply:GetNWString('Icon', 'No value'), ScrW() / 2 - 223, ScrH() - 30, 16, 16, Color(255, 255, 255, 255))
        icon(ply:GetNWString('NextIcon', 'No value'), ScrW() / 2 + 207, ScrH() - 30, 16, 16, Color(255, 255, 255, 255))
        
        if CONFIG.abilities then

            if ply:GetNWBool('canCast', false) then
                
                ability('B', 'icons/heart.png', Color(0, 180, 0, 150))

            else

                ability('B', 'icons/heart.png', Color(cin * 180, 0, 0, 150))

            end

        end

        if GetConVar("dwr_hud"):GetString() == "1" then

            -- Main boxes
            box(3, x + 25, y - 200, CONFIG.HUD.MarryBye.MainBoxUnderWidth, CONFIG.HUD.MarryBye.MainBoxUnderHeight, CONFIG.HUD.MarryBye.MainUnderColor)
            box(3, x + 30, y - 195, CONFIG.HUD.MarryBye.MainBoxWidth, CONFIG.HUD.MarryBye.MainBoxHeight, CONFIG.HUD.MarryBye.MainColor)

            -- Bars
            box(3, x + 35, y - 60, CONFIG.HUD.MarryBye.BarsUnderWidth, CONFIG.HUD.MarryBye.BarsUnderHeight, CONFIG.HUD.MarryBye.MainUnderColor)
            box(3, x + 35, y - 95, CONFIG.HUD.MarryBye.BarsUnderWidth, CONFIG.HUD.MarryBye.BarsUnderHeight, CONFIG.HUD.MarryBye.MainUnderColor)
            box(3, x + 35, y - 130, CONFIG.HUD.MarryBye.BarsUnderWidth, CONFIG.HUD.MarryBye.BarsUnderHeight, CONFIG.HUD.MarryBye.MainUnderColor)

            -- Coloured bars
            box(3, x + 40, y - 55, amm * CONFIG.HUD.MarryBye.BarsWidth / 100, CONFIG.HUD.MarryBye.BarsHeight, CONFIG.HUD.AmmoColor)
            box(3, x + 40, y - 90, ar * CONFIG.HUD.MarryBye.BarsWidth / 100, CONFIG.HUD.MarryBye.BarsHeight, CONFIG.HUD.ArmorColor)
            box(3, x + 40, y - 125, hp * CONFIG.HUD.MarryBye.BarsWidth / 100, CONFIG.HUD.MarryBye.BarsHeight, CONFIG.HUD.HealthColor)

            --Other
            box(3, x + 40, y - 165, CONFIG.HUD.MarryBye.SmallBoxWidth, CONFIG.HUD.MarryBye.SmallBoxHeight, CONFIG.HUD.MarryBye.MainUnderColor)
            box(3, x + 195, y - 165, CONFIG.HUD.MarryBye.SmallBoxWidth - 30, CONFIG.HUD.MarryBye.SmallBoxHeight, CONFIG.HUD.MarryBye.MainUnderColor)
            box(3, x + 240, y - 195, CONFIG.HUD.MarryBye.SmallBoxWidth - 75, CONFIG.HUD.MarryBye.SmallBoxHeight, CONFIG.HUD.MarryBye.MainUnderColor)

            --Texts
            text(time, "Time", x + 278, y - 191, CONFIG.HUD.TimeTextColor, TEXT_ALIGN_CENTER)
            text(nick, "Nick", x + 115, y - 160, CONFIG.HUD.NickTextColor, TEXT_ALIGN_CENTER)
            text(money .. "$ + " .. salary .. "$", "Money", x + 200, y - 160, CONFIG.HUD.MoneyTextColor, TEXT_ALIGN_LEFT)

            if IsValid(LocalPlayer():GetActiveWeapon()) then
            	
            	text(ammoClip1 .. " / " .. ammoPocket, "BarFont", x + 175, y - 56, CONFIG.HUD.MoneyTextColor, TEXT_ALIGN_CENTER)

            end

            text(armor, "BarFont", x + 175, y - 91, CONFIG.HUD.MoneyTextColor, TEXT_ALIGN_CENTER)
            text(health, "BarFont", x + 175, y - 126, CONFIG.HUD.MoneyTextColor, TEXT_ALIGN_CENTER)

            if justWanted then

                text(CONFIG.HUD.Wanted, "WantedFont", x + 335, y - 40, CONFIG.HUD.WantedColor, TEXT_ALIGN_LEFT)

            end

            if CONFIG.HUD.Logo then
        
                icon("icons/DWLogo.png", x, y - 235, 128, 128, Color(255, 255, 255, 255))
    
            end

            if justLockdown then
            
                box(3, surface.ScreenWidth() / 2.5, surface.ScreenHeight() * 0.043, CONFIG.HUD.MarryBye.LockdownUnderBoxWidth, CONFIG.HUD.MarryBye.LockdownUnderBoxHeight,  CONFIG.HUD.MarryBye.MainUnderColor)
                box(3, surface.ScreenWidth() / 2.5 + 5, surface.ScreenHeight() * 0.043 + 5, CONFIG.HUD.MarryBye.LockdownBoxWidth, CONFIG.HUD.MarryBye.LockdownBoxHeight,  CONFIG.HUD.MarryBye.MainColor)
                text(CONFIG.HUD.Lockdown, "LockdownFont", surface.ScreenWidth() / 2, surface.ScreenHeight() * 0.05, CONFIG.HUD.LockdownColor, TEXT_ALIGN_CENTER)

            end
    
        elseif GetConVar("dwr_hud"):GetString() == "2" then
            -- Main box
            box(3, x + 25, y - 200, CONFIG.HUD.Solyanka.MainBoxWidth, CONFIG.HUD.Solyanka.MainBoxHeight, CONFIG.HUD.Solyanka.MainColor)

            -- Job box
            box(3, x + 25, y - 50, CONFIG.HUD.Solyanka.JobBoxWidth, CONFIG.HUD.Solyanka.JobBoxHeight, team.GetColor(LocalPlayer():Team()))

            -- Texts
            text(time, "S_Time", x + 195, y - 47, CONFIG.HUD.TimeTextColor, TEXT_ALIGN_CENTER)
            text(job, "S_Job", x + 95, y - 45, CONFIG.HUD.TimeTextColor, TEXT_ALIGN_CENTER)
        
            text(health, "S_Big", x + 75, y - 180, CONFIG.HUD.TimeTextColor, TEXT_ALIGN_CENTER)
            text("Здоровье", "S_Small", x + 75, y - 150, CONFIG.HUD.TimeTextColor, TEXT_ALIGN_CENTER)

            text(armor, "S_Big", x + 75, y - 120, CONFIG.HUD.TimeTextColor, TEXT_ALIGN_CENTER)
            text("Броня", "S_Small", x + 75, y - 90, CONFIG.HUD.TimeTextColor, TEXT_ALIGN_CENTER)

            text(money .. "$", "S_Big", x + 170, y - 180, CONFIG.HUD.TimeTextColor, TEXT_ALIGN_CENTER)
            text("+" .. salary .. "$", "S_Small", x + 170, y - 150, CONFIG.HUD.TimeTextColor, TEXT_ALIGN_CENTER)

            if IsValid(LocalPlayer():GetActiveWeapon()) then

            	text(ammoClip1, "S_Big", x + 170, y - 120, CONFIG.HUD.TimeTextColor, TEXT_ALIGN_CENTER)
            	text(ammoPocket, "S_Small", x + 170, y - 90, CONFIG.HUD.TimeTextColor, TEXT_ALIGN_CENTER)

            end

            if CONFIG.HUD.Logo then
        
                icon("icons/W_LOGO_S.png", x + 65, y - 310, 128, 128, Color(255, 255, 255, 255))
    
            end

            if justWanted then

                text(CONFIG.HUD.Wanted, "WantedFont", x + 240, y - 40, CONFIG.HUD.WantedColor, TEXT_ALIGN_LEFT)

            end

            if justLockdown then
            
                box(3, surface.ScreenWidth() / 2.5, surface.ScreenHeight() * 0.043, CONFIG.HUD.MarryBye.LockdownUnderBoxWidth, CONFIG.HUD.MarryBye.LockdownUnderBoxHeight,  CONFIG.HUD.MarryBye.MainUnderColor)
                box(3, surface.ScreenWidth() / 2.5 + 5, surface.ScreenHeight() * 0.043 + 5, CONFIG.HUD.MarryBye.LockdownBoxWidth, CONFIG.HUD.MarryBye.LockdownBoxHeight,  CONFIG.HUD.MarryBye.MainColor)
                text(CONFIG.HUD.Lockdown, "LockdownFont", surface.ScreenWidth() / 2, surface.ScreenHeight() * 0.05, CONFIG.HUD.LockdownColor, TEXT_ALIGN_CENTER)

            end

        end
    
    end

end

hook.Add("HUDPaint", "HUD", DarkWar.HUD)