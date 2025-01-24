class_name Enemie
extends CharacterBody2D

@export var life = 5
@export var movement: Enemie_movement
@export var start_movement: bool = false
var area: Area2D
var screen_size: Vector2
var target_position: Vector2 = Vector2.ZERO

func goTo(position: Vector2):
	target_position = position
	set_start_movement(false)

func _ready() -> void:
	area = $Area2D
	EventManager.register_enemy(self)
	area.area_entered.connect(on_area_entered)
	
func set_start_movement(start_movement: bool):
	self.start_movement = start_movement

func _process(delta):
	screen_size = get_viewport_rect().size
	if start_movement:
		if movement != null:
			movement.process_movement(self, delta, screen_size)
		else:
			push_error("Movement script is not assigned!")
	else:
		if target_position != Vector2.ZERO:
			goToTargetPosition()

func goToTargetPosition():
	var direction = (target_position - position).normalized()
	velocity = direction * 100.0
	move_and_slide()
	
	# Vérification si la position cible est atteinte
	if position.distance_to(target_position) < 5.0:  # Tolérance de 5 unités
		velocity = Vector2.ZERO  # Arrêter le mouvement
		target_position = Vector2.ZERO
		set_start_movement(true)

func on_area_entered(area_entered: Area2D):
	if area_entered is Fart:
		var upgrade = PlayerManager.player_data.find_upgrade_by_name("puissance")
		if upgrade != null:
			life -= upgrade.current_level
		else:
			life -= 1
		if life <= 0:
			queue_free()
