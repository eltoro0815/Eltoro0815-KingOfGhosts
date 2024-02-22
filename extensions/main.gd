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
	
	if level == 1 or level == 10:
		var character = RunData.current_character
		if character.my_id == "character_ghostking_desc":
			add_n_weird_ghosts(1)
				
	if level == 20:
		var character = RunData.current_character
		if character.my_id == "character_ghostking_desc":
			add_n_weird_ghosts(2)
				
	if level == 30:
		var character = RunData.current_character
		if character.my_id == "character_ghostking_desc":
			add_n_weird_ghosts(3)
	
	if level == 40:
		var character = RunData.current_character
		if character.my_id == "character_ghostking_desc":
			add_n_weird_ghosts(5)
			
	if level == 50:
		var character = RunData.current_character
		if character.my_id == "character_ghostking_desc":
			add_n_weird_ghosts(8)
			
	if level == 60:
		var character = RunData.current_character
		if character.my_id == "character_ghostking_desc":
			add_n_weird_ghosts(13)
			
	if level == 70:
		var character = RunData.current_character
		if character.my_id == "character_ghostking_desc":
			add_n_weird_ghosts(21)
			
	if level == 80:
		var character = RunData.current_character
		if character.my_id == "character_ghostking_desc":
			add_n_weird_ghosts(34)
			
	if level == 90:
		var character = RunData.current_character
		if character.my_id == "character_ghostking_desc":
			add_n_weird_ghosts(55)
			
	if level == 100:
		var character = RunData.current_character
		if character.my_id == "character_ghostking_desc":
			add_n_weird_ghosts(89)



func add_n_weird_ghosts(n: int):
	var weird_ghost_item = ItemService.get_element(ItemService.items, "item_weird_ghost")
	if weird_ghost_item != null:
		for i in range(0,n): # i gets the values 0,1, ..., n-1 (weird syntax^^)
			RunData.add_item(weird_ghost_item)
