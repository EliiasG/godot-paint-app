class_name SpriteItemRootMarker
extends Node2D


var sprite_item: SpriteItem
var camera: CameraController


func _process(delta: float) -> void:
	if Input.is_action_pressed("control") and Input.is_action_pressed("click"):
		#the following line sets the position of the SpriteItem to the position of the mouse, snapping to the grid
		#it is a mess
		sprite_item.position = ((sprite_item.position + (camera.get_fixed_mouse_position() - global_position) / 100) / State.grid_size - Vector2(0.5, 0.5)).ceil() * State.grid_size
