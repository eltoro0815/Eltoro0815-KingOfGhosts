extends "res://weapons/weapon.gd"


var image_number_sword = 0
var kills_counter_hp_sword = 0

var image_number_club = 0
var kills_counter_club = 0

const stats_distribution_relative_frequencies = {
	"stat_max_hp" : 80,
	"stat_armor" : 10,
	"stat_crit_chance" : 30,
	"stat_luck" : 100,
	"stat_attack_speed" : 100,
	"stat_elemental_damage" : 20,
	"stat_hp_regeneration" : 10,
	"stat_lifesteal" : 10,
	"stat_melee_damage" : 40,
	"stat_percent_damage" : 160,
	"stat_dodge" : 60,
	"stat_engineering" : 20,
	"stat_range" : 80,
	"stat_ranged_damage" : 20,
	"stat_speed" : 10,
	"stat_harvesting" : 160,
	"ghost_club_blank" : 240 # chance that you gain nothing
}

func getDistributionSumAll() :
	var sum = 0
	for stat in stats_distribution_relative_frequencies:
		sum += stats_distribution_relative_frequencies[stat]
	return sum 
	
var isntanceOfRandomNumberGenerator = RandomNumberGenerator.new()


func get_random_stat() :
	isntanceOfRandomNumberGenerator.randomize()
	
	var sum_all_stats = getDistributionSumAll()
	
	var search_number = isntanceOfRandomNumberGenerator.randi_range(0, sum_all_stats)
	
	#print("search_number: " , search_number)
	
	var temp_sum = 0
	for stat in stats_distribution_relative_frequencies:
		temp_sum += stats_distribution_relative_frequencies[stat]
		#print("temp_sum:", temp_sum)
		if search_number <= temp_sum:
			#print(search_number, " <= ", temp_sum, ": ", stat)
			return stat
	
	return "ghost_club_blank"
	
	
	
	

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

var img_ghost_club_blood = [
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_club_blood_0.png"), #0
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_club_blood_1.png"), #1
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_club_blood_2.png"), #2
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_club_blood_3.png"), #3
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_club_blood_4.png"), #4
	load("res://mods-unpacked/Eltoro0815-KingOfGhosts/overwrites/eltoro0815_ghost_club_blood_5.png"), #5
]

	
	
func update_ghost_sword()->void :
	if weapon_id == "weapon_ghost_sword":
		sprite.texture = img_ghost_sword_blood[image_number_sword]
	
	
	
func update_ghost_club()->void :
	if weapon_id == "weapon_ghost_club":
		sprite.texture = img_ghost_club_blood[image_number_club]




func map_percentage_to_values_sword(percent: float) -> int:
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



func map_percentage_to_values_club(percent: float) -> int:
	var index = 0
	if percent >= 0.1:
		index = 1
	if percent >= 0.3:
		index = 2
	if percent >= 0.5:
		index = 3
	if percent >= 0.7:
		index = 4
	if percent >= 0.95:
		index = 5

	return index



func get_image_number_from_kills_sword(actual_kills, needed_kills) :
	var percent_value : float = float(actual_kills)/float(needed_kills)
	
	return map_percentage_to_values_sword(percent_value)



func get_image_number_from_kills_club(actual_kills, needed_kills) :
	var percent_value : float = float(actual_kills)/float(needed_kills)
	
	return map_percentage_to_values_club(percent_value)


	
	
	
func on_killed_something(_thing_killed:Node)->void :
	
	nb_enemies_killed_this_wave += 1

	var ghost_crown_effect = RunData.effects['ghost_crown_effect']
	

	var ghost_cape_effect = RunData.effects['ghost_cape_effect']
	

	for effect in effects:

		if effect is GainStatEveryKilledEnemiesEffect:

			if weapon_id == "weapon_ghost_sword" :
				if effect.custom_key == "ghost_sword_blood":
					kills_counter_hp_sword += 1
			
			if weapon_id == "weapon_ghost_club" :
				kills_counter_club += 1
			
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
					image_number_sword = 0
					kills_counter_hp_sword = 0
					update_ghost_sword()
				
				if effect.custom_key == "ghost_club_random_stat":
					image_number_club = 0
					kills_counter_club = 0
					update_ghost_club()
				
				if effect.custom_key == "ghost_club_random_stat":
					var random_stat = get_random_stat()
					if random_stat == "ghost_club_blank":
						RunData.add_stat(random_stat, 0)
					else:
						RunData.add_stat(random_stat, effect.stat_nb + ghost_cape_effect)
				else:
					RunData.add_stat(effect.stat, effect.stat_nb + ghost_cape_effect)
					
				emit_signal("tracked_value_updated")
			else :
				if effect.custom_key == "ghost_sword_blood":
					var new_image_number = get_image_number_from_kills_sword(kills_counter_hp_sword, effect_value)
					if new_image_number != image_number_sword:
						image_number_sword = new_image_number
						update_ghost_sword()
				
				if effect.custom_key == "ghost_club_random_stat":
					var new_image_number = get_image_number_from_kills_club(kills_counter_club, effect_value)
					if new_image_number != image_number_club:
						image_number_club = new_image_number
						update_ghost_club()
						
						
	RunData.emit_stats_updated()
