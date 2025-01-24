extends CharacterBody2D

class_name Player

@export var maxSpeed = 450
@export var accel = 2000
@export var friction = 600
@export var data: PlayerData
@export var sprite: AnimatedSprite2D

var input = Vector2.ZERO
var screen_size

func _physics_process(delta):
	screen_size = get_viewport_rect().size
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_bot")) - int(Input.is_action_pressed("move_top"))
	return input.normalized()

func player_movement(delta):
	input = get_input()
	adapat_sprite(input)
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
	
func adapat_sprite(input: Vector2):
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
	
	
