extends Resource
class_name Enemie_movement

@export var speed: float = 100  # Vitesse de déplacement

func process_movement(_enemis: Enemie, _delta, _screen_size: Vector2):
		push_error("The function 'test' must be implemented in child classes.")
