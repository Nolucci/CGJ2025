class_name OrbitingSentinelle
extends Enemie_movement

## Le rayon du cercle change aléatoirement ?
@export var random_change = true
## Temps minimum avant de changer de direction (en secondes). Ne fait rien si random_change = false
@export var random_switch_start: float = 4.0
## Temps maximum avant de changer de direction (en secondes). Ne fait rien si random_change = false
@export var random_switch_end: float = 7.0
## Centre du cercle (par défaut : sa position initiale)
@export var center: Vector2 = Vector2.ZERO
## Rayon initial du cercle
@export var radius: float = 100.0
## Vitesse de changement du rayon
@export var radius_change_speed: float = 20.0
## Vitesse de déplacement linéaire
@export var approach_speed: float = 100.0  # Vitesse pour aller du centre au rayon
## Angle de départ (en radians)
@export var angle: float = 0.0
## Indique si le rayon augmente ou diminue au début (change aléatoirement si random_change = true)
@export var is_increasing: bool = true

# Indique si l'ennemi est encore en train de s'approcher de sa position initiale sur le cercle
var moving_to_orbit: bool = true
var time_since_change: float = 0.0
var change_interval: float = 0.0

func process_movement(enemis: Enemie, delta, screen_size: Vector2):
	# Si le centre n'est pas défini (Vector2.ZERO), on choisit la position actuelle de l'ennemi
	if center == Vector2.ZERO:
		center = enemis.position

	if moving_to_orbit:
		move_to_orbit(enemis, delta)
	else:
		orbit_center(enemis, delta)

func move_to_orbit(enemis: Enemie, delta):
	# Calculer la position cible sur le cercle (rayon depuis le centre)
	var target_position = center + Vector2(cos(angle), sin(angle)) * radius

	# Calculer la direction vers la position cible
	var direction = (target_position - enemis.position).normalized()
	enemis.velocity = direction * approach_speed

	# Déplacer l'ennemi
	enemis.move_and_slide()

	# Vérifier si l'ennemi a atteint la position cible
	if enemis.position.distance_to(target_position) < 5.0:  # Tolérance de 5 unités
		enemis.velocity = Vector2.ZERO  # Arrêter le mouvement linéaire
		moving_to_orbit = false  # Commencer à tourner autour du centre

func orbit_center(enemis: Enemie, delta):
	if not random_change:
		radius_change_speed = 0.0

	# Calculer la vitesse angulaire en fonction de `speed` et du rayon
	var angular_speed = speed / radius  # La vitesse diminue avec un rayon plus grand

	# Mise à jour du rayon petit à petit
	if is_increasing:
		radius += radius_change_speed * delta
	else:
		radius -= radius_change_speed * delta

	# Limiter le rayon à des valeurs raisonnables
	radius = clamp(radius, 50.0, 200.0)

	# Mettre à jour l'angle et déplacer l'ennemi
	angle += angular_speed * delta
	enemis.position = center + Vector2(cos(angle), sin(angle)) * radius

	# Mise à jour du temps écoulé et décision aléatoire
	if random_change:
		time_since_change += delta
		if time_since_change >= change_interval:
			choose_new_direction()

func choose_new_direction():
	# Décider aléatoirement si on augmente ou diminue le rayon
	is_increasing = randf() > 0.5  # 50 % de chances d'augmenter ou de diminuer
	time_since_change = 0.0  # Réinitialiser le temps écoulé
	change_interval = randf_range(random_switch_start, random_switch_end)  # Nouveau temps aléatoire avant la prochaine décision
