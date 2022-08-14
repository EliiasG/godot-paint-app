class_name SpriteItemCornerMarker
extends Node2D


var shape: SpriteItemShape
var camera: CameraController
var index: int
var dragging: bool = false
const DRAG_DIST = 100

onready var _icon: Node2D = $Icon
onready var _original_scale = _icon.scale

func _process(delta: float) -> void:
	_icon.scale = _original_scale * camera.zoom
	var vertecies: PoolVector2Array = shape.get_vertecies()
	var closest_sqared_dist: float = pow(DRAG_DIST, 2)
	var closest_index: int = -1
	for i in range(len(vertecies)):
		var squared_dist: float = camera.get_fixed_mouse_position().distance_squared_to(get_parent().global_position + vertecies[i] * 100)
		if squared_dist < closest_sqared_dist:
			closest_sqared_dist = squared_dist
			closest_index = i
	if index == closest_index:
		if Input.is_action_just_pressed("click"):
			dragging = true
		elif Input.is_action_just_pressed("delete"):
			shape.remove_vertex(index)
	if dragging:
		global_position = Util.snap(camera.get_fixed_mouse_position(), State.grid_size * 100)
	if Input.is_action_just_released("click") and dragging:
		for i in range(len(vertecies)):
			if i == index:
				continue
			if position.is_equal_approx(vertecies[i]):
				print(self, index)
				if i == index + 1 or i == index - 1:
					insert_between(index, i, max(index, i))
				elif max(i, index) == len(vertecies) - 1 and min(i, index) == 0:
					insert_between(index, i, len(vertecies))
				else:
					shape.set_vertex(index, vertecies[index])
				return
		shape.set_vertex(index, position)

func insert_between(index1: int, index2: int, new_index: int):
	var vertecies: PoolVector2Array = shape.get_vertecies()
	shape.insert_vertex(new_index,vertecies[index1] - (vertecies[index1] - vertecies[index2]) / 2)
