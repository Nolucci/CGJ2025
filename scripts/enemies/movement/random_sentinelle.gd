class_name RandomSentinelle
extends Enemie_movement

var time_since_change: float = 0.0  
var change_direction_time: float = 0.0
var direction: Vector2 = Vector2(1, 0)  # Direction initiale

func process_movement(enemis: Enemie, delta, screen_size: Vector2):
	print("Direction: ", direction)
	print("Position: ", enemis.position)

	# Déplacer le nœud dans la direction actuelle
	enemis.position += direction * speed * delta

	# Vérifier si on atteint les bords de l'écran
	if enemis.position.x < 0 or enemis.position.x > screen_size.x or enemis.position.y < 0 or enemis.position.y > screen_size.y:
		change_direction(enemis, true, screen_size)

	# Changer la direction après un certain temps
	time_since_change += delta
	if time_since_change >= change_direction_time:
		change_direction(enemis, false, screen_size)

func change_direction(enemis: Enemie, screen_touch: bool, screen_size: Vector2):
	if !screen_touch:
		var angle = direction.angle()  # Angle actuel de la direction
		var random_angle = randf_range(-PI / 2, PI / 2)  # Génère un angle entre -90° et 90° (en radians)
		direction = Vector2(cos(angle + random_angle), sin(angle + random_angle)).normalized()
	else:
		if direction == Vector2.ZERO:
			direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

		if enemis.position.x <= 0 or enemis.position.x >= screen_size.x:
			direction.x = -direction.x
		if enemis.position.y <= 0 or enemis.position.y >= screen_size.y:
			direction.y = -direction.y

	change_direction_time = randf_range(2.0, 4.0)
	time_since_change = 0.0
