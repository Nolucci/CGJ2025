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
			print("c'est repartis");
		if waves[currentWave - 1].nbLevelBeforeBoss == currentLevel:
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
	var enemy_scene: PackedScene
	var nb: int
	if boss:
		nb = waves[currentWave - 1].nbBoss
		enemy_scene = waves[currentWave - 1].typeBoss
	else:
		enemy_scene = waves[currentWave - 1].typeEnemy
		nb = waves[currentWave - 1].nbEnemies
	var free_point = go_points.get_children()

	for i in range(nb):
		
		var markers = spawn_point.get_children()
		var enemy_instance = enemy_scene.instantiate()
		enemies += 1
		add_child(enemy_instance)
		enemy_instance.position = markers[i % markers.size() - 1].global_position

		var marker = free_point.pick_random()
		free_point.erase(marker)
		enemy_instance.goTo(marker.global_position)

func _on_enemy_death(_enemy: Enemie):
	enemies -= 1
