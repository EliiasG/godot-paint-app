class_name CameraController
extends Camera2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var zoom_speed: float = 0.1
export var max_zoom: float = 1
export var min_zoom: float = 0.05

var _old_mouse_psoition: Vector2 = Vector2.ZERO
var _current_zoom: float = 1

func _process(_delta: float) -> void:
	var mouse_position: Vector2 = Util.mouse_position
	var viewport_parent: ViewportContainer = get_viewport().get_parent()
	var position_limit: Vector2 = get_viewport().size * 5
	
	if mouse_position.x > viewport_parent.rect_global_position.x and mouse_position.x < viewport_parent.rect_global_position.x + get_viewport().size.x:
		if Input.is_action_pressed("drag"):
			translate((_old_mouse_psoition - mouse_position) * _current_zoom)
		
		if not Input.is_action_pressed("control"):
			if Input.is_action_just_released("zoom_in"):
				_current_zoom -= zoom_speed * _current_zoom
			
			if Input.is_action_just_released("zoom_out"):
				_current_zoom += zoom_speed * _current_zoom
	
	_current_zoom = clamp(_current_zoom, min_zoom, max_zoom)
	
	zoom = Vector2(_current_zoom, _current_zoom)
	
	position = Vector2(clamp(position.x, -position_limit.x, position_limit.x), clamp(position.y, -position_limit.y, position_limit.y))
	
	_old_mouse_psoition = mouse_position

func get_fixed_mouse_position() -> Vector2:
	#i have to use this function, as the built-in mouse position functions seem to not work properly in nested viewports
	return (Util.mouse_position - get_viewport().get_parent().rect_global_position - get_viewport().size / 2) * _current_zoom + global_position
