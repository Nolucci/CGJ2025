extends Node2D

@onready var spawn_point = $spawnPoints  # Le nœud contenant les spawn points
@onready var go_points = $goPoints  # Le nœud contenant les points cibles

@export var waves: Array[Wave] = []
var currentWave: int = 1
var currentLevel: int = 1

@export var enemies: int = 0

func _ready():
	EventManager.enemy_get_killed.connect(_on_enemy_death)

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
