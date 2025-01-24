extends Node

class_name _EventManager

# TODO ajouter l'entité concerné dans chaque fonction

signal player_get_hit(damage: int)
signal enemy_get_hit(damage: int)
signal enemy_get_killed()

func register_enemy():
	#enregistre les listeners
	pass

func register_player():
	#enregistre les listeners
	pass
