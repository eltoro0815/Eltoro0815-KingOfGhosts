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
		"ghost_cape_effect":0
	}
	var effects = .init_effects()
	effects.merge(mod_effects)
	
	return effects

	
