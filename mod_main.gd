extends Node



const MOD_DIR = "Eltoro0815-KingOfGhosts/"
const LOG_NAME = "Eltoro0815-KingOfGhosts"

var dir = ""
var content_dir = ""
var content_data_dir = ""
var weapons_dir = ""
var ext_dir = ""
var trans_dir = ""

func _init(_modLoader = ModLoader):
	ModLoaderLog.info("Init", LOG_NAME)
	dir = ModLoaderMod.get_unpacked_dir() + MOD_DIR
	trans_dir = dir + "translations/"
	content_dir = dir + "content/"
	content_data_dir = dir + "content_data/"
	ext_dir = dir + "extensions/"

	ModLoaderMod.add_translation(trans_dir + "eltoro0815_ghost_crown.en.translation")
	ModLoaderMod.add_translation(trans_dir + "eltoro0815_ghost_crown.de.translation")
	#ModLoaderMod.add_translation(trans_dir + "beelze_stuff.uk.translation")
	#ModLoaderMod.install_script_extension(ext_dir + "singletons/progress_data.gd")
	ModLoaderMod.install_script_extension(ext_dir + "singletons/run_data.gd")
	ModLoaderMod.install_script_extension(ext_dir + "singletons/weapon_service.gd")
	#ModLoaderMod.install_script_extension(ext_dir + "singletons/utils.gd")
	ModLoaderMod.install_script_extension(ext_dir + "main.gd")
	ModLoaderMod.install_script_extension(ext_dir + "weapons/weapon.gd")

	ModLoaderMod.install_script_extension(ext_dir + "effects/gain_stat_every_killed_enemies_effect.gd")
	ModLoaderMod.install_script_extension(ext_dir + "effects/healing_effect.gd")

	#ModLoaderMod.install_script_extension(ext_dir + "effects/weapon_item_stack_effect.gd")

	ModLoaderMod.install_script_extension(ext_dir + "ui/menus/shop/item_description.gd")


func _ready(_modLoader = ModLoader):
	ModLoaderLog.info("Done", LOG_NAME)

	var ContentLoader = get_node("/root/ModLoader/Darkly77-ContentLoader/ContentLoader")

	ContentLoader.load_data(dir + "content_data/king_of_ghosts_content_data.tres", LOG_NAME)

	#var mod_loader_mod = ModLoaderMod.new()
	#mod_loader_mod.call_deferred("install_script_extension", ext_dir + "global/entity_spawner.gd")


