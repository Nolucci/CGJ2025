extends Node2D

@onready var spawn_point = $spawnPoints  # Le nœud contenant les spawn points
@onready var go_points = $goPoints  # Le nœud contenant les points cibles
@onready var baby_scene = preload("res://scenes/enemie/baby.tscn")  # Précharger la scène des babies

@export var waves: Array[Wave] = []
var currentWave: int = 1
var currentLevel: int = 1

var enemies: Array[Enemie] = []

func _ready():
	spawn_enemies(false)

func _process(delta):
	if enemies.size() == 0:
		if waves[currentWave - 1].nbLevelBefortBoss == currentLevel:
			spawn_enemies(true)
			currentLevel = 1
			currentWave += 1
		else :
			spawn_enemies(false)
			currentLevel += 1
			

func spawn_enemies(boss: bool):
	for marker in spawn_point.get_children():
		var enemy_instance = waves[currentWave - 1].typeEnemy.instantiate()
		enemies.append(enemy_instance)
		add_child(enemy_instance)
		enemy_instance.position = marker.global_position

	var free_point = go_points.get_children()
	
	for enemy: Enemie in enemies:
		var marker = free_point.pick_random()
		free_point.erase(marker)
		enemy.goTo(marker.global_position)
