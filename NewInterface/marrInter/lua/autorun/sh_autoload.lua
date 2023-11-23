cl_fls = file.Find('autorun/mr_interface/cl_interface/*', 'LUA')
sh_fls = file.Find('autorun/mr_interface/*', 'LUA')
sv_fls = file.Find('autorun/mr_interface/sv_interface/*', 'LUA')

fls = {}

table.Add(fls, cl_fls)
table.Add(fls, sh_fls)
table.Add(fls, sv_fls)

MsgC(Color(255, 255, 255), '[MarrInt]', Color(0, 128, 0), ' Loading...' .. '\n')

if CLIENT then

    for k,v in pairs(fls) do

            if string.sub(v, 0, 3) == 'cl_' then

                include('autorun/mr_interface/cl_interface/' .. v)
                MsgC(Color(255, 255, 255), '[CL]', Color(0, 128, 0), ' icluded ' .. v .. '\n')

            end

            if string.sub(v, 0, 3) == 'sh_' then

                include('autorun/mr_interface/' .. v)
                MsgC(Color(255, 255, 255), '[CL]', Color(0, 128, 0), ' icluded ' .. v .. '\n')

            end

    end

end

if SERVER then

    for k,v in pairs(fls) do

        if string.sub(v, 0, 3) == 'cl_' then

            AddCSLuaFile('autorun/mr_interface/cl_interface/' .. v)
            MsgC(Color(255, 0, 0), '[SV]', Color(0, 128, 0), ' icluded ' .. v .. '\n')

        end

        if string.sub(v, 0, 3) == 'sh_' then

            include('autorun/mr_interface/' .. v)
            AddCSLuaFile('autorun/mr_interface/' .. v)
            MsgC(Color(255, 0, 0), '[SV]', Color(0, 128, 0), ' icluded ' .. v .. '\n')

        end

        if string.sub(v, 0, 3) == 'sv_' then

            include('autorun/mr_interface/sv_interface/' .. v)
            MsgC(Color(255, 0, 0), '[SV]', Color(0, 128, 0), ' icluded ' .. v .. '\n')

        end

    end 

end