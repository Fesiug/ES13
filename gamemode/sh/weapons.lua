ES.WeaponList = {
	["usp"] = {
		["Print Name"] = "USP-45",
		["Clip Start"] = 12,
		["Clip Reloaded"] = 12,
		["Clip Max"] = 12,
		
		["Weapon"] = true,
		["Fire Delay"] = 0.18,
		["Fire Max Burst"] = 1,
		["Fire Sound"] = {
			{
				s = "es13/weapons/usp_unsil-1.wav",
				c = CHAN_WEAPON
			},
		},

		["BulletInfo"] = {
			Num = 1,
			Spread = Vector( 0.02, 0.02, 0 ),
			Tracer = 0,
			Force = 0,
			Damage = 14,	-- Max damage
			Range = 10 * 64,		-- Max damage
			DamageMin = 10,	-- Min damage
			RangeMin = 5 * 64,	-- Min damage
		},

		["Viewmodel"] = "models/es13/weapons/v_usp.mdl",
		["Viewmodel_Right"] = "models/es13/weapons/v_usp_r.mdl",
		["Viewmodel_Left"] = "models/es13/weapons/v_usp_l.mdl",
		["ViewmodelAnims"] = {
			["idle"] = {
				NAME = "empty_idle",
			},
			["empty_idle"] = {
				NAME = "empty_idle",
			},
			["shoot"] = {
				NAME = "shoot",
				EVENTS = {},
			},
			["empty_shoot"] = {
				NAME = "empty_shoot",
				EVENTS = {
					[0.15] = {
						snd = {
							{
								s = "es13/weapons/usp_sliderelease.wav",
								c = CHAN_STATIC
							}
						},
					}
				},
			},
			["use"] = {
				NAME = "use",
			},
			["reload"] = {
				NAME = "reload",
				MISC = {
					HandDelay = 2.7,
					--GlobalDelay = 0
				},
				EVENTS = {
					[0.4] = {
						snd = {
							{
								s = "es13/weapons/usp_clipout.wav",
								c = CHAN_STATIC
							}
						},
					},
					[1.1] = {
						snd = {
							{
								s = "es13/weapons/usp_clipin.wav",
								c = CHAN_STATIC
							}
						},
					},
				},
			},
			["empty_reload"] = {
				NAME = "empty_reload",
				MISC = {
					HandDelay = 2.7,
					--GlobalDelay = 0
				},
				EVENTS = {
					[0.4] = {
						snd = {
							{
								s = "es13/weapons/usp_clipout.wav",
								c = CHAN_STATIC
							}
						},
					},
					[1.1] = {
						snd = {
							{
								s = "es13/weapons/usp_clipin.wav",
								c = CHAN_STATIC
							}
						},
					},
					[2.3] = {
						snd = {
							{
								s = "es13/weapons/usp_sliderelease.wav",
								c = CHAN_STATIC
							}
						},
					}
				},
			},
			["draw"] = {
				NAME = "draw",
				EVENTS = {},
			},
		},
		["Worldmodel"] = "models/weapons/w_pist_usp.mdl",
	},
	["deagle"] = {
		["Print Name"] = "DE-50",--"Deagle",
		["Clip Start"] = 7,
		["Clip Reloaded"] = 7,
		["Clip Max"] = 7,
		
		["Weapon"] = true,
		["Fire Delay"] = 0.34,
		["Fire Max Burst"] = 1,
		["Fire Sound"] = {
			{
				s = "es13/weapons/deagle-1.wav",
				c = CHAN_WEAPON
			},
		},

		["BulletInfo"] = {
			Num = 1,
			Spread = Vector( 0.05, 0.05, 0 ),
			Tracer = 0,
			Force = 0,
			Damage = 25,	-- Max damage
			Range = 10 * 64,		-- Max damage
			DamageMin = 20,	-- Min damage
			RangeMin = 5 * 64,	-- Min damage
		},

		["Viewmodel"] = "models/es13/weapons/v_deagle.mdl",
		["Viewmodel_Right"] = "models/es13/weapons/v_deagle_r.mdl",
		["Viewmodel_Left"] = "models/es13/weapons/v_deagle_l.mdl",
		["ViewmodelAnims"] = {
			["idle"] = {
				NAME = "idle",
			},
			["empty_idle"] = {
				NAME = "empty_idle",
			},
			["shoot"] = {
				NAME = "shoot",
				EVENTS = {},
			},
			["empty_shoot"] = {
				NAME = "empty_shoot",
				EVENTS = {
					[0.07] = {
						snd = {
							{
								s = "es13/weapons/sliderelease1.wav",
								c = CHAN_STATIC
							}
						},
					}
				},
			},
			["use"] = {
				NAME = "use",
			},
			["reload"] = {
				NAME = "reload",
				MISC = {
					HandDelay = 2.4,
					--GlobalDelay = 0
				},
				EVENTS = {
					[0.3] = {
						snd = {
							{
								s = "es13/weapons/de_clipout.wav",
								c = CHAN_STATIC
							}
						},
					},
					[1.2] = {
						snd = {
							{
								s = "es13/weapons/de_clipin.wav",
								c = CHAN_STATIC
							}
						},
					},
				},
			},
			["empty_reload"] = {
				NAME = "empty_reload",
				MISC = {
					HandDelay = 2.4,
					--GlobalDelay = 0
				},
				EVENTS = {
					[0.3] = {
						snd = {
							{
								s = "es13/weapons/de_clipout.wav",
								c = CHAN_STATIC
							}
						},
					},
					[1.2] = {
						snd = {
							{
								s = "es13/weapons/de_clipin.wav",
								c = CHAN_STATIC
							}
						},
					},
				},
			},
			["draw"] = {
				NAME = "draw",
				EVENTS = {},
			},
		},
		["Worldmodel"] = "models/weapons/w_pist_deagle.mdl",
	},
	["p90"] = {
		["Print Name"] = "SM-57",
		["Clip Start"] = 40,
		["Clip Reloaded"] = 40,
		["Clip Max"] = 40,
		
		["Weapon"] = true,
		["Fire Delay"] = 0.06,
		["Fire Max Burst"] = math.huge,
		["Fire Sound"] = {
			{
				s = "es13/weapons/p90-1.wav",
				c = CHAN_STATIC,
				p = 90
			},
		},

		["BulletInfo"] = {
			Num = 1,
			Spread = Vector( 0.07, 0.07, 0 ),
			Tracer = 1,
			Force = 1,
			Damage = 14,
		},

		["Viewmodel"] = "models/es13/weapons/v_p90.mdl",
		["ViewmodelAnims"] = {
			["idle"] = {
				NAME = "idle",
			},
			["shoot"] = {
				NAME = {"shoot1","shoot2","shoot3"},
				MISC = {["AnimMult"] = 0.8},
				EVENTS = {},
			},
			["empty_shoot"] = {
				NAME = {"shoot1","shoot2","shoot3"},
				MISC = {["AnimMult"] = 1.2},
				EVENTS = {
					[0.1] = {
						snd = { { s = "weapons/ar2/ar2_reload_rotate.wav", c = CHAN_STATIC } },
					},
				},
			},
			["reload"] = {
				NAME = "reload",
				MISC = {
					HandDelay = 3.4,
					AnimMult = 1.1
					--GlobalDelay = 0
				},
				EVENTS = {
					[0.4] = {
						snd = { { s = "es13/weapons/p90_cliprelease.wav", c = CHAN_STATIC } },
					},
					[1] = {
						snd = { { s = "es13/weapons/p90_clipout.wav", c = CHAN_STATIC } },
					},
					[1.9] = {
						snd = { { s = "es13/weapons/p90_clipin.wav", c = CHAN_STATIC } },
					},
					[2.9] = {
						snd = { { s = "es13/weapons/p90_boltpull.wav", c = CHAN_STATIC } },
					},
					[3.1] = {
						snd = { { s = "weapons/ar2/ar2_reload_push.wav", c = CHAN_STATIC } },
					},
				},
			},
			["draw"] = {
				NAME = "draw",
				EVENTS = {},
			},
		},
		["Worldmodel"] = "models/weapons/w_pist_deagle.mdl",
	},
	["mp9"] = {
		["Print Name"] = "SM-9 III",
		["Clip Start"] = 24,
		["Clip Reloaded"] = 24,
		["Clip Max"] = 24,
		
		["Weapon"] = true,
		["Fire Delay"] = 0.078,
		["Fire Max Burst"] = 3,
		["Fire Sound"] = {
			{
				s = "es13/weapons/glock18-2.wav",
				c = CHAN_STATIC,
				p = 130
			},
		},

		["BulletInfo"] = {
			Num = 1,
			Spread = Vector( 0.03, 0.03, 0 ),
			Tracer = 1,
			Force = 1,
			Damage = 16,
			Range = 10 * 64,		-- Max damage
			DamageMin = 10,	-- Min damage
			RangeMin = 5 * 64,	-- Min damage
		},

		["Viewmodel"] = "models/es13/weapons/v_tmp.mdl",
		["ViewmodelAnims"] = {
			["idle"] = {
				NAME = "idle",
			},
			["empty_idle"] = {
				NAME = "empty_idle",
			},
			["shoot"] = {
				NAME = "shoot",
				EVENTS = {},
			},
			["empty_shoot"] = {
				NAME = "empty_shoot",
				EVENTS = {
					[0.03] = {
						snd = { { s = "es13/weapons/slideback1.wav", c = CHAN_STATIC } },
					},
				},
			},
			["reload"] = {
				NAME = "reload",
				MISC = {
					HandDelay = 2.3,
					--GlobalDelay = 0
				},
				EVENTS = {
					[0.4] = {
						snd = { { s = "es13/weapons/clipout1.wav", c = CHAN_STATIC } },
					},
					[1] = {
						snd = { { s = "es13/weapons/clipin1.wav", c = CHAN_STATIC } },
					},
				},
			},
			["empty_reload"] = {
				NAME = "empty_reload",
				MISC = {
					HandDelay = 2.3,
					--GlobalDelay = 0
				},
				EVENTS = {
					[0.4] = {
						snd = { { s = "es13/weapons/clipout1.wav", c = CHAN_STATIC } },
					},
					[1] = {
						snd = { { s = "es13/weapons/clipin1.wav", c = CHAN_STATIC } },
					},
					[1.8] = {
						snd = { { s = "es13/weapons/slideback1.wav", c = CHAN_STATIC } },
					},
				},
			},
			["draw"] = {
				NAME = "draw",
				EVENTS = {},
			},
			["empty_draw"] = {
				NAME = "empty_draw",
				EVENTS = {},
			},
		},
		["Worldmodel"] = "models/weapons/w_pist_deagle.mdl",
	},
	["famas"] = {
		["Print Name"] = "ARM-64 MRB",
		["Clip Start"] = 25,
		["Clip Reloaded"] = 25,
		["Clip Max"] = 25,
		
		["Weapon"] = true,
		["Fire Delay"] = 0.13,
		["Fire Max Burst"] = math.huge,
		["Fire Sound"] = {
			{
				s = "es13/weapons/famas-1.wav",
				c = CHAN_STATIC,
				p = 100
			},
		},

		["BulletInfo"] = {
			Num = 1,
			Spread = Vector( 0.04, 0.04, 0 ),
			Tracer = 0,
			Force = 0,
			Damage = 14,	-- Max damage
			Range = 10 * 64,		-- Max damage
			DamageMin = 10,	-- Min damage
			RangeMin = 5 * 64,	-- Min damage
		},

		["Viewmodel"] = "models/es13/weapons/v_famas.mdl",
		["ViewmodelAnims"] = {
			["idle"] = {
				NAME = "idle",
			},
			["empty_idle"] = {
				NAME = "idle",
			},
			["shoot"] = {
				NAME = "shoot",
				EVENTS = {
					[0.03] = {
						snd = { { s = "es13/weapons/famas_boltslap.wav", c = CHAN_WEAPON } },
					},
				},
			},
			["empty_shoot"] = {
				NAME = "shoot",
				EVENTS = {
					[0.03] = {
						snd = { { s = "es13/weapons/famas_forearm.wav", c = CHAN_STATIC } },
					},
				},
			},
			["reload"] = {
				NAME = "reload",
				MISC = {
					HandDelay = 2.3,
					--GlobalDelay = 0
				},
				EVENTS = {
					[0.4] = {
						snd = { { s = "es13/weapons/famas_clipout.wav", c = CHAN_STATIC } },
					},
					[1] = {
						snd = { { s = "es13/weapons/famas_clipin.wav", c = CHAN_STATIC } },
					},
				},
			},
			["empty_reload"] = {
				NAME = "empty_reload",
				MISC = {
					HandDelay = 2.3,
					--GlobalDelay = 0
				},
				EVENTS = {
					[0.4] = {
						snd = { { s = "es13/weapons/famas_clipout.wav", c = CHAN_STATIC } },
					},
					[1] = {
						snd = { { s = "es13/weapons/famas_clipin.wav", c = CHAN_STATIC } },
					},
					[1.8] = {
						snd = { { s = "es13/weapons/famas_boltpull.wav", c = CHAN_STATIC } },
					},
				},
			},
			["draw"] = {
				NAME = "draw",
				EVENTS = {},
			},
		},
		["Worldmodel"] = "models/weapons/w_pist_deagle.mdl",
	},
	["oddball"] = {
		["Print Name"] = "Oddball",

		["Weapon"] = false,
		
		["Viewmodel"] = "models/weapons/cstrike/c_smg_mp5.mdl",
		["Worldmodel"] = "models/weapons/w_smg_mp5.mdl",
	},
	["radio"] = {
		["Print Name"] = "Handheld",

		["Weapon"] = false,
		
		["Viewmodel"] = "models/es13/weapons/v_radio_r.mdl",
		["Viewmodel_Left"] = "models/es13/weapons/v_radio_l.mdl",
		["ViewmodelAnims"] = {
			["idle"] = {
				NAME = "idle",
			},
			["use"] = {
				NAME = "use",
			},
			["draw"] = {
				NAME = "draw",
				EVENTS = {},
			},
		},
		["Worldmodel"] = "models/weapons/w_smg_mp5.mdl",
	}

}