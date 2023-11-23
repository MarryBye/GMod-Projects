mr = {}

function mr.Box(x, y, w, h, clr, mat)

    surface.SetDrawColor(clr)
    
    if mat then 
    
        surface.SetTexture(surface.GetTextureID(mat))
        surface.DrawTexturedRect(x, y, w, h)

        return

    end

    surface.DrawRect(x, y, w, h)

end

function mr.GetTextSize(txt, font)

    surface.SetFont(font)
    return surface.GetTextSize(txt)

end

function mr.SimpleText(text, font, x, y, clr, invertOutline, ax, ay)

    surface.SetFont(font)

    local w, h = mr.GetTextSize(text, font)
    local posx, posy = x - w * 0.5, y - h * 0.5

    surface.SetTextPos(x + 1, y + 1)

    if ax == 1 then

        x = posx
        surface.SetTextPos(x + 1, y + 1)

    end

    if ay == 1 then

        y = posy
        surface.SetTextPos(x + 1, y + 1)

    end
    
    if invertOutline then
        
        surface.SetTextColor(clr:colorInversion())
   
    else

        surface.SetTextColor(clrs['BLACK'])

    end

    surface.DrawText(text)

    surface.SetTextPos(x, y)
    surface.SetFont(font)
    surface.SetTextColor(clr)
    surface.DrawText(text)

end

function mr.SmartText(x, y, font, invertOutline, ax, ay, ...)

    local args = {...}
    local txt = ''

    for i = 1, #args do

        local arg = args[i] 
        local arg_type = type(arg)
        
        if arg_type != 'table' then

            txt = txt .. arg

        end

    end

    surface.SetFont(font)

    local w, h = mr.GetTextSize(txt, font)
    local posx, posy = x - w * 0.5, y - h * 0.5

    surface.SetTextPos(x + 1, y + 1)

    if ax == 1 then

        x = posx
        surface.SetTextPos(x + 1, y + 1)

    end

    if ay == 1 then

        y = posy
        surface.SetTextPos(x + 1, y + 1)

    end

    surface.SetTextColor(clrs['BLACK'])

    for i = 1, #args do

        local arg = args[i] 
        local arg_type = type(arg)

        if arg_type == 'table' then
            
            if invertOutline then
                
                surface.SetTextColor(arg:colorInversion())

            end

        else

            surface.DrawText(arg)

        end

    end

    surface.SetTextPos(x, y)

    for i = 1, #args do

        local arg = args[i] 
        local arg_type = type(arg)

        if arg_type == 'table' then

            surface.SetTextColor(arg)

        else
            
            surface.DrawText(arg)

        end

    end

end