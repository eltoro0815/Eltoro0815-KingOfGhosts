extends "res://main.gd"

func _on_EntitySpawner_player_spawned(player:Player)->void :
	var character = RunData.current_character
	var effect_hp_start_next_wave = RunData.effects["hp_start_next_wave"]
	
	if RunData.effects["hp_start_next_wave"] != 100:
		if character.my_id == "character_ghostking_desc":
			var descendant_weird_ghost_effect_value = RunData.effects["descendant_weird_ghost_effect"]
			if descendant_weird_ghost_effect_value == 0:
				descendant_weird_ghost_effect_value = 33 # bugfix
			if descendant_weird_ghost_effect_value == null:
				descendant_weird_ghost_effect_value = 33 # bugfix
			RunData.effects["hp_start_next_wave"] = descendant_weird_ghost_effect_value
			
	._on_EntitySpawner_player_spawned(player)
