class_name ColorSelectButton
extends ColorRect

signal clicked(color)

onready var _button: Button = $Button

func _ready() -> void:
	_button.connect("button_down", self, "emit_clicked")


func emit_clicked():
	emit_signal("clicked", color)
