extends "res://singletons/progress_data.gd"

func init_settings()->void :
	.init_settings()
	var ContentLoader = get_node("/root/ModLoader/Darkly77-ContentLoader/ContentLoader")
	ContentLoader._install_data()
