extends Area2D

class_name Fart

@export var max_size: float = 30.0
@export var growth_speed: float = 10.0
@export var duration: float = 2.0

var current_scale: float = 1.0
var timer: float = 0.0

func _ready() -> void:
	EventManager.register_fart(self)

func _process(delta: float) -> void:
	if current_scale < max_size:
		current_scale += growth_speed * delta
		if current_scale > max_size:
			current_scale = max_size
		set_scale(Vector2(current_scale, current_scale))
		timer += delta
	if timer >= duration:
		queue_free()
