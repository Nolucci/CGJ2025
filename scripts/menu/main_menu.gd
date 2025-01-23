extends CanvasLayer

@onready var first_level = preload("res://addons/BulletUpHell/ExampleScenes/Test.tscn")

func _on_start_button_button_down() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_packed(first_level)
	


func _on_quit_button_button_down() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()

	

func _on_message_timer_timeout() -> void:
	$StartMessage.hide()
