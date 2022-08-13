extends Property

var value: float = 0 setget set_value

onready var _spin_box: SpinBox = $SpinBox

func set_value(new_value: float) -> void:
	value = new_value
	_spin_box.value = new_value


func _spin_box_value_changed(new_value: float) -> void:
	value = new_value
