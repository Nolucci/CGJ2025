extends Node2D

@export var patterns : Array[AbstractPattern]
@export var speed : float
@export var shoot_interval : float
@export var nb_patterns_shoot : int

var timer: float = 0.0
var bullet_increase_base : float
var shoot_interval_base : int
var patterns_name:Dictionary
var nb_patterns : int

func _ready():
	nb_patterns = 0
	shoot_interval_base = shoot_interval
	createPattern()

func _process(delta):
	timer += delta
	if timer >= shoot_interval:
		timer = 0.0
		shoot_patterns(nb_patterns_shoot)
	if timer >= 1:
		updateDifficulty()
	for pattern in patterns:
		if shoot_interval < 0.50:
			shoot_interval = shoot_interval_base * pattern.pattern_difficulty.bullet_increase

func createPattern():
	for pattern in patterns:
		for bullet_prop in pattern.bullet_props:
			var directions = [
				Vector2(0, -1),  # Vers le haut
				Vector2(0, 1),   # Vers le bas
				Vector2(-1, 0),  # Vers la gauche
				Vector2(1, 0)    # Vers la droite
			]

			for dir in directions:
				nb_patterns += 1
				var bullet_pattern = BulletPattern.new()
				bullet_pattern.id = pattern.pattern_type.resource_name + str(nb_patterns)
				bullet_pattern.props = bullet_prop
				add_child(bullet_pattern)
				var new_pattern = generatePattern(pattern.pattern_type)
				new_pattern.bullet = bullet_pattern.id
				new_pattern.nbr = pattern.pattern_difficulty.nbr
				bullet_increase_base = pattern.pattern_difficulty.bullet_increase

				if pattern.pattern_type.resource_name == "PatternLine":
					new_pattern.offset = dir * 40

				if pattern.pattern_difficulty.targeting:
					new_pattern.Target = Player

				# Correction de l'angle pour des directions spécifiques
				var angle_in_radians = 0.0
				if dir == Vector2(0, -1):  # Vers le haut
					angle_in_radians = PI
				elif dir == Vector2(0, 1):  # Vers le bas
					angle_in_radians = 0.0
				elif dir == Vector2(-1, 0):  # Vers la gauche
					angle_in_radians = -PI / 2
				elif dir == Vector2(1, 0):  # Vers la droite
					angle_in_radians = PI / 2

				# Enregistrement du pattern avec son angle
				var name = pattern.pattern_type.resource_name + str(nb_patterns)
				patterns_name[name] = angle_in_radians  # Stocke l'angle correct en radians
				Spawning.new_pattern(name, new_pattern)


func updateDifficulty():
	self.queue_free()
	nb_patterns = 0
	Spawning.reset()
	for pattern in patterns:
		pattern.pattern_difficulty.nbr = int(pattern.pattern_difficulty.bullet_increase_rate * pattern.pattern_difficulty.bullet_increase)
	createPattern()

func shoot_pattern_with_rotation(name: String, rotation_angle: float):
	if patterns_name.has(name):
		Spawning.spawn({"position": global_position, "rotation": rotation_angle}, name, "0")
	else:

func shoot_patterns(nb: int):
	if patterns_name.size() > 0:
		# Calculez l'angle entre chaque pattern (espace uniforme)
		var angle_step = TAU / float(nb)  # TAU = 2 * PI, donc un cercle complet
		
		for i in range(nb):
			# Sélectionnez un pattern aléatoire
			var pattern_number = randi_range(0, patterns_name.size() - 1)
			var pattern_name = patterns_name.keys()[pattern_number]
			
			# Récupérez l'angle de base stocké dans patterns_name pour ce pattern
			var base_angle = patterns_name.get(pattern_name)  # En radians (stocké initialement dans createPattern)
			# Ajoutez l'angle de rotation supplémentaire
			var rotation_angle = i * angle_step
			
			var final_rotation = base_angle + rotation_angle  # Angle final combiné
			# Tirez avec la rotation calculée
			shoot_pattern_with_rotation(pattern_name, final_rotation)

func generatePattern(pt: Pattern):
	if pt.resource_name == "PatternCircle":
		return PatternCircle.new()
	if pt.resource_name == "PatternLine":
		return PatternLine.new()
	if pt.resource_name == "PatternOne":
		return PatternOne.new()
	if pt.resource_name == "PatternCustomShape":
		return PatternCustomShape.new()
	if pt.resource_name == "PatternCustomArea":
		return PatternCustomArea.new()
	if pt.resource_name == "PatternCustomPoints":
		return PatternCustomPoints.new()
	return null
