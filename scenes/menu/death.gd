extends CanvasLayer

@onready var buy = preload("res://scenes/buyBonusPage.tscn")
@onready var menu = preload("res://scenes/menu/main_menu.tscn")

func _on_start_button_button_down() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_packed(buy)
