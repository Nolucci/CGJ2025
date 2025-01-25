extends Control

@onready var main = $"../../"

@onready var option_scene = preload("res://scenes/menu/option.tscn")

func _on_quit_pressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")


func _on_resume_pressed() -> void:
	main.pauseMenu()
