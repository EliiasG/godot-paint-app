extends Label

var divisor: int = 1

func _process(delta: float) -> void:
	if Input.is_action_pressed("control"):
		if Input.is_action_just_released("zoom_in"):
			divisor = min(8, divisor + 1)
		if Input.is_action_just_released("zoom_out"):
			divisor = max(1, divisor - 1)
	State.grid_size = 1.0 / divisor
	text = "Grid Size: " + ("1" if divisor == 1 else "1/" + str(divisor))
