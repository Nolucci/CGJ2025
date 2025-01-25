class_name Enemie
extends CharacterBody2D

@export var life = 5
@export var movement: Enemie_movement
@export var start_movement: bool = false
var area: Area2D
var screen_size: Vector2
var target_position: Vector2 = Vector2.ZERO

var sound_damage: AudioStreamPlayer2D

signal enemy_death(enemy: Enemie)

func goTo(pos: Vector2):
	target_position = pos
	set_start_movement(false)

func _ready() -> void:
	area = $Area2D
	EventManager.register_enemy(self)
	area.area_entered.connect(on_area_entered)
	sound_damage = AudioStreamPlayer2D.new()
	sound_damage.stream = load("res://assets/enemies/sound/take_damage.mp3")
	sound_damage.volume_db = 10.0
	add_child(sound_damage)

	
func set_start_movement(new_start_movement: bool):
	self.start_movement = new_start_movement

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
	
	if position.distance_to(target_position) < 5.0:
		velocity = Vector2.ZERO
		target_position = Vector2.ZERO
		set_start_movement(true)

func on_area_entered(area_entered: Area2D):
	if area_entered is Fart:
		var upgrade = PlayerManager.player_data.find_upgrade_by_name("puissance")
		if upgrade != null:
			life -= upgrade.current_level
		else:
			life -= 1
			sound_damage.play()
		if life <= 0:
			sound_damage.play()
			enemy_death.emit(self)
			queue_free()

func _on_area_2d_body_entered(body: PhysicsBody2D) -> void:
	if body is Player and !PlayerManager.player_data.isInvinsible and PlayerManager.player_data.life >= 1:
		body.take_damage()
