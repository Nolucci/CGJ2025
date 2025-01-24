extends CharacterBody2D

@export var maxSpeed = 450
@export var accel = 2000
@export var friction = 600
@export var data:PlayerData

var input = Vector2.ZERO
var screen_size

func _ready() -> void:
	PlayerManager.player_data = data
	print(PlayerManager.player_data)

func _physics_process(delta):
	screen_size = get_viewport_rect().size
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_bot")) - int(Input.is_action_pressed("move_top"))
	return input.normalized()
	
func player_movement(delta):
	input = get_input()
	
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
