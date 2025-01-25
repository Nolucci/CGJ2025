extends Node

class_name _EventManager

signal player_get_hit(damage: int)
signal enemy_get_hit(damage: int)
signal enemy_get_killed()
signal player_dead()

func register_enemy(enemy: Enemie):
	enemy.enemy_death.connect(_on_enemy_death)

func register_player(player: Player):
	player.player_is_dead.connect(_on_player_dead)
	pass

func register_fart(fart: Fart):
	pass

func _on_fart():
	pass

func _on_enemy_death(enemy: Enemie):
	enemy_get_killed.emit(enemy)

func _on_player_dead():
	player_dead.emit()
