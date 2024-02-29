extends "res://items/global/weapon_data.gd"

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


func get_effects_text() -> String:
	var text = .get_effects_text()
	
	
	var i = 0
	text += tr("GHOST_CLUB_GAINED_STATS_TEXT")
	for stat in tracked_stats_gained:
		if stat != "ghost_club_blank":
			text += _vanilla_primary_icon_img(stat)
			if tracked_stats_gained[stat] == 0:
				text += "0"
			else:
				text += "[color=#00ff00]"
				text += String(tracked_stats_gained[stat])
				text += "[/color]"
			text += "   "
			i+=1
			if i%4 == 0:
				text += "\n"
				
	text += tr("GHOST_CLUB_BLANKS_TEXT") + " [color=red]" + String(tracked_stats_gained["ghost_club_blank"]) + "[/color]"
	return text 

func _vanilla_primary_icon_img(_tag_name:String) -> String: # adds the vanilla icon
	_tag_name = _tag_name.replace("stat_", "") # removes the "stat_" to match the icon
	var w = 20 * ProgressData.settings.font_size
	var icon_path = "res://items/stats/" + _tag_name + ".png"
	return "[img=%sx%s]%s[/img]" % [w, w, icon_path]
