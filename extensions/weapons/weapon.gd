extends "res://weapons/weapon.gd"

	
	
func on_killed_something(_thing_killed:Node)->void :
	
	nb_enemies_killed_this_wave += 1
		
	var ghost_crown_effect = RunData.effects['ghost_crown_effect']
	
	var ghost_cape_effect = RunData.effects['ghost_cape_effect']
	
	for effect in effects:
		
		if effect is GainStatEveryKilledEnemiesEffect:
			
			var effect_value = int(effect.value - ghost_crown_effect)
			
			if effect_value < 1:
				effect_value = 1
			
			if nb_enemies_killed_this_wave % effect_value == 0:
				RunData.add_stat(effect.stat, effect.stat_nb + ghost_cape_effect)
				emit_signal("tracked_value_updated")
				
	RunData.emit_stats_updated()
