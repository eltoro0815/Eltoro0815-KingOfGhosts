extends "res://main.gd"

func _on_EntitySpawner_player_spawned(player:Player)->void :
	var character = RunData.current_character
	var effect_hp_start_next_wave = RunData.effects["hp_start_next_wave"]
	
	if RunData.effects["hp_start_next_wave"] != 100:
		if RunData.effects["descendant_weird_ghost_effect"] != 0:
			RunData.effects["hp_start_next_wave"] = RunData.effects["descendant_weird_ghost_effect"]
			
	._on_EntitySpawner_player_spawned(player)

func on_levelled_up()->void :
	
	.on_levelled_up()
	
	var level = RunData.current_level
	
	if level == 10:
		var character = RunData.current_character
		if character.my_id == "character_ghostking_desc":
			var weird_ghost_item = ItemService.get_element(ItemService.items, "item_weird_ghost")
		
			if weird_ghost_item != null:
				RunData.add_item(weird_ghost_item)
				
				
	if level == 20:
		var character = RunData.current_character
		if character.my_id == "character_ghostking_desc":
			var weird_ghost_item = ItemService.get_element(ItemService.items, "item_weird_ghost")
		
			if weird_ghost_item != null:
				RunData.add_item(weird_ghost_item)
				RunData.add_item(weird_ghost_item)
				
	if level == 30:
		var character = RunData.current_character
		if character.my_id == "character_ghostking_desc":
			var weird_ghost_item = ItemService.get_element(ItemService.items, "item_weird_ghost")
		
			if weird_ghost_item != null:
				RunData.add_item(weird_ghost_item)
				RunData.add_item(weird_ghost_item)
				RunData.add_item(weird_ghost_item)
