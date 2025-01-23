extends Control

@export var button_scene: PackedScene
@onready var scroll_container = $Main/RigthPart/ScrollSkillContainer/SkillContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	load_buttons()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func load_buttons():
	
	var test_skills = [
		{"name": "Compétence 1", "description": "Description 1", "cost": 500, "icon": preload("res://icon.svg")},
		{"name": "Compétence 2", "description": "Description 2", "cost": 800, "icon": preload("res://icon.svg")},
		{"name": "Compétence 3", "description": "Description 3", "cost": 1200, "icon": preload("res://icon.svg")},
	]

	for skill_data in test_skills:
	#@TODO Bon faut mettre le vrai truc pour récup les skills du player
	#for skill in Global.player.skills:
		var button_instance = button_scene.instantiate()
		button_instance.setup(skill_data)
		scroll_container.add_child(button_instance)
