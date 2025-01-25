extends Node


func toggle_fullscreen(value: bool):
	if value:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	Save.game_data.fullscreen_on = value
	Save.save_data()
	
	
func set_max_fps(value:int):
	Engine.max_fps = value if value<500 else 0
	Save.game_data.max_fps = Engine.max_fps
	Save.save_data()
	
func update_master_volume(value:int):
	AudioServer.set_bus_volume_db(0,value)
	Save.game_data.master_vol = value
	Save.save_data()
	
