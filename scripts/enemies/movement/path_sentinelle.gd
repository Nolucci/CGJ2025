class_name PathMovement
extends Enemie_movement

@export var path_points: Array[Vector2] = []  ## Liste des points de passage (l'enemie partira de la ou il spawn)
@export var loop_path: bool = true  ## Indique si le chemin doit boucler (true) ou s'arrêter à la fin (false)
@export var reverse_path: bool = false  ## Indique si le chemin doit être inversé à la fin (fonctionne uniquement si loop_path = false)

var current_index: int = 0  # Point actuel de la trajectoire
var direction: int = 1  # 1 pour avancer, -1 pour reculer (utile pour reverse_path)

func process_movement(enemis: Enemie, delta, screen_size: Vector2):
	if path_points.size() == 0:
		return  # Si aucun point n'est défini, ne rien faire

	# Position actuelle de l'ennemi
	var current_position = enemis.position
	# Position cible (point suivant)
	var target_position = path_points[current_index]

	# Déplacer l'ennemi vers la cible
	var movement_vector = (target_position - current_position).normalized()
	enemis.position += movement_vector * speed * delta

	# Vérifier si l'ennemi a atteint la cible (ou est très proche)
	if current_position.distance_to(target_position) < 5.0:  # Tolérance de 5 unités
		advance_to_next_point()

func advance_to_next_point():
	# Passer au point suivant dans la liste
	current_index += direction

	# Gérer les limites du chemin
	if current_index >= path_points.size():
		if loop_path:
			current_index = 0  # Recommencer depuis le début
		elif reverse_path:
			direction = -1  # Inverser le chemin
			current_index = path_points.size() - 2  # Revenir au point avant le dernier
		else:
			current_index = path_points.size() - 1  # Stopper au dernier point

	elif current_index < 0:
		if loop_path:
			current_index = path_points.size() - 1  # Recommencer depuis la fin
		elif reverse_path:
			direction = 1  # Revenir à l'avant
			current_index = 1  # Aller au deuxième point
		else:
			current_index = 0  # Stopper au premier point
