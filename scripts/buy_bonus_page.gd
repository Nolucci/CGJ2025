extends Control

@onready var button_scene = preload("res://ui/buyMenuButton.tscn")
@onready var scroll_container = $Panel2/ScrollSkillContainer/SkillContainer
@onready var transition = $Transition
@onready var first_level = preload("res://scenes/principale.tscn")

@onready var main_menu = preload("res://scenes/menu/main_menu.tscn")
var play_scene = preload("res://scenes/player/player.tscn")

var animation_finished = false

var player_instantiated = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.visible = false
	#@TODO obliger de faire ça pour le moment car sinon data pas initialisé
	if !player_instantiated:
		$Panel2/NumberOfCoin.text = "Coin: "+str(PlayerManager.player_data.money)
		PlayerManager.player_data.connect("upgrade_bought", Callable(self, "_on_upgrade_bought"))
		load_buttons()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func load_buttons():
	for skill_data in PlayerManager.player_data.upgrades:
		var button_instance = button_scene.instantiate()
		call_deferred("_setup_button", button_instance, skill_data)

func _setup_button(button_instance, skill_data):
	button_instance.setup(skill_data)
	scroll_container.add_child(button_instance)
	
func _on_upgrade_bought(upgrade_name: String, new_level: int, remaining_money: int):
	$Main/RigthPart/Header/NumberOfCoin.text = "Coin: " + str(remaining_money)


func _on_new_game_pressed() -> void:
	$ColorRect.visible = true
	transition.play("to new page")
	
func _input(event: InputEvent) -> void:
	if event.is_pressed() and animation_finished:
		_go_to_next_scene()


func _go_to_next_scene():
	get_tree().change_scene_to_file("res://scenes/principale.tscn")

func _on_transition_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'quit':
		animation_finished = true
		get_tree().change_scene_to_packed(main_menu)
	if anim_name == 'to new page':
		animation_finished = true


func _on_quitter_pressed() -> void:
	$ColorRect.visible = true
	transition.play("quit")
