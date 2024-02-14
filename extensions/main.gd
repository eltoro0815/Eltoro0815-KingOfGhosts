extends "res://main.gd"

func _on_EntitySpawner_player_spawned(player:Player)->void :
	var character = RunData.current_character
	var effect_hp_start_next_wave = RunData.effects["hp_start_next_wave"]
	
	if RunData.effects["hp_start_next_wave"] != 100:
		if character.my_id == "character_ghostking_desc":
			RunData.effects["hp_start_next_wave"] = 33
			
	._on_EntitySpawner_player_spawned(player)
