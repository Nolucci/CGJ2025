extends Node

class_name _EventManager

# TODO ajouter l'entité concerné dans chaque fonction

signal player_get_hit(damage: int)
signal enemy_get_hit(damage: int)
signal enemy_get_killed()

func register_enemy(enemy: Enemie):
	pass

func register_player(player: Player):
	pass

func register_fart(fart: Fart):
	pass

func _on_fart():
	pass
