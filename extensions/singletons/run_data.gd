extends "res://singletons/run_data.gd"

func _ready()->void :
	change_item_weird_ghost()

func change_item_weird_ghost():
	for item in ItemService.items:
		if item.my_id == "item_weird_ghost":
			item.tags.push_back("tag_ghostking")

func init_effects()->Dictionary:
	var mod_effects = {
		"ghost_crown_effect":0,
		"ghost_cape_effect":0,
		"descendant_weird_ghost_effect":0,
		"ghost_club_blank":0,
		"ghost_descendant_get_weird_ghost":0,
		"golden_ghost_effect":0,
		"rainbow_ghost_effect":0
	}
	var effects = .init_effects()
	effects.merge(mod_effects)
	
	
	return effects

func add_wanted_tag_to_character(tag:String) -> void :
	if tag == null or tag == "" :
		return
	
	if current_character != null :
		if not current_character.wanted_tags.has(tag):
			current_character.wanted_tags.push_back(tag)
