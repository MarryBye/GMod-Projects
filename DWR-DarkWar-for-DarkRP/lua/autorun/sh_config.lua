CONFIG = CONFIG or {}

CONFIG.HUD = {}
CONFIG.HUD.MarryBye = {}
CONFIG.HUD.Solyanka = {}

DarkWar = DarkWar or {}

-- Оружия у торговца
CONFIG.gun_shop = 
{

	[1] = { class = "swb_hl2_uspmk1", cost = 30, name = "USP CMB Mk1", model = "models/weapons/w_pistol.mdl", allowed = { TEAM_METROPOLICE, TEAM_ELITEMETROPOLICE, TEAM_ALLIANCEMEDIC, TEAM_HARDOTA, TEAM_METROPOLICECOMMANDER, TEAM_REBEL, TEAM_ELITEREBEL, TEAM_FEELREBEL, TEAM_GORDON } },
	[2] = { class = "swb_hl2_uspmk2", cost = 60, name = "USP CMB Mk2", model = "models/weapons/metropolice_smg/usp/w_usp_match.mdl", allowed = { TEAM_METROPOLICE, TEAM_ELITEMETROPOLICE, TEAM_ALLIANCEMEDIC, TEAM_HARDOTA, TEAM_METROPOLICECOMMANDER, TEAM_REBEL, TEAM_ELITEREBEL, TEAM_FEELREBEL, TEAM_GORDON } },
	[3] = { class = "swb_hl2_357", cost = 120, name = ".357 Magnum", model = "models/weapons/w_357.mdl", allowed = { TEAM_ELITEMETROPOLICE, TEAM_HARDOTA, TEAM_METROPOLICECOMMANDER, TEAM_ELITEREBEL, TEAM_GORDON } },
	[4] = { class = "swb_hl2_alyx", cost = 135, name = "Alyx gun", model = "models/weapons/w_alyx_gun.mdl", allowed = { TEAM_REBEL, TEAM_ELITEREBEL, TEAM_FEELREBEL, TEAM_GORDON } },
	[5] = { class = "swb_hl2_mp5k", cost = 150, name = "MP5K Mk1", model = "models/weapons/w_smg2.mdl", allowed = { TEAM_METROPOLICE, TEAM_ALLIANCEMEDIC } },
	[6] = { class = "swb_hl2_mp5kmk2", cost = 185, name = "MP5K Mk2", model = "models/weapons/metropolice_smg/mp5k/w_mp5k.mdl", allowed = { TEAM_METROPOLICECOMMANDER } },
	[7] = { class = "swb_hl2_mp7", cost = 200, name = "HK MP7 CMB", model = "models/weapons/w_smg1.mdl", allowed = { TEAM_METROPOLICE, TEAM_ALLIANCEMEDIC } },
	[8] = { class = "swb_hl2_tmp", cost = 200, name = "Steyr TMP CMB", model = "models/weapons/w_smg3.mdl", allowed = { TEAM_METROPOLICE } },
	[9] = { class = "swb_hl2_ar2", cost = 250, name = "Issue Pulse Rifle Mk1", model = "models/weapons/w_irifle.mdl", allowed = { TEAM_ELITEMETROPOLICE,TEAM_ELITEREBEL } },
	[10] = { class = "swb_hl2_ar2mk2", cost = 375, name = "Issue Pulse Rifle Mk2", model = "models/weapons/c_cmar2.mdl", allowed = { TEAM_METROPOLICECOMMANDER, TEAM_GORDON } },
	[11] = { class = "swb_hl2_oicw", cost = 230, name = "XM29 OICW CMB Mk1", model = "models/weapons/w_oicw.mdl", allowed = { TEAM_ELITEMETROPOLICE, TEAM_ELITEREBEL } },
	[12] = { class = "swb_hl2_oicwmk2", cost = 275, name = "XM29 OICW CMB Mk2", model = "models/weapons/metropolice_smg/oicw/w_oicw.mdl", allowed = { TEAM_METROPOLICECOMMANDER, TEAM_GORDON } },
	[13] = { class = "swb_hl2_spas12mk1", cost = 190, name = "SPAS-12 CMB Mk1", model = "models/weapons/w_shotgun.mdl", allowed = { TEAM_HARDOTA } },
	[14] = { class = "swb_hl2_spas12mk2", cost = 220, name = "SPAS-12 CMB Mk2", model = "models/weapons/metropolice_smg/spas12/w_spas12.mdl", allowed = { TEAM_HARDOTA } },
	[15] = { class = "swb_hl2_rtboicw", cost = 300, name = "XM29 RTB OICW CMB", model = "models/leakwep/w_o1c4.mdl", allowed = { TEAM_METROPOLICECOMMANDER } },
	[16] = { class = "swb_hl2_snipmk1", cost = 450, name = "Sniper Rifle CMB Mk1", model = "models/rtb_weapons/w_sniper.mdl", allowed = { TEAM_FEELREBEL } },
	[17] = { class = "swb_hl2_snipmk2", cost = 600, name = "Sniper Rifle CMB Mk2", model = "models/weapons/w_combinesniper_e2.mdl", allowed = { TEAM_FEELREBEL } },
	[18] = { class = "swb_hl2_crossbow", cost = 380, name = "Crossbow", model = "models/weapons/w_crossbow.mdl", allowed = { TEAM_FEELREBEL } },
	[19] = { class = "swb_hl2_gr9", cost = 320, name = "GR9 CMB Machine gun", model = "models/weapons/w_hmg.mdl", allowed = { TEAM_METROPOLICECOMMANDER, TEAM_GORDON } },
	[20] = { class = "swb_hl2_gr9mk2", cost = 400, name = "GR9 CMB Shotgun", model = "models/weapons/w_combine_GR9.mdl", allowed = { TEAM_HARDOTA, TEAM_GORDON } },
	[21] = { class = "weapon_frag", cost = 75, name = "Grenade", model = "models/items/grenadeammo.mdl", allowed = { TEAM_ELITEMETROPOLICE, TEAM_HARDOTA, TEAM_METROPOLICECOMMANDER } },
	[22] = { class = "lockpick", cost = 75, name = "Lockpick", model = "models/weapons/w_crowbar.mdl", allowed = { TEAM_ADM } }

}

-- Какие патроны получит человек при спавне
CONFIG.spawn_ammo = 
{

	[1] = { cnt = 60, type = 3 }, -- HL2 USP
	[2] = { cnt = 30, type = 5 }, -- HL2 .357
	[3] = { cnt = 150, type = 4 }, -- HL2 MP7
	[4] = { cnt = 150, type = 1 }, -- HL2 AR2
	[5] = { cnt = 60, type = 7 }, -- HL2 Shotgun
	[6] = { cnt = 30, type = 6 }, -- HL2 Crossbow
	[7] = { cnt = 3, type = 8 }, -- HL2 RPG
	[8] = { cnt = 3, type = 10 } -- HL2 Grenade

}

-- В какой позиции будут спавниться NPC
CONFIG.enemy_npc_pos = 
{

	[1] = Vector( 1133.560547, -1566.474609, -424.766388 ),
	[2] = Vector( 1136.218750, -1735.084717, -423.893311 ),
	[3] = Vector( 804.544617, -1750.232422, -423.256958 ),
	[4] = Vector( 793.292969, -1560.418701, -417.214355 ),
	[5] = Vector( 924.501526, -1672.588013, -425.187500 ),
	[6] = Vector( 465.739288, -1666.487671, -422.359497 ),
	[7] = Vector( 671.086060, -1798.435425, -423.848206 ),
	[8] = Vector( 1703.344360, -1177.187012, 192.031250 ),
	[9] = Vector( 1555.524658, -1545.199829, 192.031250 ),
	[10] = Vector( 1518.058472, -960.934509, 192.031250 ),
	[11] = Vector( 1307.564209, -1313.897217, 192.031250 ),
	[12] = Vector( 1101.005249, -1571.905151, 192.031250 ),
	[13] = Vector( 1128.680420, -851.364380, 192.031250 ),
	[14] = Vector( 931.220032, -915.841736, 192.031250 )

}

-- Вражеские NPC
CONFIG.enemy_npcs = 
{

	"npc_zombie",
	"npc_fastzombie",
	"npc_poisonzombie",
	"npc_headcrab_black",
	"npc_headcrab_fast",
	"npc_headcrab",
	"npc_zombie_torso",
	"npc_fastzombie_torso"

}

-- Группы аминистраторов
CONFIG.admins = 
{

	["superadmin"] = true,
	["admin"] = true

}

timer.Simple(0.1, function()
	
	-- Профессии наблюдателей
	CONFIG.job_viewers = 
	{

		[TEAM_CITIZEN] = true,
		[TEAM_ADM] = true

	}

	-- Какие будут резист в % у профессий
	CONFIG.job_resists = 
	{

		[TEAM_METROPOLICE] = { resist = 15, check = true },
		[TEAM_ELITEMETROPOLICE] = { resist = 25, check = true },
		[TEAM_HARDOTA] = { resist = 35, check = true },
		[TEAM_METROPOLICECOMMANDER] = { resist = 25, check = true },
		[TEAM_REBEL] = { resist = 10, check = true },
		[TEAM_ELITEREBEL] = { resist = 20, check = true },
		[TEAM_ENGINEER] = { resist = 5, check = true },
		[TEAM_ALLIANCEMEDIC] = { resist = 10, check = true },
		[TEAM_FEELREBEL] = { resist = 10, check = true },
		[TEAM_GORDON] = { resist = 30, check = true }

	}

	-- Профессии с доступом к C, Q меню и физгану
	CONFIG.job_access = 
	{

		[TEAM_ADM] = { phys = true, tool = false, prop_spawn = false, q_menu = true, c_menu = false }

	}

end)

-- Какие оружия не выпадут после смерти
CONFIG.dont_drop_after_death = 
{

	['gmod_tool'] = true,
	['weapon_physgun'] = true,
	['door_ram'] = true,
	['arrest_stick'] = true,
	['keys'] = true,
	['weapon_cuff_rope'] = true,
	['weapon_medkit_elite'] = true

}

-- Ранги, которые будут выдаваться игрокам за достижение нужного кол-ва опыта.
CONFIG.player_ranks = 
{

	[1] = { name = 'Начинающий', exp = 0, icon = 'icon16/asterisk_orange.png' },
	[2] = { name = 'Прошаренный', exp = 15, icon = 'icon16/asterisk_yellow.png' },
	[3] = { name = 'Нагибучий', exp = 30, icon = 'icon16/award_star_bronze_1.png' },
	[4] = { name = 'Профессионал', exp = 60, icon = 'icon16/award_star_bronze_2.png' },
	[5] = { name = 'Читер', exp = 120, icon = 'icon16/award_star_bronze_3.png' },
	[6] = { name = 'Сверхчеловек', exp = 240, icon = 'icon16/award_star_gold_1.png' },
	[7] = { name = 'Инопришеленец', exp = 480, icon = 'icon16/award_star_gold_2.png' },
	[8] = { name = 'Повелитель', exp = 960, icon = 'icon16/award_star_gold_3.png' },
	[9] = { name = 'Темный воин', exp = 1920, icon = 'icon16/award_star_silver_1.png' }

}

-- Звуки, которые произносят игроки на клавишу +zoom
CONFIG.player_sounds = 
{

	'vo/npc/male01/headsup02.wav',
	'vo/npc/male01/likethat.wav',
	'vo/npc/male01/oneforme.wav',
	'vo/npc/male01/sorrydoc02.wav',
	'vo/npc/male01/yeah02.wav',
	'vo/npc/male01/yougotit02.wav',
	'vo/npc/male01/whoops01.wav'

}

-- Музыка, которая будет играть у игроков
CONFIG.war_music = 
{

	'music/soundtrack3/walk_new_morning.mp3',
	'music/soundtrack3/walk_safe.mp3',
	'music/soundtrack3/walk_dust.mp3',
	'music/soundtrack3/walk_interlude.mp3',
	'music/soundtrack3/walk_blizzard.mp3'
	
}

CONFIG.f_faction = 'Альянс' -- Первая фракция
CONFIG.s_faction = 'Сопротивление' -- Вторая фракция
CONFIG.start_money = 50 -- Стартовые деньги для проигравшей команды/новых игроков.
CONFIG.win_goal = 50 -- Сколько нужно очков команде для победы
CONFIG.win_money = 100 -- Победный приз для выигравшей команды (стартовые деньги для этих игроков)
CONFIG.win_team = 2 -- Профессия (ее номер) для ВСЕХ игроков после каждого раунда
CONFIG.win_exp = 10 -- Сколько опыта за победу
CONFIG.npc_resist = 45 -- Резист в % к урону у npc
CONFIG.can_ram_props = true -- Разрешено ли ломать пропы тараном
CONFIG.abilities = false -- Вкл/выкл. способности.
CONFIG.drop_weapons = true -- Вкл/выкл. выпадение оружия из игроков после смерти.
CONFIG.npc_kill_prise = 25 -- Награда за убийство NPC
CONFIG.npc_kill_exp_prise = 1 -- Сколько опыта за убийство NPC
CONFIG.npc_dead_lose = 50 -- Потеря денег за смерть от NPC
CONFIG.player_kill_prise = 50 -- Награда за убийство игрока.
CONFIG.player_kill_exp_prise = 3 -- Сколько опыта за убийство игрока
CONFIG.player_arrest_prise = 125 -- Награда за арест игрока
CONFIG.frag_cost = 15 -- Стоимость обмена 1 фрага
CONFIG.capture_prise = 30 -- Сколько денег в CONFIG.point_prise_delay приносит точка
CONFIG.point_radius = 450 -- В каком радиусе от точки надо быть для захвата
CONFIG.point_capture_delay = 60 -- Сколько секунд захватывается точка
CONFIG.point_cooldown_delay = 120 -- Сколько нужно ждать перед повторным захватом точки
CONFIG.point_prise_delay = 60 -- Через какое время приходит постоянная награда за захват
CONFIG.capture_goal = 3 -- Сколько поинтов добавится команде за захват точки
CONFIG.player_min_money = 250 -- После какого кол-ва денег перестанет даваться награда за убийство
CONFIG.npc_spawn_delay = 240 -- В секундах; через какое время будет делаться спавн NPC
CONFIG.team_fire_dmg = 0 -- Сколько урона наносят тиммейты друг другу
CONFIG.spawn_ragdoll = true -- Будут ли спавниться после смерти игрока его регдоллы
CONFIG.ragdoll_life_time = 60 -- Сколько будут лежать регдоллы игрока
CONFIG.music_cooldown = 450 -- Через какое время будет включен новый трек у игроков.