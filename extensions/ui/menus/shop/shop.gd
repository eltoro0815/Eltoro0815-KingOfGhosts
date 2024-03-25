extends "res://ui/menus/shop/shop.gd"

# we det weapons by position to be synchronous with RunData.remove_weapon()
func get_ghost_club_stats(weapon:WeaponData, pos:int=0)->Dictionary:
	var tracked_stats_gained := {
		"stat_max_hp" : 0,
		"stat_armor" : 0,
		"stat_crit_chance" : 0,
		"stat_luck" : 0,
		"stat_attack_speed" : 0,
		"stat_elemental_damage" : 0,
		"stat_hp_regeneration" : 0,
		"stat_lifesteal" : 0,
		"stat_melee_damage" : 0,
		"stat_percent_damage" : 0,
		"stat_dodge" : 0,
		"stat_engineering" : 0,
		"stat_range" : 0,
		"stat_ranged_damage" : 0,
		"stat_speed" : 0,
		"stat_harvesting" : 0,
		"ghost_club_blank" : 0 # chance that you gain nothing
	}
	
	var i = 0
	for current_weapon in RunData.weapons:
		if current_weapon.my_id == weapon.my_id:
			tracked_stats_gained = current_weapon.tracked_stats_gained
			if (i == pos): break
			i += 1
			
	return tracked_stats_gained


func on_item_combine_button_pressed(weapon_data:WeaponData, is_upgrade:bool = false)->void :
	_focus_manager.reset_focus()

	var nb_to_remove = 2
	var removed_weapons_tracked_value = 0

	if is_upgrade:
		nb_to_remove = 1



	var tracked_stats_gained := {
		"stat_max_hp" : 0,
		"stat_armor" : 0,
		"stat_crit_chance" : 0,
		"stat_luck" : 0,
		"stat_attack_speed" : 0,
		"stat_elemental_damage" : 0,
		"stat_hp_regeneration" : 0,
		"stat_lifesteal" : 0,
		"stat_melee_damage" : 0,
		"stat_percent_damage" : 0,
		"stat_dodge" : 0,
		"stat_engineering" : 0,
		"stat_range" : 0,
		"stat_ranged_damage" : 0,
		"stat_speed" : 0,
		"stat_harvesting" : 0,
		"ghost_club_blank" : 0 # chance that you gain nothing
	}
	
	if weapon_data.weapon_id == "weapon_ghost_club":
		if is_upgrade:
			tracked_stats_gained = weapon_data.tracked_stats_gained
		
		if not is_upgrade:
		
			var first_tracked_stats_gained = get_ghost_club_stats(weapon_data, 0)
			var second_tracked_stats_gained = get_ghost_club_stats(weapon_data, 1)
			for key in second_tracked_stats_gained:
				first_tracked_stats_gained[key] += second_tracked_stats_gained[key]
			
			tracked_stats_gained = first_tracked_stats_gained
			
		

	_weapons_container._elements.remove_element(weapon_data, nb_to_remove)
	removed_weapons_tracked_value += RunData.remove_weapon(weapon_data)

	if not is_upgrade:
		removed_weapons_tracked_value += RunData.remove_weapon(weapon_data)

	reset_item_popup_focus()

	var new_weapon = RunData.add_weapon(weapon_data.upgrades_into)
	
	if weapon_data.weapon_id == "weapon_ghost_club":
		new_weapon.tracked_stats_gained = tracked_stats_gained

	new_weapon.tracked_value = removed_weapons_tracked_value

	if is_upgrade:
		new_weapon.dmg_dealt_last_wave = weapon_data.dmg_dealt_last_wave

	_stats_container.update_stats()

	_weapons_container._elements.add_element(new_weapon)

	if Input.get_mouse_mode() == Input.MOUSE_MODE_HIDDEN:
		_weapons_container._elements.focus_element(new_weapon)

	SoundManager.play(Utils.get_rand_element(combine_sounds), 0, 0.1, true)
	_weapons_container.set_label(get_weapons_label_text())
