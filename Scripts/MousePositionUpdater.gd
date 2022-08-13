extends Node2D


func _process(delta: float) -> void:
	Util.mouse_position = get_global_mouse_position()
