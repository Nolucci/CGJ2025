extends Resource

class_name PlayerData

@export var name: String = "Alain"
@export var life: int = 1
@export var money: int = 0
@export var upgrades: Array[PlayerUpgrade] = []
@export var isInvinsible: bool = false

# Fonction pour acheter une amélioration
func buy_upgrade(primary_key: int) -> bool:
	var upgrade = find_upgrade_by_key(primary_key)
	if upgrade == null:
		print("Amélioration non trouvée pour la clé primaire:", primary_key)
		return false
	if not can_upgrade(upgrade):
		return false 
	money -= upgrade.price
	upgrade.current_level += 1
	print("Amélioration achetée:", upgrade.name, "Niveau actuel:", upgrade.current_level)
	emit_signal("upgrade_bought", upgrade.name, upgrade.current_level, money)
	return true

# Fonction pour trouver une amélioration par clé primaire
func find_upgrade_by_key(primary_key: int) -> PlayerUpgrade:
	for u in upgrades:
		if u.primary_key == primary_key:
			return u
	return null

func find_upgrade_by_name(upgrade_name: String) -> PlayerUpgrade:
	for u in upgrades:
		if u.name == upgrade_name:
			return u
	return null

# Fonction pour vérifier si une amélioration peut être effectuée
func can_upgrade(upgrade: PlayerUpgrade) -> bool:
	if upgrade.current_level >= upgrade.max_level:
		print("Amélioration déjà au niveau maximum:", upgrade.name)
		return false
	if money < upgrade.price:
		print("Pas assez d'argent pour acheter l'amélioration:", upgrade.name)
		return false
	return true

func eat_ball():
	pass

func can_fart():
	return true

func fart():
	pass
