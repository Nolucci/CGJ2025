extends Camera2D

func zoom_on_position(position: Vector2, zoom_level: float = 1.0, duration: float = 0.5):
	global_position = position
	var tween = create_tween()
	tween.tween_property(self, "zoom", Vector2(zoom_level, zoom_level), duration)
