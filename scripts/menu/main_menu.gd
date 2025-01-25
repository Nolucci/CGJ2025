extends CanvasLayer

@onready var first_level = preload("res://scenes/principale.tscn")
@onready var credit_scene = preload("res://scenes/menu/credit.tscn")

func _ready() -> void:
	$CatPanneau.hide()
	$BackgroundPatoune.hide()

func _on_start_button_button_down() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_packed(first_level)


func _on_quit_button_button_down() -> void:
	await get_tree().create_timer(0.1).timeout
	$Background.hide()
	$Title.hide()
	$VBoxContainer.hide()
	$CatPanneau.show()
	$BackgroundPatoune.show()
	await get_tree().create_timer(3.0).timeout
	get_tree().quit()
	
func _on_credit_button_button_down() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_packed(credit_scene)

	

func _on_message_timer_timeout() -> void:
	$StartMessage.hide()


func _on_option_input_down():
	get_tree().change_scene_to_packed(
		preload("res://addons/maaacks_options_menus/base/scenes/menus/options_menu/master_options_menu_with_tabs.tscn"))
