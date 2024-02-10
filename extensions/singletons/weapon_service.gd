extends "res://singletons/weapon_service.gd"


func init_base_stats(from_stats:WeaponStats, weapon_id:String = "", sets:Array = [], effects:Array = [], is_structure:bool = false)->WeaponStats:

	var new_stats = .init_base_stats(from_stats, weapon_id, sets, effects, is_structure)	
	var base_stats = from_stats.duplicate()
	var is_exploding = false
	
	for effect in effects:
		if effect is WeaponItemStackEffect:
			var nb_num_of_item = 0

			for item in RunData.items:
				if item.my_id == effect.weapon_item_stacked_id:
					nb_num_of_item += 1
			base_stats.set(effect.stat_name, base_stats.get(effect.stat_name) + (effect.value * max(0.0, nb_num_of_item)))
			
		elif effect is ExplodingEffect:
			is_exploding = true
			
	
	new_stats.damage = base_stats.damage
	new_stats.damage = max(1.0, new_stats.damage + get_scaling_stats_value(base_stats.scaling_stats)) as int

	var percent_dmg_bonus = (1 + (Utils.get_stat("stat_percent_damage") / 100.0))
	var exploding_dmg_bonus = 0

	if is_structure:
		percent_dmg_bonus = 1

	if is_exploding:
		exploding_dmg_bonus = (Utils.get_stat("explosion_damage") / 100.0)

	new_stats.damage = max(1, round(new_stats.damage * (percent_dmg_bonus + exploding_dmg_bonus))) as int
	
	return new_stats



