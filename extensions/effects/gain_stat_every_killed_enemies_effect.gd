extends "res://effects/weapons/gain_stat_every_killed_enemies_effect.gd"

func get_args()->Array:
	
	var ghost_crown_effect = RunData.effects['ghost_crown_effect']
	var ghost_cape_effect = RunData.effects['ghost_cape_effect']
	
	var adjusted_value = value - ghost_crown_effect
	if custom_key == "ghost_sword_blood":
		adjusted_value = value - 2*ghost_crown_effect
	
	if adjusted_value < 1:
		adjusted_value = 1
	
	var str_stat_nb = str(stat_nb + ghost_cape_effect)
	var translated_stat = tr(stat.to_upper())
	var str_value = str(adjusted_value)
	
	
	return [str_stat_nb, translated_stat, str_value]

