extends "res://ui/menus/shop/item_description.gd"

var self_custom_icon_tags = null

func _ready():
	
	if ("_custom_icon_tags" in self):	# check if ShowTags from LexLooter is loaded
		self_custom_icon_tags = self._custom_icon_tags
		merge_ghost_king_tags()
	
	



func merge_ghost_king_tags()->void:
	var tmp_tags = self_custom_icon_tags
	var new_tags = {
		"tag_ghostking": "res://mods-unpacked/Eltoro0815-KingOfGhosts/extensions/ui/icons/" + "eltoro0815_ghost_icon.png"
	}
	tmp_tags.merge(new_tags)
	self._custom_icon_tags = tmp_tags




	
