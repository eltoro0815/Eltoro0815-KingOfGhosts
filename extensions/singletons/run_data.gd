extends "res://singletons/run_data.gd"


func init_effects()->Dictionary:
	var mod_effects = {
		"ghost_crown_effect":0,
		"ghost_cape_effect":0
	}
	var effects = .init_effects()
	effects.merge(mod_effects)
	
	return effects

	
