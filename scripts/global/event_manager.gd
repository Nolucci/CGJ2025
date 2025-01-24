extends Node

class_name _EventManager

# TODO ajouter l'entité concerné dans chaque fonction

signal player_get_hit(damage: int)
signal enemy_get_hit(damage: int)
signal enemy_get_killed()

func register_enemy():
	#enregistre les listeners
	pass

func register_player(player: Player):
	pass

func register_fart(fart: Fart):
	fart.body_entered.connect(_on_fart)
	pass

func _on_fart():
	pass
