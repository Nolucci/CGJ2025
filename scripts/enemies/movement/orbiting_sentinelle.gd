class_name OrbitingSentinelle
extends Enemie_movement

## Le rayon du cercle change aléatoirement ?
@export var random_change = true
## Temps minimum avant de changer de direction (en secondes). Ne fait rien si random_change = false
@export var random_switch_start: float = 4.0
## Temps maximum avant de changer de direction (en secondes). Ne fait rien si random_change = false
@export var random_switch_end: float = 7.0
## Centre du cercle
@export var center: Vector2 = Vector2.ZERO
## Angle de départ (en radians)
@export var angle: float = 0.0
## Rayon initial du cercle
@export var radius: float = 100.0
## Vitesse de changement du rayon (la vitesse à laquelle l'enemis se raproche ou s'éloigne du centre selon is_increasing)
@export var radius_change_speed: float = 20.0
## Indique si le rayon augmente ou diminue au début (change aléatoirement si random_change = true)
@export var is_increasing: bool = true

# Temps écoulé depuis le dernier changement
var time_since_change: float = 0.0
# Temps aléatoire avant la prochaine décision
var change_interval: float = randf_range(random_switch_start, random_switch_end)

func process_movement(enemis: Enemie, delta, screen_size: Vector2):
	if not random_change:
		radius_change_speed = 0.0

	# Si le centre n'est pas encore défini, on prend la position actuelle de l'ennemi
	if center == Vector2.ZERO:
		center = enemis.position

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
	print("Je change de direction pour ", is_increasing)
	print("Prochain interval : ", change_interval)
