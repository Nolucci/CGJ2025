extends Resource

class_name AbstractPattern

@export var pattern_difficulty : Difficulty
@export var pattern_type : Pattern
@export var bullet_props : Array[BulletProps]

func changeDifficulty(new_dif : Resource) : 
	pattern_difficulty = new_dif
