extends Camera2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var zoom_speed: float = 0.1
export var max_zoom: float = 1
export var min_zoom: float = 0.1

var _old_mouse_psoition: Vector2 = Vector2.ZERO
var _current_zoom: float = 1

func _process(_delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_parent().get_viewport().get_mouse_position()
	var viewport_parent: ViewportContainer = get_viewport().get_parent()
	var position_limit: Vector2 = get_viewport().size / 2
	
	if mouse_position.x > viewport_parent.rect_position.x and mouse_position.x < viewport_parent.rect_position.x + get_viewport().size.x:
		if Input.is_action_pressed("drag"):
			translate((_old_mouse_psoition - mouse_position) * _current_zoom)
		
		if Input.is_action_just_released("zoom_in"):
			_current_zoom -= zoom_speed * _current_zoom
		
		if Input.is_action_just_released("zoom_out"):
			_current_zoom += zoom_speed * _current_zoom
	
	_current_zoom = clamp(_current_zoom, min_zoom, max_zoom)
	
	zoom = Vector2(_current_zoom, _current_zoom)
	
	position = Vector2(clamp(position.x, -position_limit.x, position_limit.x), clamp(position.y, -position_limit.y, position_limit.y))
	
	_old_mouse_psoition = mouse_position
