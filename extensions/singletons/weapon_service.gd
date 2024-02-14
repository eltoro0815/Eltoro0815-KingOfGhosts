extends "res://singletons/weapon_service.gd"

	
func init_base_stats(from_stats:WeaponStats, weapon_id:String = "", sets:Array = [], effects:Array = [], is_structure:bool = false)->WeaponStats:

	var base_stats = from_stats.duplicate()
	var new_stats:WeaponStats
	var is_exploding = false

	if from_stats is MeleeWeaponStats:
		new_stats = MeleeWeaponStats.new()
	else :
		new_stats = RangedWeaponStats.new()

	for weapon_bonus in RunData.effects["weapon_bonus"]:
		if weapon_id == weapon_bonus[0]:
			base_stats.set(weapon_bonus[1], base_stats.get(weapon_bonus[1]) + weapon_bonus[2])

	for class_bonus in RunData.effects["weapon_class_bonus"]:
		for set in sets:
			if set.my_id == class_bonus[0]:
				var value = base_stats.get(class_bonus[1]) + class_bonus[2]

				if class_bonus[1] == "lifesteal":
					value = base_stats.get(class_bonus[1]) + (class_bonus[2] / 100.0)
				base_stats.set(class_bonus[1], value)

	for effect in effects:
		if effect is BurningEffect:
			base_stats.burning_data = BurningData.new(effect.burning_data.chance, effect.burning_data.damage, effect.burning_data.duration, 0)
		elif effect is WeaponStackEffect:
			var nb_same_weapon = 0

			for checked_weapon in RunData.weapons:
				if checked_weapon.weapon_id == effect.weapon_stacked_id:
					nb_same_weapon += 1

			base_stats.set(effect.stat_name, base_stats.get(effect.stat_name) + (effect.value * max(0.0, nb_same_weapon - 1)))
		elif effect.key	== "weapon_item_stack_effect":
			var nb_num_of_item = 0

			for item in RunData.items:
				if item.my_id == effect.weapon_item_stacked_id:
					nb_num_of_item += 1
			
			base_stats.set(effect.stat_name, base_stats.get(effect.stat_name) + (effect.value * max(0.0, nb_num_of_item)))
			
			
		elif effect is ExplodingEffect:
			is_exploding = true

	new_stats.scaling_stats = base_stats.scaling_stats

	var atk_spd = (Utils.get_stat("stat_attack_speed") + base_stats.attack_speed_mod) / 100.0

	if is_structure:
		atk_spd = 0

	new_stats.burning_data = init_burning_data(base_stats.burning_data, false, is_structure)
	new_stats.min_range = base_stats.min_range if not RunData.effects["no_min_range"] else 0
	new_stats.effect_scale = base_stats.effect_scale

	if atk_spd > 0:
		new_stats.cooldown = max(2, base_stats.cooldown * (1 / (1 + atk_spd))) as int
		new_stats.recoil = base_stats.recoil / (1 + atk_spd)
		new_stats.recoil_duration = base_stats.recoil_duration / (1 + atk_spd)
	else :
		new_stats.cooldown = max(2, base_stats.cooldown * (1 + abs(atk_spd))) as int
		new_stats.recoil = base_stats.recoil
		new_stats.recoil_duration = base_stats.recoil_duration

	new_stats.attack_speed_mod = base_stats.attack_speed_mod
	new_stats.max_range = base_stats.max_range

	if is_structure:
		new_stats.max_range = base_stats.max_range

	new_stats.damage = base_stats.damage
	new_stats.damage = max(1.0, new_stats.damage + get_scaling_stats_value(base_stats.scaling_stats)) as int

	var percent_dmg_bonus = (1 + (Utils.get_stat("stat_percent_damage") / 100.0))
	var exploding_dmg_bonus = 0

	if is_structure:
		percent_dmg_bonus = 1

	if is_exploding:
		exploding_dmg_bonus = (Utils.get_stat("explosion_damage") / 100.0)

	new_stats.damage = max(1, round(new_stats.damage * (percent_dmg_bonus + exploding_dmg_bonus))) as int

	new_stats.crit_damage = base_stats.crit_damage

	new_stats.crit_chance = base_stats.crit_chance + (Utils.get_stat("stat_crit_chance") / 100.0)

	if is_structure:
		new_stats.crit_chance = base_stats.crit_chance

	new_stats.accuracy = (base_stats.accuracy + (RunData.effects["accuracy"] / 100.0))
	new_stats.is_healing = base_stats.is_healing

	new_stats.lifesteal = ((Utils.get_stat("stat_lifesteal") / 100.0) + base_stats.lifesteal)

	if is_structure:
		new_stats.lifesteal = base_stats.lifesteal

	new_stats.knockback = max(0.0, base_stats.knockback + RunData.effects["knockback"]) as int

	new_stats.shooting_sounds = base_stats.shooting_sounds
	new_stats.sound_db_mod = base_stats.sound_db_mod
	new_stats.additional_cooldown_every_x_shots = base_stats.additional_cooldown_every_x_shots
	new_stats.additional_cooldown_multiplier = base_stats.additional_cooldown_multiplier

	return new_stats
