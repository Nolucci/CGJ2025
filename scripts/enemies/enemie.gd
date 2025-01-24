class_name Enemie
extends Area2D
@export var movement: Enemie_movement

var screen_size: Vector2

func _ready():
	pass
		

func _process(delta):
	screen_size = get_viewport_rect().size
	if movement != null:
		movement.process_movement(self, delta, screen_size)
	else:
		push_error("Movement script is not assigned!")
