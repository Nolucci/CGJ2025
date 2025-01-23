extends Control
# Compétence associée au bouton
var skill

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Configure le bouton avec les informations de la compétence
func setup(skill_data):
	skill = skill_data
	$Main/Title.text = skill_data.name
	$Main/MainContent/Info/Description.text = skill_data.description
	$Main/MainContent/Info/MarginBuyButton/BuyButton.text = str(skill_data.cost) + " Coin"
	$Main/MainContent/MarginImage/ImageCompetence.texture = skill_data.icon

func _on_buy_button_pressed() -> void:
	print("j'ai tout acheté")
	#if Global.player.can_afford(skill.cost):
		#Global.player.buy_skill(skill)
		#print("Acheté :", skill.name)
	#else:
		#print("Pas assez d'argent pour :", skill.name)
