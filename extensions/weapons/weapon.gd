extends "res://weapons/weapon.gd"


var image_number = 0
var kills_counter = 0
var img_ghost_sword_blood = [
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_0.png"),
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_1.png"),
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_2.png"),
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_3.png"),
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_4.png"),
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_5.png")
]

	
func update_ghost_sword()->void :
	if weapon_id == "weapon_ghost_sword":
		sprite.texture = img_ghost_sword_blood[image_number]
	

func map_percentage_to_values(percent: float) -> int:
	var index = 0
	if percent >= 0.1:
		index = 1
	if percent >= 0.3:
		index = 2
	if percent >= 0.5:
		index = 3
	if percent >= 0.7:
		index = 4
	if percent >= 0.9:
		index = 5

	return index


func get_image_number_from_kills(actual_kills, needed_kills) :
	var percent_value : float = float(actual_kills)/float(needed_kills)
	return map_percentage_to_values(percent_value)

	
func on_killed_something(_thing_killed:Node)->void :
	
	nb_enemies_killed_this_wave += 1

	var ghost_crown_effect = RunData.effects['ghost_crown_effect']

	var ghost_cape_effect = RunData.effects['ghost_cape_effect']

	for effect in effects:

		if effect is GainStatEveryKilledEnemiesEffect:

			if weapon_id == "weapon_ghost_sword" :
				if effect.custom_key == "ghost_sword_blood":
					kills_counter += 1
			
			var effect_value = 0
			
			if effect.custom_key == "ghost_sword_gain_hp":
				# double the ghost_crown_effect on HP effect to keep the ratio %damage to maxHP to 1:2
				effect_value = int(effect.value - (2*ghost_crown_effect))
			else:
				effect_value = int(effect.value - ghost_crown_effect)
			

			if effect_value < 1:
				effect_value = 1

			if nb_enemies_killed_this_wave % effect_value == 0:
				if effect.custom_key == "ghost_sword_blood":
					image_number = 0
					kills_counter = 0
					update_ghost_sword()
					
				RunData.add_stat(effect.stat, effect.stat_nb + ghost_cape_effect)
				emit_signal("tracked_value_updated")
			else :
				if effect.custom_key == "ghost_sword_blood":
					var new_image_number = get_image_number_from_kills(kills_counter, effect_value)
					if new_image_number != image_number:
						image_number = new_image_number
						update_ghost_sword()
	RunData.emit_stats_updated()
