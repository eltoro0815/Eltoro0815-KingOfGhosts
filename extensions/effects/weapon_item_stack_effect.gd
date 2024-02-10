class_name WeaponItemStackEffect
extends NullEffect


export (String) var weapon_item_stacked_name
export (String) var weapon_item_stacked_id
export (String) var stat_displayed_name = "stat_damage"
export (String) var stat_name = "damage"


static func get_id()->String:
	return "weapon_item_stack"


func get_args()->Array:

	var nb_num_of_item = 0

	for item in RunData.items:
		if item.my_id == weapon_item_stacked_id:
			nb_num_of_item += 1

	return [
		str(value), 
		tr(stat_displayed_name.to_upper()), 
		tr(weapon_item_stacked_name.to_upper()), 
		str(max(0, nb_num_of_item * value))
	]


func serialize()->Dictionary:
	var serialized = .serialize()

	serialized.weapon_item_stacked_name = weapon_item_stacked_name
	serialized.weapon_item_stacked_id = weapon_item_stacked_id
	serialized.stat_displayed_name = stat_displayed_name
	serialized.stat_name = stat_name

	return serialized


func deserialize_and_merge(serialized:Dictionary)->void :
	.deserialize_and_merge(serialized)

	weapon_item_stacked_name = serialized.weapon_item_stacked_name
	weapon_item_stacked_id = serialized.weapon_item_stacked_id
	stat_displayed_name = serialized.stat_displayed_name
	stat_name = serialized.stat_name
