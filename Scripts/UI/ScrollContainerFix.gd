extends ScrollContainer

const SPEED: int = 100

func _process(delta: float) -> void:
	if Input.is_action_just_released("zoom_in"):
		scroll_vertical -= SPEED
	if Input.is_action_just_released("zoom_out"):
		scroll_vertical += SPEED
