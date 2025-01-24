extends Control
# Compétence associée au bouton
var skill : PlayerUpgrade
@onready var title = $Main/Title
@onready var description = $Main/MainContent/Info/Info_base/Description
@onready var buy_button = $Main/MainContent/Info/MarginBuyButton/BuyButton
@onready var level = $Main/MainContent/Info/Info_base/Level
@onready var icon = $Main/MainContent/ImageCompetence

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Configure le bouton avec les informations de la compétence
func setup(skill_data: PlayerUpgrade):
	skill = skill_data
	$Main/Title.text = skill_data.name
	$Main/MainContent/Info/Info_base/Description.text = skill_data.description
	$Main/MainContent/Info/MarginBuyButton/BuyButton.text = str(skill_data.price) + " Coin"
	$Main/MainContent/Info/Info_base/Level.text = "Level: "+str(skill_data.current_level) 
	if skill_data and "icon" in skill_data and skill_data.icon:
		$Main/MainContent/ImageCompetence.texture = skill_data.icon
	else:
		$Main/MainContent/ImageCompetence.texture = preload("res://icon.svg")
		
func update_information():
	if skill.current_level==skill.max_level:
		buy_button.text = "Niveau max atteint"
		buy_button.disabled
	else:
		buy_button.text = str(skill.price) + " Patoune"
	level.text = "Niveau: "+str(skill.current_level)

func _on_buy_button_pressed() -> void:
	var upgrade:PlayerUpgrade = PlayerManager.player_data.find_upgrade_by_key(skill.primary_key)
	if PlayerManager.player_data.can_upgrade(upgrade):
		PlayerManager.player_data.buy_upgrade(skill.primary_key)
		update_information()
		
