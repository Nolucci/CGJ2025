extends Area2D

@export var speed: float = 100  # Vitesse de déplacement
var direction: Vector2 = Vector2.ZERO  # Direction du mouvement
var time_since_change: float = 0.0  # Temps écoulé depuis le dernier changement de direction
var change_direction_time: float = 0.0  # Temps avant le prochain changement de direction
var screen_size: Vector2  # Taille de l'écran

func _ready():
	# Obtenir la taille de l'écran
	screen_size = get_viewport_rect().size
	# Générer une direction initiale
	direction.x += 1

func _process(delta):
	# Déplacer le nœud dans la direction actuelle
	position += direction * speed * delta
	
	# Vérifier si on atteint les bords de l'écran
	if position.x < 0 or position.x > screen_size.x or position.y < 0 or position.y > screen_size.y:
		change_direction(true)
	
	# Changer la direction après un certain temps
	time_since_change += delta
	if time_since_change >= change_direction_time:
		change_direction(false)

func change_direction(screen_touch: bool):
	if !screen_touch:
		# Génère une direction aléatoire dans un angle de 180° autour de la direction actuelle
		var angle = direction.angle()  # Angle actuel de la direction
		var random_angle = randf_range(-PI / 2, PI / 2)  # Génère un angle entre -90° et 90° (en radians)
		direction = Vector2(cos(angle + random_angle), sin(angle + random_angle)).normalized()
	else:
		# Si on touche un bord, inverse la direction
		if position.x <= 0 or position.x >= screen_size.x:
			direction.x = -direction.x  # Inverse la direction horizontale
		if position.y <= 0 or position.y >= screen_size.y:
			direction.y = -direction.y  # Inverse la direction verticale
	
	# Génère un temps de changement de direction aléatoire entre 2 et 4 secondes
	change_direction_time = randf_range(2.0, 4.0)
	# Réinitialise le temps écoulé
	time_since_change = 0.0
