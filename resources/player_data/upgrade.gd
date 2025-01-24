extends Resource
class_name PlayerUpgrade

@export var primary_key: int
@export var name: String
@export var description: String
@export var price: int
@export var max_level: int
@export var current_level: int
@export var icon: Texture2D = preload("res://icon.svg")
@export var link_icon_buy_menu : String = ""
