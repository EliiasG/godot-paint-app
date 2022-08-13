class_name SpriteItemRootMarker
extends Node2D


var sprite_item: SpriteItem
var camera: CameraController


func _process(delta: float) -> void:
	print((camera.get_fixed_mouse_position() - global_position) / 10)
	if Input.is_action_pressed("control") and Input.is_action_pressed("click"):
		sprite_item.position = ((sprite_item.position + (camera.get_fixed_mouse_position() - global_position) / 10) / Util.grid_size).ceil() * Util.grid_size
