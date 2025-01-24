extends Node2D

@export var shoot_interval: float = 1.0  # Intervalle entre les tirs
var timer: float = 0.0  # Timer pour gérer les tirs

# Fonction pour tirer un pattern unique
func shoot(pattern_name: String, position: Vector2, rotation: float, bullet_type: String, offset: Vector2, nbr: int):
	
	var new_pattern = PatternCircle.new()
	new_pattern.bullet = bullet_type
	new_pattern.nbr = nbr
	Spawning.new_pattern(pattern_name, new_pattern)
	Spawning.spawn({"position": position, "rotation": rotation}, pattern_name, "0")

# Fonction pour tirer plusieurs patterns
func shoot_patterns(pattern_data: Array):
	# pattern_data est une liste de dictionnaires contenant les paramètres des patterns
	for data in pattern_data:
		shoot(
			data.pattern_name,
			data.position,
			data.rotation,
			data.bullet_type,
			data.offset,
			data.nbr
		)

func _process(delta):
	# Gestion du tir en fonction de l'intervalle
	timer += delta
	if timer >= shoot_interval:
		timer = 0.0
		
		# Exemple d'utilisation : Tirer plusieurs patterns en même temps
		shoot_patterns([
			{
				"pattern_name": "one",
				"position": global_position,  # Position de l'ennemi
				"rotation": 0,
				"bullet_type": "bullettest",
				"offset": Vector2(0, 0),
				"nbr": 5
			}
		])
