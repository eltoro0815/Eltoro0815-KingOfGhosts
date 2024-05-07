extends "res://singletons/item_service.gd"

var _RNG = RandomNumberGenerator.new()

func get_rand_item_for_wave(wave:int, type:int, excluded_items:Array = [], owned_items:Array = [], fixed_tier:int = - 1)->ItemParentData:

	var _new_item = .get_rand_item_for_wave(wave, type, excluded_items, owned_items, fixed_tier)



	# we get the item by the vanilla class
	# if it's a weapon from Tier4 (red weapons)
	# we replace it with a random Legendary Weapon
	if type == TierData.WEAPONS and _new_item.tier == Tier.LEGENDARY:

		# do not replace an already legendary weapon by a random one
		if hasLegendaryClass(_new_item):
			return _new_item

		var chance_change_to_legendary_weapon = 0.50
		var rand_chance_change_to_legendary_weapon = randf()

		if (rand_chance_change_to_legendary_weapon <= chance_change_to_legendary_weapon):
			var legendary_weapons = getAllLegendaryWeapons()

			_RNG.randomize()
			var rand_index = _RNG.randi_range(0, legendary_weapons.size() - 1)
			return legendary_weapons[rand_index]


	return _new_item


func getAllLegendaryWeapons():
	var weapon_pool = get_pool(Tier.LEGENDARY, TierData.WEAPONS)
	var legendary_weapons = []
	for weapon in weapon_pool:
		if hasLegendaryClass(weapon):
			legendary_weapons.append(weapon)

	return legendary_weapons


func hasLegendaryClass(weapon):
	var hasLegendaryClass = false

	if weapon.sets.size() > 0:
		for set in weapon.sets:
			if set.my_id == "set_legendary":
				hasLegendaryClass = true

	return hasLegendaryClass
