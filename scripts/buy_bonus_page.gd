extends Control

@export var button_scene: PackedScene
@onready var scroll_container = $Main/RigthPart/ScrollSkillContainer/SkillContainer

var player_instantiated = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#@TODO obliger de faire ça pour le moment car sinon data pas initialisé
	if !player_instantiated:
		var player_scene = preload("res://scenes/player/player.tscn")
		var player = player_scene.instantiate()
		add_child(player)
		player.hide()
		player_instantiated = true
		$Main/RigthPart/Header/NumberOfCoin.text = "Coin: "+str(PlayerManager.player_data.money)
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
