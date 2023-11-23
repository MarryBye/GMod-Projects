DeriveGamemode( "sandbox" )

GM.Name = "DarkWar"
GM.Author = "MarryBye"

DEFINE_BASECLASS("gamemode_sandbox")
GM.Sandbox = BaseClass

GM.Config = {}

include('gmconfig/gmconfig.lua')

include('meta_modules/player/cl_player_meta.lua')
include('meta_modules/player/sh_player_meta.lua')

include('meta_modules/npc/sh_npc_meta.lua')

include('meta_modules/weapon/sh_weapon_meta.lua')

include('modules/_match_funcs/sh_funcs.lua')
include('modules/_customdraw_funcs/cl_funcs.lua')

include('modules/player_hooks/cl_playerHooks.lua')
include('modules/player_hooks/cl_mainVars.lua')
include('modules/player_hooks/cl_playerHooks/cl_playerHooks_TAB.lua')
include('modules/player_hooks/cl_playerHooks/cl_playerHooks_HUD.lua')
include('modules/player_hooks/cl_playerHooks/cl_playerHooks_WallHack.lua')
include('modules/player_hooks/cl_playerHooks/cl_playerHooks_NOTIFY.lua')
include('modules/player_hooks/cl_playerHooks/cl_playerHooks_DEATHNOTIFY.lua')
include('modules/player_hooks/cl_playerHooks/cl_playerHooks_DAMAGENOTIFY.lua')
include('modules/player_hooks/cl_playerHooks/cl_playerHooks_ADMMENU.lua')
include('modules/player_hooks/cl_playerHooks/cl_playerHooks_DEATHSCREEN.lua')

CreateConVar(GM.Config.firstTeamName, '0', FCVAR_REPLICATED)
CreateConVar(GM.Config.secondTeamName, '0', FCVAR_REPLICATED)

CreateClientConVar('dwr_crosshair', '1', true, false, "", 1, 7)
CreateClientConVar('dwr_indicator', '1', true, false, "", 1, 7)
CreateClientConVar('dwr_crosshair_size', '24', true, false, "", 2, 256)
CreateClientConVar('dwr_indicator_size', '32', true, false, "", 2, 256)

CreateClientConVar('dwr_color', '200 200 200', true, false, "", 1, 255)
CreateClientConVar('dwr_color_ind', '200 200 200', true, false, "", 1, 255)
CreateClientConVar('dwr_color_ico', '200 200 200', true, false, "", 1, 255)

game.AddParticles( "particles/blood_impact.pcf" )
PrecacheParticleSystem( "blood_advisor_pierce_spray_c" )