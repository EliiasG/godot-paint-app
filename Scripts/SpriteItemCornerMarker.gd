class_name SpriteItemCornerMarker
extends Node2D


var shape: SpriteItemShape
var camera: CameraController
var index: int
var dragging: bool = false
const DRAG_DIST = 100

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click") and camera.get_fixed_mouse_position().distance_squared_to(global_position) < pow(DRAG_DIST, 2):
		dragging = true
	if dragging:
		global_position = (camera.get_fixed_mouse_position() / State.grid_size / 100 - Vector2(0.5, 0.5)).ceil() * State.grid_size * 100
	if Input.is_action_just_released("click"):
		var vertecies: PoolVector2Array = shape.get_vertecies()
		for i in range(len(vertecies)):
			if i == index:
				continue
			if position.is_equal_approx(vertecies[i]):
				print(self, index)
				#TODO fix double insert bug
				if i == index + 1 or i == index - 1:
					shape.insert_vertex(max(index, i),vertecies[index] - (vertecies[index] - vertecies[i]) / 2)
				return
		shape.set_vertex(index, position)
