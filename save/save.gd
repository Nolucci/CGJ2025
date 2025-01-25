extends Node

const SAVEFILE = "res:://SAVEFILE.save"

var game_data = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data()


func load_data():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if not file:
		game_data = {
			"fullscreen_on": false,
			"display_fps": false,
			"max_fps": 0,
			"master_vol": -10,
			"music_vol": -10,
			"sfx_vol": -10,
			}
		save_data()
		return
		
	game_data = file.get_var()
	file.close()
	
func save_data():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	if file:
		file.store_var(game_data)
		file.close()
