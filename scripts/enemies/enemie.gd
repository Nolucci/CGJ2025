class_name Enemie
extends CharacterBody2D

@export var movement: Enemie_movement
@export var start_movement: bool = false
var screen_size: Vector2


func set_start_movement(start_movement: bool):
	self.start_movement = start_movement

func _process(delta):
	screen_size = get_viewport_rect().size
	if start_movement:
		if movement != null:
			movement.process_movement(self, delta, screen_size)
		else:
			push_error("Movement script is not assigned!")
