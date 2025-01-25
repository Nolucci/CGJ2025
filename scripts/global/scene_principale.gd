extends Node2D

@onready var spawn_point = $spawnPoints
@onready var go_points = $goPoints
@onready var player: Player = $Player
@onready var ui_nbgriffure = $Control/VBoxContainer/nbgriffure
@onready var ui_life = $Control/Control/HBoxContainer/vie
@onready var ui_coeur = $Control/Control/HBoxContainer/coeur
@onready var ui_fart = $"Control/VBoxContainer/Onde de choc"
@onready var ui_vague = $"Control/VBoxContainer/Vague"
@onready var ui_level = $"Control/VBoxContainer/Niveau"
@onready var camera = $Camera

@export var waves: Array[Wave] = []
var currentWave: int = 1
var currentLevel: int = 1

@export var enemies: int = 0

func _ready():
	EventManager.player_dead.connect(_on_player_dead)
	EventManager.enemy_get_killed.connect(_on_enemy_death)
	MusicScene.launchAleatoire()

func _physics_process(_delta):
	if enemies == 0:
		if(currentWave - 1) == waves.size():
			currentWave = 1
			PatternManager.updateDifficulty()
			print("difficulté augmentée")
		if waves[currentWave - 1].tabLevel.size() == currentLevel - 1:
			spawn_enemies(true)
			print("currentLevel : ", currentLevel)
			print("currentWave : ", currentWave)
			currentLevel = 1
			currentWave += 1
		else :
			spawn_enemies(false)
			print("currentLevel : ", currentLevel)
			print("currentWave : ", currentWave)
			currentLevel += 1


	if player != null:
		ui_nbgriffure.text = "Griffures : " + str(player.nbGriffure) + "/" + str(player.nbGriffureMax)
		ui_life.text = str(PlayerManager.player_data.life)
		ui_vague.text = "Niveau : " + str(currentLevel-1) + "/" + str(waves.size())
		ui_level.text = "Vague : " + str(currentWave) + "/" + str(waves[currentWave - 1].tabLevel.size())
		if PlayerManager.player_data.can_fart():
			if player.canFart:
				ui_fart.text = "Onde de choc : 1/1"
			else:
				ui_fart.text = "Onde de choc : 0/1"
		else:
			ui_fart.text = ""

			
	if PlayerManager.player_data.isInvinsible:
		ui_coeur.texture = load("res://assets/player/iron_coeur.png")
	else:
		ui_coeur.texture = load("res://assets/player/coeur.png")

func spawn_enemies(boss: bool):

	var tabEnemies: Array[PackedScene]
	if boss:
		tabEnemies = waves[currentWave - 1].tabBoss
	else:
		tabEnemies = waves[currentWave - 1].tabLevel[currentLevel - 1].tabEnemies

	var free_point = go_points.get_children()
	
	var i = 0
	for enemy in tabEnemies:
		var markers = spawn_point.get_children()
		var enemy_instance = enemy.instantiate()
		enemies += 1
		add_child(enemy_instance)
		enemy_instance.position = markers[i % markers.size() - 1].global_position

		var marker = free_point.pick_random()
		free_point.erase(marker)
		enemy_instance.goTo(marker.global_position)
		i += 1

func _on_enemy_death(_enemy: Enemie):
	enemies -= 1
	if enemies < 0:
		enemies = 0

func _on_player_dead():
	Spawning.reset()
	get_tree().change_scene_to_file("res://scenes/buyBonusPage.tscn")


func _cleanup_resources():
	for child in get_children():
		child.queue_free()
