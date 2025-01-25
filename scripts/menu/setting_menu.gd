extends Control

#Video Setting
@onready var display_option = $SettingTabs/Video/MarginContainer/VideoSettings/OptionButton
@onready var display_fps_button = $SettingTabs/Video/MarginContainer/VideoSettings/CheckButton
@onready var max_fps_slider = $SettingTabs/Video/MarginContainer/VideoSettings/HBoxContainer/MaxFpsSlider
@onready var max_fps_value = $SettingTabs/Video/MarginContainer/VideoSettings/HBoxContainer/MaxFPSVal

#Audio Setting
@onready var master_vol_slider = $SettingTabs/Audio/MarginContainer/AudioSettings/MasterVolumeSlider
@onready var music_vol_slider = $SettingTabs/Audio/MarginContainer/AudioSettings/MusicVolumeSlider
@onready var sfx_vol_slider = $SettingTabs/Audio/MarginContainer/AudioSettings/SFXVolumeSlider





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display_option.select(1 if Save.game_data.fullscreen_on else 0)
	GlobalSetting.toggle_fullscreen(Save.game_data.fullscreen_on)
	max_fps_slider.value = Save.game_data.max_fps
	master_vol_slider.value = Save.game_data.master_vol
	music_vol_slider.value = Save.game_data.music_vol
	sfx_vol_slider.value = Save.game_data.sfx_vol


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_option_button_item_selected(index: int) -> void:
	GlobalSetting.toggle_fullscreen(true if index==1 else false)


func _on_check_button_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.


func _on_max_fps_slider_value_changed(value: float) -> void:
	GlobalSetting.set_max_fps(value)
	max_fps_value.text = str(value)


func _on_master_volume_slider_value_changed(value: float) -> void:
	GlobalSetting.update_master_volume(value)


func _on_music_volume_slider_value_changed(value: float) -> void:
	GlobalSetting.update_music_volume(value)


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	GlobalSetting.update_sfx_volume(value)
