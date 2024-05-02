extends "res://singletons/item_service.gd"

func get_rand_item_for_wave(wave:int, type:int, excluded_items:Array = [], owned_items:Array = [], fixed_tier:int = - 1)->ItemParentData:
	var rand_wanted = randf()
	var item_tier = get_tier_from_wave(wave)

	if fixed_tier != - 1:
		item_tier = fixed_tier


	if type == TierData.WEAPONS:
		item_tier = clamp(item_tier, RunData.effects["min_weapon_tier"], RunData.effects["max_weapon_tier"])



	var pool = get_pool(item_tier, type)
	var backup_pool = get_pool(item_tier, type)
	var items_to_remove = []



	for shop_item in excluded_items:

		pool.erase(shop_item[0])
		backup_pool.erase(shop_item[0])

	if type == TierData.WEAPONS:

		var bonus_chance_same_weapon_set = max(0, (MAX_WAVE_ONE_WEAPON_GUARANTEED + 1 - RunData.current_wave) * (BONUS_CHANCE_SAME_WEAPON_SET / MAX_WAVE_ONE_WEAPON_GUARANTEED))
		var chance_same_weapon_set = CHANCE_SAME_WEAPON_SET + bonus_chance_same_weapon_set

		if RunData.effects["no_melee_weapons"] > 0:
			for item in pool:
				if item.type == WeaponType.MELEE:
					backup_pool.erase(item)
					items_to_remove.push_back(item)

		if RunData.effects["no_ranged_weapons"] > 0:
			for item in pool:
				if item.type == WeaponType.RANGED:
					backup_pool.erase(item)
					items_to_remove.push_back(item)

		if RunData.weapons.size() > 0:
			if rand_wanted < CHANCE_SAME_WEAPON:

				var player_weapon_ids = []
				var nb_potential_same_weapons = 0

				for weapon in RunData.weapons:
					for item in pool:
						if item.weapon_id == weapon.weapon_id:
							nb_potential_same_weapons += 1
					player_weapon_ids.push_back(weapon.weapon_id)

				if nb_potential_same_weapons > 0:

					for item in pool:
						if not player_weapon_ids.has(item.weapon_id):

							items_to_remove.push_back(item)

			elif rand_wanted < chance_same_weapon_set:

				var player_sets = []
				var nb_potential_same_classes = 0

				for weapon in RunData.weapons:
					for set in weapon.sets:
						if not player_sets.has(set.my_id):
							player_sets.push_back(set.my_id)

				var weapons_to_potentially_remove = []

				for item in pool:
					var item_has_atleast_one_class = false
					for player_set_id in player_sets:
						for weapon_set in item.sets:
							if weapon_set.my_id == player_set_id:

								nb_potential_same_classes += 1
								item_has_atleast_one_class = true
								break

					if not item_has_atleast_one_class:
						weapons_to_potentially_remove.push_back(item)

				if nb_potential_same_classes > 0:

					for item in weapons_to_potentially_remove:
						items_to_remove.push_back(item)

	elif type == TierData.ITEMS and Utils.get_chance_success(CHANCE_WANTED_ITEM_TAG) and RunData.current_character.wanted_tags.size() > 0:

		for item in pool:
			var has_wanted_tag = false

			for tag in item.tags:
				if RunData.current_character.wanted_tags.has(tag):
					has_wanted_tag = true
					break

			if not has_wanted_tag:
				items_to_remove.push_back(item)



	var limited_items = {}

	for item in owned_items:
		if item.max_nb == 1:
			backup_pool.erase(item)
			items_to_remove.push_back(item)
		elif item.max_nb != - 1:
			if limited_items.has(item.my_id):
				limited_items[item.my_id][1] += 1
			else :
				limited_items[item.my_id] = [item, 1]

	for key in limited_items:
		if limited_items[key][1] >= limited_items[key][0].max_nb:
			backup_pool.erase(limited_items[key][0])
			items_to_remove.push_back(limited_items[key][0])



	# START code to have a higher chance to get legendary weapons
	if item_tier == Tier.LEGENDARY and type == TierData.WEAPONS:
		var chance_only_legendary_weapons = 1.0
		var rand_only_legendary_weapons = randf()
		print(rand_only_legendary_weapons)
		if (rand_only_legendary_weapons <= chance_only_legendary_weapons):

			for item in pool:
				if item.get_category() == Category.WEAPON:

					var has_legendary_set = false

					if item.sets.size() > 0:
						for set in item.sets:
							if set.my_id == "set_legendary":
								has_legendary_set = true

					if not has_legendary_set:
						items_to_remove.push_back(item)

					has_legendary_set = false
	# END code to have a higher chance to get legendary weapons



	for item in items_to_remove:
		print(item.my_id)
		pool.erase(item)




	var elt

	if pool.size() == 0:
		if backup_pool.size() > 0:

			elt = Utils.get_rand_element(backup_pool)
		else :

			elt = Utils.get_rand_element(_tiers_data[item_tier][type])
	else :
		elt = Utils.get_rand_element(pool)

	return elt
