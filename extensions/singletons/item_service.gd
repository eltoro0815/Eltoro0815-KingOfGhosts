extends "res://singletons/item_service.gd"

func get_value(wave:int, base_value:int, affected_by_items_price_stat:bool = true, is_weapon:bool = false, item_id:String = "")->int:

	var value = .get_value(wave, base_value, affected_by_items_price_stat, is_weapon, item_id)

	# if you have the rainbow ghost the price for a weapon is capped at the value of the rainbow_ghost_effect
	if is_weapon:
		var rainbow_ghost_effect = RunData.effects['rainbow_ghost_effect']
		if int(rainbow_ghost_effect) > 0:
			if int(value) > int(rainbow_ghost_effect):
				value = int(rainbow_ghost_effect)

	return value

