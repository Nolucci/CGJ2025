extends Node

class_name _EventManager

signal enemy_get_killed()

func register_enemy(enemy: Enemie):
	enemy.enemy_death.connect(_on_enemy_death)

func register_player(_player: Player):
	pass

func register_fart(_fart: Fart):
	pass

func _on_enemy_death(enemy: Enemie):
	enemy_get_killed.emit(enemy)
