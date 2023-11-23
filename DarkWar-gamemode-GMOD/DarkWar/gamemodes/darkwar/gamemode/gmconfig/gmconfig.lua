GM.Config.firstTeamName = 'Долг'
GM.Config.secondTeamName = 'Свобода'
GM.Config.adminTeamName = 'Администратор'

GM.Config.propsFreezeTime = 30
GM.Config.npcSpawnTime = 40
GM.Config.planeSpawnTime = 80
GM.Config.airdropAfterPlaneDropTime = 8

GM.Config.planeVector = Vector(-1026.765259, -3602.887451, 1388.566650)
GM.Config.planeAngle = Angle(0, 182, 0)
GM.Config.planeVectorTo = { xS = 0, yS = 50, zS = 0 } -- In which coordinates it will be move and how fast (1 - x, 2 - y, 3 - z)
GM.Config.airdropLoot = {'wf_wpn_smg31', 'wf_wpn_smg02', 'wf_wpn_smg44', 'wf_wpn_smg38'}

GM.Config.winPoints = 500
GM.Config.needToStartPlayers = 2

GM.Config.maxClipCanTake = 3
GM.Config.maxAmmoCanTake = 200

GM.Config.adminButtonsCommands = {

	[1] 	= { 	name = 'Кикнуть с сервера', 				func = function(ply, trg) trg:Kick() end 																						},
	[2] 	= { 	name = 'Телепортировать к себе',			func = function(ply, trg) trg:SetPos(ply:GetPos()) end 																			},
	[3] 	= { 	name = 'Телепортироваться к', 				func = function(ply, trg) ply:SetPos(trg:GetPos()) end 																			},
	[4] 	= { 	name = 'Убить', 							func = function(ply, trg) trg:KillSilent() end 																					},
	[5] 	= {		name = 'Забрать оружие', 					func = function(ply, trg) trg:StripWeapons() end 																				},
	[6] 	= { 	name = 'Дать денег', 						func = function(ply, trg) trg:AddPlayerMoney(500) end 																			},
	[7] 	= { 	name = 'Предупредить', 						func = function(ply, trg) trg:PrintMessage(HUD_PRINTCENTER, 'Предупреждение! Прекрати буянить или админ тебя покарает.') end 	},
	[8] 	= { 	name = 'Следить', 							func = function(ply, trg) ply:SetPlayerSpectator(true) end 																		},
	[9] 	= { 	name = 'Установить статус администратора', 	func = function(ply, trg) trg:SetPlayerAsAdmin(not trg:GetPlayerIsAdminRank()) end 												}

}

GM.Config.adminsList = { 

	['STEAM_0:1:527419720'] = true

}

GM.Config.propsForBuilding = {

    [1] 	=   {     name = 'Железная стена',        model = 'models/props_lab/blastdoor001b.mdl',                               hp = 500,   price = 175  },
    [2] 	=   {     name = 'Холодильник',           model = 'models/props_c17/FurnitureFridge001a.mdl',                         hp = 250,   price = 60   },
    [3] 	=   {     name = 'Дверь',                 model = 'models/props_c17/door01_left.mdl',                                 hp = 200,   price = 50   },
    [4] 	=   {     name = 'Бочка',                 model = 'models/props_c17/oildrum001.mdl',                                  hp = 200,   price = 50   },
    [5] 	=   {     name = 'Большой стол',          model = 'models/props_wasteland/kitchen_counter001a.mdl',                   hp = 300,   price = 80   },
    [6] 	=   {     name = 'Автомат с газировкой',  model = 'models/props_interiors/VendingMachineSoda01a.mdl',                 hp = 350,   price = 120  },
    [7] 	=   {     name = 'Деревянный шкаф',       model = 'models/props_c17/FurnitureDresser001a.mdl',                        hp = 200,   price = 50   },
    [8] 	=   {     name = 'Железная дверь',        model = 'models/props_building_details/Storefront_Template001a_Bars.mdl',   hp = 250,   price = 80   },
    [9] 	=   {     name = 'Зеленый шкаф',          model = 'models/props_wasteland/controlroom_storagecloset001a.mdl',         hp = 250,   price = 100  },
    [10] 	=  	{     name = 'Деревянная коробка',    model = 'models/props_junk/wood_crate001a.mdl',                             hp = 50,    price = 25   },
    [11] 	=  	{     name = 'Большой холодильник',   model = 'models/props_wasteland/kitchen_fridge001a.mdl',                    hp = 650,   price = 200  },
    [12] 	=  	{     name = 'Длинный стол',          model = 'models/props_combine/breendesk.mdl',                               hp = 200,   price = 75   },
    [13] 	=  	{     name = 'Баррикада',             model = 'models/props_c17/concrete_barrier001a.mdl',                        hp = 250,   price = 85   }

}

GM.Config.hitboxDamage = {

	[HITGROUP_HEAD] 	= { 	scale = false, 	scaleInt = 0, 	static = true, 	staticInt = 98 	},
	[HITGROUP_CHEST] 	= { 	scale = true, 	scaleInt = 1, 	static = false, staticInt = 0 	},
	[HITGROUP_STOMACH] 	= { 	scale = true, 	scaleInt = 0.9, static = false, staticInt = 0 	},
	[HITGROUP_LEFTARM] 	= { 	scale = true, 	scaleInt = 0.5, static = false, staticInt = 0 	},
	[HITGROUP_RIGHTARM] = { 	scale = true, 	scaleInt = 0.5, static = false, staticInt = 0 	},
	[HITGROUP_LEFTLEG] 	= { 	scale = true, 	scaleInt = 0.5, static = false, staticInt = 0 	},
	[HITGROUP_RIGHTLEG] = { 	scale = true, 	scaleInt = 0.5, static = false, staticInt = 0 	},

}

GM.Config.npcSpawnPositions = {

	[1] 	= { 	pos = Vector(489.233276, -1316.542114, -255.016891) },
	[2] 	= { 	pos = Vector(286.221802, -1448.680054, -255.016891) },
	[3] 	= { 	pos = Vector(1161.821655, 1656.867920, 509.983093) 	},
	[4] 	= { 	pos = Vector(904.773682, 1655.536987, 421.983093) 	},
	[5] 	= { 	pos = Vector(906.823303, 1389.667236, 309.983093) 	},
	[6] 	= { 	pos = Vector(899.683411, 1787.980347, 84.031250) 	},
	[7] 	= { 	pos = Vector(1203.225952, 1794.398193, 196.031250) 	},
	[8] 	= { 	pos = Vector(1213.521851, 1081.071777, 196.031250) 	},
	[9] 	= { 	pos = Vector(1198.712646, 400.125153, 196.031250) 	},
	[10] 	= { 	pos = Vector(1412.771973, 1393.483887, 196.031250) 	},
	[11] 	= { 	pos = Vector(1649.205811, 922.680481, -151.968750) 	}

}

GM.Config.spawnPositions = {

	[GM.Config.firstTeamName] = {

		[1] = { pos = Vector(830.46051025391, -908.90625, 68.03125) },
		[2] = { pos = Vector(695.81768798828, -775.59393310547, 68.03125) },
		[3] = { pos = Vector(618.70721435547, -607.49688720703, 68.03125) },
		[4] = { pos = Vector(1003.6522827148, -552.36584472656, 68.03125) },
		[5] = { pos = Vector(623.4462890625, -472.6682434082, 68.03125) }

	},

	[GM.Config.secondTeamName] = {

		[1] = { pos = Vector(249.419739, 2219.004883, 660.031250) },
		[2] = { pos = Vector(390.595612, 2241.103271, 660.031250) },
		[3] = { pos = Vector(373.958954, 2052.305420, 660.031250) },
		[4] = { pos = Vector(218.927155, 2012.118530, 660.031250) },
		[5] = { pos = Vector(571.231506, 2057.259766, 660.031250) }

	}

}

GM.Config.gunsCategories = {

	[1] = { 
		
		guns = {

			[1] = { gun = 'wf_wpn_pt41', price = 250, classification = 'Пистолет', desc = 'Пистолет с сильной отдачей, но добрым сердцем и большим уроном.' },
			[2] = { gun = 'wf_wpn_pt14', price = 250, classification = 'Пистолет', desc = 'Мне лень писать описание, но оно тут точно будет.' }

		}, 

		canUse = {

			['Штурмовик'] = true,
			['Снайпер'] = true,
			['Танк'] = true,
			['Подрывник'] = true,
			['Медик'] = true,
			['Инженер'] = true,
			[GM.Config.adminTeamName] = true

		}

	},

	[2] = { 
		
		guns = {

			[1] = { gun = 'wf_wpn_smg04', price = 300, classification = 'Пистолет-пулемет', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[2] = { gun = 'wf_wpn_smg38', price = 300, classification = 'Пистолет-пулемет', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[3] = { gun = 'wf_wpn_smg44', price = 300, classification = 'Пистолет-пулемет', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[4] = { gun = 'wf_wpn_smg02', price = 300, classification = 'Пистолет-пулемет', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[5] = { gun = 'wf_wpn_smg31', price = 300, classification = 'Пистолет-пулемет', desc = 'Мне лень писать описание, но оно тут точно будет.' }

		}, 

		canUse = {

			['Штурмовик'] = true,
			['Снайпер'] = true,
			['Танк'] = true,
			['Подрывник'] = true,
			['Медик'] = true,
			['Инженер'] = true,
			[GM.Config.adminTeamName] = true

		}

	},

	[3] = { 
		
		guns = {

			[1] = { gun = 'wf_wpn_ar31', price = 500, classification = 'Штурмовая винтовка', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[2] = { gun = 'wf_wpn_ar27', price = 500, classification = 'Штурмовая винтовка', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[3] = { gun = 'wf_wpn_ar02', price = 500, classification = 'Штурмовая винтовка', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[4] = { gun = 'wf_wpn_ar04', price = 500, classification = 'Штурмовая винтовка', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[5] = { gun = 'wf_wpn_ar29', price = 500, classification = 'Штурмовая винтовка', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[6] = { gun = 'wf_wpn_ar23', price = 500, classification = 'Штурмовая винтовка', desc = 'Мне лень писать описание, но оно тут точно будет.' }

		}, 

		canUse = {

			['Штурмовик'] = true,
			['Снайпер'] = false,
			['Танк'] = false,
			['Подрывник'] = false,
			['Медик'] = false,
			['Инженер'] = false,
			[GM.Config.adminTeamName] = true

		}

	},

	[4] = { 
		
		guns = {

			[1] = { gun = 'cw_pkm', price = 700, classification = 'Пулемет', desc = 'Мне лень писать описание, но оно тут точно будет.' }

		}, 

		canUse = {

			['Штурмовик'] = false,
			['Снайпер'] = false,
			['Танк'] = true,
			['Подрывник'] = false,
			['Медик'] = false,
			['Инженер'] = false,
			[GM.Config.adminTeamName] = true

		}

	},

	[5] = { 
		
		guns = {

			[1] = { gun = 'wf_wpn_sr34', price = 650, classification = 'Снайперская винтовка', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[2] = { gun = 'wf_wpn_sr43', price = 650, classification = 'Снайперская винтовка', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[3] = { gun = 'wf_wpn_sr02', price = 650, classification = 'Снайперская винтовка', desc = 'Мне лень писать описание, но оно тут точно будет.' }

		}, 

		canUse = {

			['Штурмовик'] = false,
			['Снайпер'] = true,
			['Танк'] = false,
			['Подрывник'] = false,
			['Медик'] = false,
			['Инженер'] = false,
			[GM.Config.adminTeamName] = true

		}

	},

	[6] = { 
		
		guns = {

			[1] = { gun = 'wf_wpn_kn14', price = 200, classification = 'Холодное оружие', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[2] = { gun = 'wf_wpn_kn01', price = 200, classification = 'Холодное оружие', desc = 'Мне лень писать описание, но оно тут точно будет.' }

		}, 

		canUse = {

			['Штурмовик'] = true,
			['Снайпер'] = true,
			['Танк'] = true,
			['Подрывник'] = true,
			['Медик'] = true,
			['Инженер'] = true,
			[GM.Config.adminTeamName] = true

		}

	},

	[7] = { 
		
		guns = {

			[1] = { gun = 'ins2_atow_rpg7', price = 700, classification = 'РПГ', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[2] = { gun = 'cw_a35', price = 800, classification = 'Гранатомет', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[3] = { gun = 'cw_frag_grenade', price = 100, classification = 'Граната', desc = 'Мне лень писать описание, но оно тут точно будет.' }

		}, 

		canUse = {

			['Штурмовик'] = false,
			['Снайпер'] = false,
			['Танк'] = false,
			['Подрывник'] = true,
			['Медик'] = false,
			['Инженер'] = false,
			[GM.Config.adminTeamName] = true

		}

	},

	[8] = {

		guns = {

			[1] = { gun = 'wf_wpn_shg07', price = 600, classification = 'Полу-автоматический дробовик', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[2] = { gun = 'wf_wpn_shg01', price = 600, classification = 'Помповый дробовик', desc = 'Мне лень писать описание, но оно тут точно будет.' },
			[3] = { gun = 'wf_wpn_shg44', price = 600, classification = 'Рычажный дробовик', desc = 'Мне лень писать описание, но оно тут точно будет.' }

		}, 

		canUse = {

			['Штурмовик'] = false,
			['Снайпер'] = false,
			['Танк'] = false,
			['Подрывник'] = false,
			['Медик'] = true,
			['Инженер'] = false,
			[GM.Config.adminTeamName] = true

		}

	}
}

GM.Config.playerClasses = {

	[1] = { 
		
		class = 'Штурмовик',
		icon = 'materials/assIco.png', 
		models = {

			[GM.Config.firstTeamName] = {

				'models/player/stalker/compiled 0.34/copduty_military.mdl', 
				'models/player/stalker/compiled 0.34/copduty_nimble.mdl'

			}, 

			[GM.Config.secondTeamName] = {

				'models/player/stalker/compiled 0.34/copfreedom_guardian.mdl'

			},

			['None'] = { 'models/player/skeleton.mdl' },
			[GM.Config.adminTeamName] = { 'models/player/skeleton.mdl' }

		},
		weaponsOnSpawn = {'wf_wpn_pt05'},
		resist = 0,
		speedWalk = 235,
		speedRun = 295

	},
	
	[2] = { 

		class = 'Снайпер', 
		icon = 'materials/snipIco.png', 
		models = {

			[GM.Config.firstTeamName] = {

				'models/player/stalker/compiled 0.34/copdutybulat_militaryreference.mdl', 
				'models/player/stalker/compiled 0.34/copdutybulat_nimblereference.mdl'

			}, 

			[GM.Config.secondTeamName] = {

				'models/player/stalker/compiled 0.34/copfreedom_sunrisesuit.mdl'

			},

			['None'] = { 'models/player/skeleton.mdl' },
			[GM.Config.adminTeamName] = { 'models/player/skeleton.mdl' }

		},
		weaponsOnSpawn = {'wf_wpn_pt05'},
		resist = 0,
		speedWalk = 215,
		speedRun = 260

	},
	
	[3] = { 

		class = 'Танк', 
		icon = 'materials/tankIco.png', 
		models = {

			[GM.Config.firstTeamName] = {

				'models/player/stalker/compiled 0.34/copduty_exomilitary.mdl', 
				'models/player/stalker/compiled 0.34/copduty_exonimble.mdl'

			}, 

			[GM.Config.secondTeamName] = {

				'models/player/stalker/compiled 0.34/copfreedom_exomilitary.mdl', 
				'models/player/stalker/compiled 0.34/copfreedom_exoreference2.mdl'

			},

			['None'] = { 'models/player/skeleton.mdl' },
			[GM.Config.adminTeamName] = { 'models/player/skeleton.mdl' }

		},
		weaponsOnSpawn = {'wf_wpn_pt05'},
		resist = 25,
		speedWalk = 180,
		speedRun = 230

	},
	
	[4] = { 

		class = 'Подрывник', 
		icon = 'materials/demoIco.png', 
		models = {

			[GM.Config.firstTeamName] = {

				'models/player/stalker/compiled 0.34/copduty_military.mdl', 
				'models/player/stalker/compiled 0.34/copduty_nimble.mdl'

			}, 

			[GM.Config.secondTeamName] = {

				'models/player/stalker/compiled 0.34/copfreedom_nimble.mdl', 
				'models/player/stalker/compiled 0.34/copfreedom_reference2.mdl'

			},

			['None'] = { 'models/player/skeleton.mdl' },
			[GM.Config.adminTeamName] = { 'models/player/skeleton.mdl' }

		},
		weaponsOnSpawn = {'wf_wpn_pt05'},
		resist = 0,
		speedWalk = 215,
		speedRun = 260

	},
	
	[5] = { 
		
		class = 'Медик', 
		icon = 'materials/medIco.png', 
		models = {

			[GM.Config.firstTeamName] = {

				'models/player/stalker/compiled 0.34/copduty_seva.mdl'

			}, 

			[GM.Config.secondTeamName] = {

				'models/player/stalker/compiled 0.34/copfreedom_seva.mdl'
			
			},

			['None'] = { 'models/player/skeleton.mdl' },
			[GM.Config.adminTeamName] = { 'models/player/skeleton.mdl' }

		},
		weaponsOnSpawn = {'wf_wpn_pt05', 'weapon_medkit'},
		resist = -5,
		speedWalk = 225,
		speedRun = 310

	},
	
	[6] = { 
		
		class = 'Инженер', 
		icon = 'materials/engIco.png', 
		models = {

			[GM.Config.firstTeamName] = {

				'models/player/stalker/compiled 0.34/copduty_reference2.mdl', 
				'models/player/stalker/compiled 0.34/copduty_reference.mdl'

			}, 

			[GM.Config.secondTeamName] = {

				'models/player/stalker/compiled 0.34/copwindoffreedom_military.mdl', 
				'models/player/stalker/compiled 0.34/copwindoffreedom_reference2.mdl'

			},

			['None'] = { 'models/player/skeleton.mdl' },
			[GM.Config.adminTeamName] = { 'models/player/skeleton.mdl' }

		},
		weaponsOnSpawn = {'wf_wpn_pt05', 'weapon_engineerkey'},
		resist = 0,
		speedWalk = 215,
		speedRun = 280

	}
} 

GM.Config.playerRanks = {

	[500] = { rankName = 'Любитель', icon = ''},
	[1500] = { rankName = 'Наемный убийца', icon = ''},
	[2500] = { rankName = 'Хитман', icon = ''},
	[3500] = { rankName = 'Безжалостный', icon = ''},
	[4500] = { rankName = 'Кореец', icon = ''},
	[5500] = { rankName = 'Китаец', icon = ''},
	[6500] = { rankName = 'Араб', icon = ''},
	[7500] = { rankName = 'Высшее существо', icon = ''},
	[8500] = { rankName = 'Император Дарквара', icon = ''}

}

GM.Config.dontDropAfterDeath = { 

	['weapon_medkit'] = true,
	['weapon_physgun'] = true,
	['weapon_empty_hands'] = true,
	['weapon_engineerkey'] = true

}

GM.Config.dontDeleteAfterFinal = {

	['buyernpc'] = true,
	['killstocash'] = true,
	['battlepoint'] = true,
	['ammogiver'] = true,
	['dolgchest'] = true,
	['svobodachest'] = true,
	['armstation'] = true,
	['healstation'] = true,
	['player_manager'] = true,
	['scene_manager'] = true,
	['beam'] = true,
	['bodyque'] = true,
	['gmod_gamerules'] = true,
	['network'] = true,
	['soundent'] = true,
	['spotlight_end'] = true,
	['predicted_viewmodel'] = true,
	['gmod_hands'] = true,
	['prop_door_rotating'] = true

}