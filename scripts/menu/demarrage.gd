extends Control

@onready var first_level = preload("res://scenes/menu/main_menu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("main")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_packed(first_level)
