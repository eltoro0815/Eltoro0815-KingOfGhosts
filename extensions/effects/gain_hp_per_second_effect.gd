extends Effect

func get_args()->Array:
	var lose_hp_per_second = RunData.effects["lose_hp_per_second"]
	var not_used = lose_hp_per_second * (-1)
	if not_used < 0:
		not_used = 0
	return [str((-1)*value), tr(key), str(not_used)]

