include("autorun/sh_config.lua")
AddCSLuaFile("cl_fonts.lua")

DarkWar.QMenu = function()
	
    if CONFIG.job_access[LocalPlayer():Team()] then
        
        if CONFIG.job_access[LocalPlayer():Team()].q_menu then

            return true
        
        end
    
    else
        
        return false

    end

end

hook.Add("SpawnMenuOpen", "QMenu", DarkWar.QMenu)

DarkWar.CMenu = function()

    if CONFIG.job_access[LocalPlayer():Team()] then
        
        if CONFIG.job_access[LocalPlayer():Team()].c_menu then

            return true
        
        end
    
    else
        
        return false

    end

end

hook.Add("ContextMenuOpen", "CMenu", DarkWar.CMenu)