AddCSLuaFile()

if SERVER then

    util.AddNetworkString('SendProp')
    util.AddNetworkString('DeleteProp')

end

if CLIENT then

    SWEP.Slot = 1
    SWEP.SlotPos = 1
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
    
    SWEP.ChoosenModel = { model = '', hp = 0, price = 0}
    
    SWEP.rollDelay = 0.1
    SWEP.rollCurTime = CurTime() + SWEP.rollDelay

end

SWEP.spawnDelay = 0.5
SWEP.spawnCurTime = CurTime() + SWEP.spawnDelay

SWEP.PrintName = "Engineer Key"
SWEP.Author = "MarryBye"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModel      = "models/weapons/v_pistol.mdl"   
SWEP.WorldModel     = "models/weapons/w_pistol.mdl"

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "DarkWar"

SWEP.Primary.Delay = 0.3
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.Delay = 0.3
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
    
    self:SetHoldType("normal")

end

function SWEP:SecondaryAttack()

    if CLIENT then

        if IsValid(buildMainWindow) then return end

        self.Owner:LockControls(true)

        buildMainWindow = vgui.Create('DPanel')
        buildMainWindow:MakePopup()
        buildMainWindow:SetSize(550, 250)
        buildMainWindow:SetPos(ScrW() / 2 - buildMainWindow:GetWide() / 2, ScrH() / 2 - buildMainWindow:GetTall() / 2)
        buildMainWindow:Center()

        buildMainWindow.Think = function(self)

            if not LocalPlayer():KeyDown(IN_ATTACK2) then self:Remove() end

        end

        buildMainWindow.Paint = function(self, x, y)

            draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 175))

        end

        local tablePropStats = {

            [0] = 'Название',
            [1] = 'Класс',
            [2] = 'Прочность',
            [3] = 'Цена'
        
        }

        local propList = vgui.Create("DListView", buildMainWindow)
        propList:SetSize(buildMainWindow:GetWide() + 21, buildMainWindow:GetTall())
        propList:SetPos(0, 0)
        propList:SetMultiSelect(false)
        propList:SetHeaderHeight(25)
        propList:SetDataHeight(25)
        propList:SetSortable(true)

        propList.Paint = function(self, x, y)

            draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))

        end

        for i = 0, #tablePropStats do
            
            local columns = propList:AddColumn(tablePropStats[i])
            columns:GetChild(0):SetEnabled(false)
            columns:GetChild(0):SetFont('MenuFont')
            columns:GetChild(0):SetColor(Color(200, 200, 200, 255))

            columns:GetChild(0).Paint = function(self, x, y)

                draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 175))

            end

            columns:GetChild(0).OnCursorEntered = function(self)

                self:SetCursor("arrow")

            end

            columns:GetChild(0).DoClick = function(self)

                return

            end
                
            columns:GetChild(1):SetText('')
            columns:GetChild(1).Paint = function(self, x, y)

                draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 115))

            end

        end

        for i = 1, #GAMEMODE.Config.propsForBuilding do

            local lines = propList:AddLine(GAMEMODE.Config.propsForBuilding[i].name, GAMEMODE.Config.propsForBuilding[i].model, GAMEMODE.Config.propsForBuilding[i].hp, GAMEMODE.Config.propsForBuilding[i].price)
                    
            lines.name = GAMEMODE.Config.propsForBuilding[i].name
            lines.model = GAMEMODE.Config.propsForBuilding[i].model
            lines.hp = GAMEMODE.Config.propsForBuilding[i].hp
            lines.price = GAMEMODE.Config.propsForBuilding[i].price
                    
            lines:SetSize(lines:GetWide(), 55)
            lines:SetSize(lines:GetWide(), 55)
            lines:SetSize(lines:GetWide(), 55)

            lines:Dock(TOP)
            lines:DockMargin(0, 0, 0, 0)

            for i = 0, #tablePropStats do

                lines:GetChild(i):SetFont('SMenuFont')
                lines:GetChild(i):SetPos(lines:GetWide() / 2, 1)

            end

            local panelMeta = FindMetaTable('Panel')

            function panelMeta:selectCustomLine(b)

                for i = 0, #tablePropStats do

                    if b then 

                        self:GetChild(i):SetColor(Color(255, 255, 175, 255))

                    else

                        self:GetChild(i):SetColor(Color(200, 200, 200, 255))

                    end

                end

            end

            lines:selectCustomLine(false)

            lines.OnSelect = function(selfBut)

                surface.PlaySound('garrysmod/ui_click.wav')

                self.ChoosenModel.model = selfBut.model
                self.ChoosenModel.hp = selfBut.hp
                self.ChoosenModel.price = selfBut.price

                if IsValid(self.previewProp) then 

                    if self.ChoosenModel.model ~= self.previewProp:GetModel() then 

                    self.previewProp:SetModel(self.ChoosenModel.model)

                    end

                end

                buildMainWindow:Remove()
                self.Owner:LockControls(false)

            end

            lines.OnCursorEntered = function(self)

                self:SetCursor("hand")
                surface.PlaySound('garrysmod/ui_return.wav')
                lines:selectCustomLine(true)

            end

            lines.OnCursorExited = function(self)

                self:SetCursor("arrow")
                lines:selectCustomLine(false)

            end

            lines.Paint = function(self, x, y)

                draw.RoundedBox(0, 0, -1, self:GetWide(), self:GetTall() - 1, Color(0, 0, 0, 115))

            end

        end

    end

end

function SWEP:Think()

    if SERVER then return end

    if IsValid(self.previewProp) then  

        if input.IsKeyDown(15) and CurTime() > self.rollCurTime then
        
            self.previewProp:SetAngles(Angle( self.previewProp:GetAngles().x + 10, self.previewProp:GetAngles().y, self.previewProp:GetAngles().z ))

            self.rollCurTime = CurTime() + self.rollDelay

        end

        if input.IsKeyDown(28) and CurTime() > self.rollCurTime then
        
            self.previewProp:SetAngles(Angle( self.previewProp:GetAngles().x, self.previewProp:GetAngles().y + 10, self.previewProp:GetAngles().z ))

            self.rollCurTime = CurTime() + self.rollDelay

        end

        if input.IsKeyDown(30) and CurTime() > self.rollCurTime then
        
            self.previewProp:SetAngles(Angle( self.previewProp:GetAngles().x, self.previewProp:GetAngles().y, self.previewProp:GetAngles().z + 10 ))

            self.rollCurTime = CurTime() + self.rollDelay

        end

        if input.IsKeyDown(36) then
        
            if IsValid(self.Owner:GetEyeTrace().Entity) and self.Owner:GetEyeTrace().Entity:GetClass() == 'engineerprop' and self.Owner:GetEyeTrace().Entity:GetNWEntity('PropOwner') == self.Owner then

                net.Start('DeleteProp')

                    net.WriteEntity(self.Owner:GetEyeTrace().Entity)

                net.SendToServer()

            end

        end

        if input.IsKeyDown(13) then

            self.previewProp:SetAngles(Angle(0, 0, 0))

        end

    end
 
    if self.ChoosenModel.model == '' then return end
    if not IsValid(self) then return end
    
    if IsValid(self.previewProp) then 

        if self.Owner:GetEyeTrace().HitPos:Distance(self.Owner:GetPos()) > 200 then 

            self.previewProp:SetColor(Color(0, 175, 255, 0)) 

            return 

        else

            self.previewProp:SetColor(Color(0, 175, 255, 225)) 

        end

        self.previewProp:SetPos(self.Owner:GetEyeTrace().HitPos)
        TryFixPropPosition(self.Owner, self.previewProp, self.Owner:GetEyeTrace().HitPos)

        return 

    end

    self.previewProp = ents.CreateClientProp(self.ChoosenModel.model)
    self.previewProp:SetPos(self.Owner:GetEyeTrace().HitPos)
    self.previewProp:SetColor(Color(0, 175, 255, 225))
    self.previewProp:SetRenderMode(RENDERMODE_TRANSCOLOR)
    self.previewProp:SetMaterial('phoenix_storms/gear')
    self.previewProp:Spawn()

    self.previewProp:PhysicsDestroy()
    self.previewProp:DestroyShadow()

end

function SWEP:Deploy()

    return true

end

function SWEP:Holster()
    
    if CLIENT then 

        if IsValid(self.previewProp) then 

            self.previewProp:Remove() 

            return true 

        end

    end

    return true

end

function SWEP:OnRemove()

    if CLIENT then 

        if IsValid(self.previewProp) then 

            self.previewProp:Remove() 

            return true 

        end

    end

    return true

end

function SWEP:OwnerChanged()

    if CLIENT then 

        if IsValid(self.previewProp) then 

            self.previewProp:Remove() 

            return true 

        end

    end

    return true

end

function SWEP:PrimaryAttack()

    if CLIENT then

        if self.ChoosenModel.model == '' then return end
        if not IsValid(self.previewProp) then return end
        if not IsValid(self) then return end

        net.Start('SendProp')

            net.WriteTable({ model = self.ChoosenModel.model, ang = self.previewProp:GetAngles(), pos = self.previewProp:GetPos(), hp = self.ChoosenModel.hp, price = self.ChoosenModel.price })

        net.SendToServer()

    end

    if SERVER then

        net.Receive('SendProp', function(_, ply)

            if ply:GetPlayerClass() ~= 'Инженер' and not ply:GetPlayerIsAdmin() then return end

            if CurTime() <= self.spawnCurTime then return end
            if ply:GetNWInt('OwnerPropAmount', 0) == 10 then return end

            local tbl = net.ReadTable()
          
            local propModel = tbl.model
            local propAngle = tbl.ang
            local propPos = tbl.pos
            local propHP = tbl.hp
            local propPrice = tbl.price

            if ply:GetPos():Distance(propPos) > 200 then return end
            if ply:GetPlayerMoney() < propPrice then return end

            for k,v in pairs(ents.FindInSphere(propPos, 35)) do 

                if not IsValid(v) then continue end
                
                if IsEntity(v) then 

                    if v:GetClass() == 'engineerprop' then continue end

                    return

                end

                if v:IsPlayer() then return end
                if v:IsNPC() then return end

            end

            local buildedProp = ents.Create( "engineerprop" )
            buildedProp:SetModel(propModel)
            buildedProp:SetAngles(propAngle)
            buildedProp:SetPos(propPos)
            buildedProp:Spawn()

            buildedProp:SetHP(propHP)

            buildedProp:PhysicsDestroy()
            buildedProp:SetCreator(ply)

            buildedProp:SetNWEntity('PropOwner', ply)
            ply:SetNWInt('OwnerPropAmount', ply:GetNWInt('OwnerPropAmount', 0) + 1)

            self:SetHoldType("melee")
            self.Owner:SetAnimation( PLAYER_ATTACK1 )

            timer.Simple(self.spawnDelay, function()

                self:SetHoldType("normal")

            end)

            buildedProp:EmitSound('phx/epicmetal_hard4.wav')

            self.spawnCurTime = CurTime() + self.spawnDelay

            ply:AddPlayerMoney(-propPrice)

        end)

        net.Receive('DeleteProp', function(_, ply)

            if CurTime() <= self.spawnCurTime then return end

            local prop = net.ReadEntity()

            if not IsValid(prop) then return end
            if prop:GetCreator() ~= ply then return end
            if prop:GetClass() ~= 'engineerprop' then return end
            if ply:GetPos():Distance(prop:GetPos()) > 200 then return end

            prop:EmitSound('phx/epicmetal_hard.wav')

            prop:Remove()

            self.spawnCurTime = CurTime() + self.spawnDelay

        end)

    end

end

if CLIENT then

    hook.Add('HUDPaint', 'EngineerHUDDeleteProp', function()

    	local stareAtProp = LocalPlayer():GetEyeTrace().Entity
        if not IsValid(LocalPlayer():GetActiveWeapon()) or LocalPlayer():Health() < 0 then return end
        if LocalPlayer():GetActiveWeapon():GetClass() ~= 'weapon_engineerkey' then return end

        if not IsValid(stareAtProp) then return end
        if stareAtProp:GetClass() ~= 'engineerprop' then return end
        if stareAtProp:GetNWEntity('PropOwner') ~= LocalPlayer() then return end
        if LocalPlayer():GetPos():Distance(stareAtProp:GetPos()) > 200 then return end

        drawTextWithShadow('Z - удалить', 'MenuFont', ScrW() / 2, ScrH() / 2 + 75, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end)

    hook.Add('HUDPaint', 'EngineerHUDPreviewProp', function()

    	local stareAtProp = LocalPlayer():GetEyeTrace().Entity
        if not IsValid(LocalPlayer():GetActiveWeapon()) or LocalPlayer():Health() < 0 then return end
        if LocalPlayer():GetActiveWeapon():GetClass() ~= 'weapon_engineerkey' then return end

        drawTextWithShadow('Использовано пропов: ' .. LocalPlayer():GetNWInt('OwnerPropAmount', 0) .. ' / 10', 'MenuFont', ScrW() / 2, ScrH() / 2 - 105, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        if LocalPlayer():GetEyeTrace().HitPos:Distance(LocalPlayer():GetPos()) > 200 then return end
                
        drawTextWithShadow('E - крутить по оси Х', 'MenuFont', ScrW() / 2, ScrH() / 2 + 105, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        drawTextWithShadow('R - крутить по оси Y', 'MenuFont', ScrW() / 2, ScrH() / 2 + 135, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        drawTextWithShadow('T - крутить по оси Z', 'MenuFont', ScrW() / 2, ScrH() / 2 + 165, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        drawTextWithShadow('С - восстановить позицию по умолчанию', 'MenuFont', ScrW() / 2, ScrH() / 2 + 195, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end)

end