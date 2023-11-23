util.AddNetworkString("f4menu")

DarkWar.F4MenuFunc = function(ply)
    
    net.Start("f4menu")
    net.Send(ply)

    return false 

end

hook.Add("ShowSpare2", "F4MenuFunc", DarkWar.F4MenuFunc)