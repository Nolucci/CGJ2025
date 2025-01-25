extends Node


func toggle_fullscreen(value: bool):
	if value:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func set_max_fps(value:int):
	Engine.max_fps = value if value<500 else 0
	
func update_master_volume(value:int):
	AudioServer.set_bus_volume_db(0,value)
	
func update_music_volume(value: float):
	AudioServer.set_bus_volume_db(1, value)
	
func update_sfx_volume(value: float):
	AudioServer.set_bus_volume_db(2, value)
