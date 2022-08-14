extends Node2D

const GRID_SCALE: int = 100

var active: bool = true


func _process(delta: float) -> void:
	update()
	if Input.is_action_just_pressed("grid_lines"):
		active = not active


func _draw() -> void:
	if active:
		var size: Vector2 = get_viewport().size * 15
		for i in range(max(size.x, size.y) / State.grid_size / GRID_SCALE):
			var current_dist: int = i * State.grid_size * GRID_SCALE
			var offset: Vector2 = Vector2(fmod(-global_position.x, GRID_SCALE), fmod(-global_position.y, GRID_SCALE))
			var start: Vector2 = (-size / 2 / GRID_SCALE).round() * GRID_SCALE
			draw_line(start + Vector2(current_dist, 0) + offset, start + Vector2(current_dist, size.y) + offset, Color.black, 0.5, true)
			draw_line(start + Vector2(0, current_dist) + offset, start + Vector2(size.x, current_dist) + offset, Color.black, 0.5, true)
