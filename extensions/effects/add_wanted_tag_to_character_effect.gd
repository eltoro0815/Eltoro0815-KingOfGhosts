extends Effect


func apply()->void :
	RunData.add_wanted_tag_to_character(key)
	
	
func get_args()->Array:	
	return [tr(key.to_upper())]
	
