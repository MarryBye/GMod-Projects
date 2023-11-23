DeriveGamemode( "sandbox" )

GM.Name = "DarkWar"
GM.Author = "MarryBye"

DEFINE_BASECLASS("gamemode_sandbox")
GM.Sandbox = BaseClass

GM.Config = GM.Config or {}

print('/////////////////////////////////////////////////////////////////')
print('DARKWAR MODULE LOADING (SV)')

include('gmconfig/gmconfig.lua')
print('CONFIG LOADED')

include('meta_modules/player/sv_player_meta.lua')
include('meta_modules/player/sh_player_meta.lua')
print('PLAYER META LOADED')

include('meta_modules/npc/sv_npc_meta.lua')
include('meta_modules/npc/sh_npc_meta.lua')
print('NPC META LOADED')

include('meta_modules/weapon/sh_weapon_meta.lua')
print('WEAPON META LOADED')

include('modules/_match_funcs/sh_funcs.lua')
include('modules/_match_funcs/sv_funcs.lua')
print('MATCH FUNCS LOADED')

include('modules/sv_mainHooks.lua')
print('MAIN LOADED')

include('modules/player_hooks/sv_playerHooks.lua')
include('modules/player_hooks/sv_playerHooks/sv_playerHooks_NETS.lua')
include('modules/player_hooks/sv_playerHooks/sv_playerHooks_THINK.lua')
include('modules/player_hooks/sv_playerHooks/sv_playerHooks_RESTRICTS.lua')
include('modules/player_hooks/sv_playerHooks/sv_playerHooks_PHYSGUN.lua')
include('modules/player_hooks/sv_playerHooks/sv_playerHooks_CMD.lua')
print('PLAYER FUNCS LOADED')
print('/////////////////////////////////////////////////////////////////')
print(' ')
print('/////////////////////////////////////////////////////////////////')
print('DARKWAR MODULE LOADING (CL)')

AddCSLuaFile('cl_init.lua')

AddCSLuaFile('gmconfig/gmconfig.lua')
print('CONFIG LOADED')

AddCSLuaFile('meta_modules/player/cl_player_meta.lua')
AddCSLuaFile('meta_modules/player/sh_player_meta.lua')
print('PLAYER META LOADED')

AddCSLuaFile('meta_modules/npc/sh_npc_meta.lua')
print('NPC META LOADED')

AddCSLuaFile('meta_modules/weapon/sh_weapon_meta.lua')
print('WEAPON META LOADED')

AddCSLuaFile('modules/_match_funcs/sh_funcs.lua')
AddCSLuaFile('modules/_customdraw_funcs/cl_funcs.lua')
print('MATCH FUNCS LOADED')

AddCSLuaFile('modules/player_hooks/cl_playerHooks.lua')
AddCSLuaFile('modules/player_hooks/cl_mainVars.lua')
AddCSLuaFile('modules/player_hooks/cl_playerHooks/cl_playerHooks_TAB.lua')
AddCSLuaFile('modules/player_hooks/cl_playerHooks/cl_playerHooks_HUD.lua')
AddCSLuaFile('modules/player_hooks/cl_playerHooks/cl_playerHooks_WallHack.lua')
AddCSLuaFile('modules/player_hooks/cl_playerHooks/cl_playerHooks_NOTIFY.lua')
AddCSLuaFile('modules/player_hooks/cl_playerHooks/cl_playerHooks_DEATHNOTIFY.lua')
AddCSLuaFile('modules/player_hooks/cl_playerHooks/cl_playerHooks_DAMAGENOTIFY.lua')
AddCSLuaFile('modules/player_hooks/cl_playerHooks/cl_playerHooks_ADMMENU.lua')
AddCSLuaFile('modules/player_hooks/cl_playerHooks/cl_playerHooks_DEATHSCREEN.lua')
print('MAIN LOADED')
print('/////////////////////////////////////////////////////////////////')
print(' ')

for i = 1, 7 do

	resource.AddFile('materials/crosshair' .. i .. '.png')
	resource.AddFile('materials/indicator' .. i .. '.png')

end

resource.AddFile('materials/menu_logo.png')
resource.AddFile('materials/demoIco.png')
resource.AddFile('materials/engIco.png')
resource.AddFile('materials/medIco.png')
resource.AddFile('materials/assIco.png')
resource.AddFile('materials/snipIco.png')
resource.AddFile('materials/tankIco.png')
resource.AddFile('sound/plane.wav')

util.AddNetworkString('JoinTeam')
util.AddNetworkString('CharEdit')
util.AddNetworkString('OpenTab')
util.AddNetworkString('NotificattionsNet')
util.AddNetworkString('NotificattionsDeathNet')
util.AddNetworkString('OpenAdminMenu')
util.AddNetworkString('ExecuteAdminCommand')
util.AddNetworkString('SpectateMode')

CreateConVar(GM.Config.firstTeamName, '0', FCVAR_REPLICATED)
CreateConVar(GM.Config.secondTeamName, '0', FCVAR_REPLICATED)

game.AddParticles( "particles/blood_impact.pcf" )
PrecacheParticleSystem( "blood_advisor_pierce_spray_c" )