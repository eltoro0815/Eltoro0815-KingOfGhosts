extends "res://main.gd"

func _on_EntitySpawner_player_spawned(player:Player)->void :
	var effect_hp_start_next_wave = RunData.effects["hp_start_next_wave"]

	if RunData.effects["hp_start_next_wave"] != 100:
		if RunData.effects["descendant_weird_ghost_effect"] != 0:
			RunData.effects["hp_start_next_wave"] = RunData.effects["descendant_weird_ghost_effect"]

	._on_EntitySpawner_player_spawned(player)

func on_levelled_up()->void :

	var level = RunData.current_level

	var n = 1
	var n_minus_1 = 1
	var n_minus_1_tmp = 1

	var spawn_weird_ghost_effect = 0
	if RunData.effects["ghost_descendant_get_weird_ghost"]>0:
		spawn_weird_ghost_effect = RunData.effects["ghost_descendant_get_weird_ghost"]

	if level == 1 or level == 5:
		if spawn_weird_ghost_effect>0:
			add_n_weird_ghosts(n * spawn_weird_ghost_effect)

	n_minus_1_tmp = n_minus_1
	n_minus_1 = n
	n = n + n_minus_1_tmp

	if level == 10:
		if spawn_weird_ghost_effect>0:
			add_n_weird_ghosts(n * spawn_weird_ghost_effect)

	n_minus_1_tmp = n_minus_1
	n_minus_1 = n
	n = n + n_minus_1_tmp
	if level == 20:
		if spawn_weird_ghost_effect>0:
			add_n_weird_ghosts(n * spawn_weird_ghost_effect)

	n_minus_1_tmp = n_minus_1
	n_minus_1 = n
	n = n + n_minus_1_tmp

	if level == 30:
		if spawn_weird_ghost_effect>0:
			add_n_weird_ghosts(n * spawn_weird_ghost_effect)

	n_minus_1_tmp = n_minus_1
	n_minus_1 = n
	n = n + n_minus_1_tmp

	if level == 40:
		if spawn_weird_ghost_effect>0:
			add_n_weird_ghosts(n * spawn_weird_ghost_effect)

	n_minus_1_tmp = n_minus_1
	n_minus_1 = n
	n = n + n_minus_1_tmp

	if level == 50:
		if spawn_weird_ghost_effect>0:
			add_n_weird_ghosts(n * spawn_weird_ghost_effect)

	n_minus_1_tmp = n_minus_1
	n_minus_1 = n
	n = n + n_minus_1_tmp

	if level == 60:
		if spawn_weird_ghost_effect>0:
			add_n_weird_ghosts(n * spawn_weird_ghost_effect)

	n_minus_1_tmp = n_minus_1
	n_minus_1 = n
	n = n + n_minus_1_tmp

	if level == 70:
		if spawn_weird_ghost_effect>0:
			add_n_weird_ghosts(n * spawn_weird_ghost_effect)

	n_minus_1_tmp = n_minus_1
	n_minus_1 = n
	n = n + n_minus_1_tmp

	if level == 80:
		if spawn_weird_ghost_effect>0:
			add_n_weird_ghosts(n * spawn_weird_ghost_effect)

	n_minus_1_tmp = n_minus_1
	n_minus_1 = n
	n = n + n_minus_1_tmp

	if level == 90:
		if spawn_weird_ghost_effect>0:
			add_n_weird_ghosts(n * spawn_weird_ghost_effect)

	n_minus_1_tmp = n_minus_1
	n_minus_1 = n
	n = n + n_minus_1_tmp

	if level == 100:
		if spawn_weird_ghost_effect>0:
			add_n_weird_ghosts(n * spawn_weird_ghost_effect)

	n_minus_1_tmp = n_minus_1
	n_minus_1 = n
	n = n + n_minus_1_tmp


	if level > 100:
		if level % 10 == 0:
			if spawn_weird_ghost_effect>0:
				add_n_weird_ghosts(n * spawn_weird_ghost_effect)

	.on_levelled_up() # we do it after adding the items to get stats immediatelly updated



func add_n_weird_ghosts(n: int):
	var weird_ghost_item = ItemService.get_element(ItemService.items, "item_weird_ghost")
	if weird_ghost_item != null:
		for i in range(0,n): # i gets the values 0,1, ..., n-1 (weird syntax^^)
			RunData.add_item(weird_ghost_item)


