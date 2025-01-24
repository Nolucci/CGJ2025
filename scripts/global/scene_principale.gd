extends Node2D

@onready var spawn_point = $spawnPoints  # Le nœud contenant les spawn points
@onready var go_points = $goPoints  # Le nœud contenant les points cibles
@onready var baby_scene = preload("res://scenes/enemie/baby.tscn")  # Précharger la scène des babies

func _ready():
	var free_points = go_points.get_children()  # Obtenez une copie des enfants de goPoints
	
	for i in range(4):
		if free_points.size() > 0:
			var point = free_points.pick_random()
			free_points.erase(point)
			
			if point is Marker2D:
				print("Spawning baby at:", point.global_position)
				spawn_baby(point.global_position)

func spawn_baby(position: Vector2):
	if baby_scene:
		var baby_instance = baby_scene.instantiate()
		add_child(baby_instance)
		baby_instance.position = position
		print("Baby instance:", baby_instance, "spawned at:", position)
	else:
		push_error("Baby scene not loaded!")
