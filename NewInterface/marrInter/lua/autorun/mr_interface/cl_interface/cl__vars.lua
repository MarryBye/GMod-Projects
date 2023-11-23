scrw, scrh = ScrW(), ScrH()

timer.Remove('UpdateStandartVars')

timer.Create('UpdateStandartVars', 0.1, 0, function()

    ply = LocalPlayer()

    if !IsValid(ply) then return end
    
    nick = ply:Nick()
    hp = ply:Health()
    ar = ply:Armor()
    mhp = ply:GetMaxHealth()
    mar = ply:GetMaxArmor()
    speed = ply:GetVelocity():Length()
    ag = ply:GetNWInt('hasAgilityPoints', -1)

end)