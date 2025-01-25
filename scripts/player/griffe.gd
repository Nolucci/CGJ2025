extends Area2D

class_name Griffe

@export var max_size: float = 30.0
@export var growth_speed: float = 10.0
@export var duration: float = 2.0

var current_scale: float = 1.0
var timer: float = 0.0

func _on_area_entered(area):
	print(area)

func _on_animated_sprite_2d_animation_finished():
	queue_free()
