extends CharacterBody2D

class_name Player

@export var maxSpeed = 450
@export var accel = 2000
@export var friction = 600
@export var sprite: AnimatedSprite2D

@export var nbGriffureMax: int = 3
@export var nbGriffure: int = 0

var fart_scene: PackedScene = preload("res://scenes/player/fart.tscn")
var griffe_scene: PackedScene = preload("res://scenes/player/griffe.tscn")
var input = Vector2.ZERO
var screen_size
var area: Area2D
var canGriffe: bool = true;
var canFart: bool = true
var cant_moove: bool = false

signal player_is_dead()
signal player_spawn(player: Player)

@onready var sound_cut: AudioStreamPlayer2D = $cut
@onready var cam: Camera2D = $Camera

func _ready() -> void:
	area = $Area2D

	Spawning.bullet_collided_body.connect(on_ball_entered)
	EventManager.register_player(self)
	EventManager.player_get_hit.connect(take_damage)
	player_spawn.emit(self)

func _physics_process(delta):
	if not(cant_moove):
		screen_size = get_viewport_rect().size
		player_movement(delta)
		
		if Input.is_action_just_pressed("griffe"):
			if nbGriffure > 0 and canGriffe:
				nbGriffure -= 1
				griffer()
				
		if Input.is_action_just_pressed("fart"):
			fart()		
			
		

func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_bot")) - int(Input.is_action_pressed("move_top"))
	return input.normalized()

func griffer():
	canGriffe = false
	if griffe_scene:
		var griffe_instance = griffe_scene.instantiate()
		griffe_instance.position = get_global_mouse_position()
		get_parent().add_child(griffe_instance)
	else:
		print("Aucune scène de griffe assignée !")
	canGriffe = true

func fart():
	if !canFart || !PlayerManager.player_data.can_fart():
		return
	canGriffe = false
	canFart = false
	if fart_scene:
		sound_cut.play()
		var fart_instance = fart_scene.instantiate()
		fart_instance.position = get_global_mouse_position()
		get_parent().add_child(fart_instance)
		
	else:
		print("Aucune scène de fart assignée !")
	canGriffe = true

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
	if PlayerManager.player_data.isInvinsible:
		return
	PlayerManager.player_data.isInvinsible = true
	PlayerManager.player_data.life = PlayerManager.player_data.life - 1
	print("Player take tamage, new life :", PlayerManager.player_data.life)
	if PlayerManager.player_data.life <= 0:
		cant_moove = true
		cam.enabled = true
		Spawning.clear_all_bullets()
		var tween = get_tree().create_tween()
		tween.tween_property(cam,"zoom", Vector2(5, 5), 1.5)
		sprite.play("death")
		PlayerManager.player_data.isInvinsible = false
		PlayerManager.player_data.life = 2
		await get_tree().create_timer(2).timeout
		player_is_dead.emit()
		MusicScene.launchMusicGrotte()
		await queue_free()
		return
	
	for i in range(1, 10):
		sprite.set_modulate('ff8e7e');
		await get_tree().create_timer(0.1).timeout
		sprite.set_modulate('ffffff');
		await get_tree().create_timer(0.1).timeout
	
	PlayerManager.player_data.isInvinsible = false

func on_ball_entered(body, body_shape_index, B, local_shape_index, shared_area):
	if body is not Player:
		return
	var groups = get_props_groups(B)
	if groups == null || groups[0] != "black_group":
		take_damage()
	else:
		PlayerManager.player_data.eat_ball()
		if nbGriffure < nbGriffureMax:
			nbGriffure += 1
		

func get_props_groups(B: Dictionary) -> Variant:
	if B.has("props"):
		var props = B["props"]
		if typeof(props) == TYPE_DICTIONARY and props.has("groups"):
			return props["groups"]
	return null
