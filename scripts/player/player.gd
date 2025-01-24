extends CharacterBody2D

class_name Player

@export var maxSpeed = 450
@export var accel = 2000
@export var friction = 600
@export var data: PlayerData
@export var sprite: AnimatedSprite2D
@export var fart_scene: PackedScene

var input = Vector2.ZERO
var screen_size
var area: Area2D

func _ready() -> void:
	area = $Area2D
	Spawning.bullet_collided_body.connect(on_area_entered)
	EventManager.register_player(self)
	PlayerManager.player_data = data
	print(PlayerManager.player_data)
	EventManager.player_get_hit.connect(take_damage)

func _physics_process(delta):
	screen_size = get_viewport_rect().size
	player_movement(delta)
	fart()

func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_bot")) - int(Input.is_action_pressed("move_top"))
	return input.normalized()

func fart():
	if Input.is_action_just_released("fart"):  # Vérifie si la touche "fart" a été pressée
		if fart_scene:
			var fart_instance = fart_scene.instantiate()
			fart_instance.position = position
			get_parent().add_child(fart_instance)
		else:
			print("Aucune scène de fart assignée !")

func player_movement(delta):
	input = get_input()
	adapat_sprite()
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(maxSpeed)
	
	position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()

func adapat_sprite():
	if input.y > 0:
		sprite.speed_scale = 0.7
	elif input.y < 0:
		sprite.speed_scale = 1.8
	else:
		sprite.speed_scale = 1

	if input.x > 0:
		sprite.rotation = 45
	elif input.x < 0:
		sprite.rotation = -45
	else:
		sprite.rotation = 0
	
func take_damage():
	data.isInvinsible = true
	data.life = data.life - 1
	for i in range(1, 15):
		sprite.set_modulate('ff8e7e');
		await get_tree().create_timer(0.1).timeout
		sprite.set_modulate('ffffff');
		await get_tree().create_timer(0.1).timeout
	
	data.isInvinsible = false

func on_area_entered(body, body_shape_index, B, local_shape_index, shared_area):
	print(get_props_groups(B))
		
func get_props_groups(B: Dictionary) -> Variant:
	# Vérifie si B contient la clé "props"
	if B.has("props"):
		var props = B["props"]
		# Vérifie si "props" est un dictionnaire et contient la clé "groups"
		if typeof(props) == TYPE_DICTIONARY and props.has("groups"):
			return props["groups"]
	# Si "props" ou "groups" n'existent pas, retourne null
	return null
