extends Control

#Video Setting
@onready var display_option = $SettingTabs/Options/MarginContainer/VideoSettings/OptionButton
@onready var display_fps_button = $SettingTabs/Options/MarginContainer/VideoSettings/CheckButton
@onready var max_fps_slider = $SettingTabs/Options/MarginContainer/VideoSettings/HBoxContainer/MaxFpsSlider
@onready var max_fps_value = $SettingTabs/Options/MarginContainer/VideoSettings/HBoxContainer/MaxFPSVal


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display_option.select(1 if Save.game_data.fullscreen_on else 0)
	GlobalSetting.toggle_fullscreen(Save.game_data.fullscreen_on)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_option_button_item_selected(index: int) -> void:
	GlobalSetting.toggle_fullscreen(true if index==1 else false)

func _on_max_fps_slider_value_changed(value: float) -> void:
	GlobalSetting.set_max_fps(value)
	max_fps_value.text = str(value)


func _on_master_volume_slider_value_changed(value: float) -> void:
	if value == -20:
		value = -80
	GlobalSetting.update_master_volume(value)
