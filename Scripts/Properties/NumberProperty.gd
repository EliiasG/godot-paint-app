class_name NumberProperty
extends Property

signal value_changed(new_value)

var value: float = 0 setget set_value
var is_int: bool = false setget set_is_int

var _is_ready: bool = false

onready var _spin_box: SpinBox = $SpinBox

func _ready() -> void:
	_is_ready = true
	_spin_box.rounded = is_int
	_spin_box.value = value


func set_value(new_value: float) -> void:
	value = new_value
	if _is_ready:
		_spin_box.value = value


func set_is_int(new_value: bool) -> void:
	is_int = new_value
	if _is_ready:
		_spin_box.rounded = is_int


func _spin_box_value_changed(new_value: float) -> void:
	value = new_value
	emit_signal("value_changed", value)
