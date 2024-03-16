extends "res://effects/items/healing_effect.gd"


static func get_id() -> String:
	return "healing"


func apply() -> void:
	var effect_consumable_heal = RunData.effects["consumable_heal"]
	var linked_stats_consumable_heal = LinkedStats.stats["consumable_heal"]
	RunData.emit_signal("healing_effect", max(1, value + effect_consumable_heal + linked_stats_consumable_heal), "")


func unapply() -> void:
	pass
