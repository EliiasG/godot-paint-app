class_name SpriteItemRootMarker
extends Node2D


var sprite_item: Resource
var camera: CameraController

onready var _icon: Node2D = $Icon
onready var _original_scale = _icon.scale

func _process(delta: float) -> void:
	_icon.scale = _original_scale * camera.zoom
	if Input.is_action_pressed("click"):
		if Input.is_action_pressed("control") or Input.is_action_pressed("alt"):
			var old_position: Vector2 = sprite_item.position
			sprite_item.position = Util.snap(sprite_item.position + (camera.get_fixed_mouse_position() - global_position) / 100, State.grid_size) 
			if Input.is_action_pressed("alt"):
				var shape: SpriteItemShape = sprite_item.shape
				for i in len(shape.get_vertecies()):
					shape.set_vertex(i, shape.get_vertecies()[i] + (old_position - sprite_item.position))
