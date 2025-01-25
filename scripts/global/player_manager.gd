extends Node

class_name _PlayerManager

@onready var player_data_initial: PlayerData = preload("res://resources/player_data/player_data.tres")
var player_data: PlayerData

func _ready() -> void:
	player_data = player_data_initial.duplicate(true)
	EventManager.player_spawn.connect(_on_player_spawn)
	EventManager.enemy_get_killed.connect(_on_enemy_kill)

func _on_enemy_kill(enemy):
	player_data.money += 30

func _on_player_spawn(player):
	print("salut")
	player_data.life = player_data_initial.life
	player_data.life += player_data.find_upgrade_by_name('Vie').current_level
	player_data.isInvinsible = false
