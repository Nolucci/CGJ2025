extends Node2D

@onready var spawn_point = $spawnPoints  # Le nœud contenant les spawn points
@onready var go_points = $goPoints  # Le nœud contenant les points cibles

@export var waves: Array[Wave] = []
var currentWave: int = 1
var currentLevel: int = 1

@export var enemies: Array[Enemie] = []

func _ready():
	pass

func _process(_delta):
	if enemies.size() == 0:
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
		
	if Input.is_action_just_released("fart"):
		if enemies.size() > 0:
			for enemy in enemies:
				remove_child(enemy)
		enemies.clear()

func spawn_enemies(boss: bool):
	var enemy_scene: PackedScene
	var nb: int
	if boss:
		nb = waves[currentWave - 1].nbBoss
		enemy_scene = waves[currentWave - 1].typeBoss
	else:
		enemy_scene = waves[currentWave - 1].typeEnemy
		nb = waves[currentWave - 1].nbEnemies

	for i in range(nb):
		var markers = spawn_point.get_children()
		var enemy_instance = enemy_scene.instantiate()
		enemies.append(enemy_instance)
		add_child(enemy_instance)
		enemy_instance.position = markers[i % markers.size() - 1].global_position

	var free_point = go_points.get_children()
	
	for enemy: Enemie in enemies:
		var marker = free_point.pick_random()
		free_point.erase(marker)
		enemy.goTo(marker.global_position)
