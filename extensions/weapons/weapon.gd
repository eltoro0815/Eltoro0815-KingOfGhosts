extends "res://weapons/weapon.gd"


var image_number = 0
var kills_counter_hp = 0

const eltoro0815_primary_stat_keys = [
	"stat_max_hp",
	"stat_armor",
	"stat_crit_chance",
	"stat_luck",
	"stat_attack_speed",
	"stat_elemental_damage",
	"stat_hp_regeneration",
	"stat_lifesteal",
	"stat_melee_damage",
	"stat_percent_damage",
	"stat_dodge",
	"stat_engineering",
	"stat_range",
	"stat_ranged_damage",
	"stat_speed",
	"stat_harvesting"
]

var img_ghost_sword_blood = [
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_0_1.png"), #0
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_1_1.png"), #1
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_2_1.png"), #2
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_3_1.png"), #3
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_4_1.png"), #4
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_5_1.png"), #5
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_0_2.png"), #6
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_1_2.png"), #7
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_2_2.png"), #8
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_3_2.png"), #9
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_4_2.png"), #10
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_sword_blood_5_2.png")  #11
]

	
func update_ghost_sword()->void :
	if weapon_id == "weapon_ghost_sword":
		sprite.texture = img_ghost_sword_blood[image_number]
	

func map_percentage_to_values(percent: float) -> int:
	var index = 0
	if percent >= 0.05:
		index = 1
	if percent >= 0.15:
		index = 2
	if percent >= 0.25:
		index = 3
	if percent >= 0.35:
		index = 4
	if percent >= 0.45:
		index = 5
	if percent >= 0.5:
		index = 6
	if percent >= 0.55:
		index = 7
	if percent >= 0.65:
		index = 8
	if percent >= 0.75:
		index = 9
	if percent >= 0.85:
		index = 10
	if percent >= 0.95:
		index = 11
	
	
	return index


func get_image_number_from_kills(actual_kills, needed_kills) :
	var percent_value : float = float(actual_kills)/float(needed_kills)
	
	return map_percentage_to_values(percent_value)




var isntanceOfRandomNumberGenerator = RandomNumberGenerator.new()


func get_random_stat() :
	isntanceOfRandomNumberGenerator.randomize()
	
	var random_index = isntanceOfRandomNumberGenerator.randi_range(0, 15)
	
	return eltoro0815_primary_stat_keys[random_index]

	
	
	
func on_killed_something(_thing_killed:Node)->void :
	
	nb_enemies_killed_this_wave += 1

	var ghost_crown_effect = RunData.effects['ghost_crown_effect']
	

	var ghost_cape_effect = RunData.effects['ghost_cape_effect']
	

	for effect in effects:

		if effect is GainStatEveryKilledEnemiesEffect:

			if weapon_id == "weapon_ghost_sword" :
				if effect.custom_key == "ghost_sword_blood":
					kills_counter_hp += 1
			
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
					kills_counter_hp = 0
					update_ghost_sword()
				
				if effect.custom_key == "ghost_club_random_stat":
					RunData.add_stat(get_random_stat(), effect.stat_nb + ghost_cape_effect)
				else:
					RunData.add_stat(effect.stat, effect.stat_nb + ghost_cape_effect)
					
				emit_signal("tracked_value_updated")
			else :
				if effect.custom_key == "ghost_sword_blood":
					var new_image_number = get_image_number_from_kills(kills_counter_hp, effect_value)
					if new_image_number != image_number:
						image_number = new_image_number
						update_ghost_sword()
	RunData.emit_stats_updated()
