class_name ColorProperty
extends Property

signal value_changed(new_value)

var value: Color setget set_value

var _is_ready: bool = false

onready var _color_display: ColorRect = $ColorDisplay
onready var _button: Button = $ColorDisplay/Button


func _ready() -> void:
	_is_ready = true
	_color_display.color = value


func set_value(new_value: Color) -> void:
	value = new_value
	if _is_ready:
		_color_display.color = value
	emit_signal("value_changed", value)


func _choose_color() -> void:
	ColorWindow.open()
	var new_color = yield(ColorWindow, "closed")
	if new_color is Color:
		self.value = new_color
