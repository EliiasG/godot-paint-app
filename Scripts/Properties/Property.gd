class_name Property
extends Control

export var text: String = "Text" setget set_text

onready var _label: Label = $Label

func set_text(new_value: String) -> void:
	text = new_value
	if _label is Label:
		_label.text = text

func _ready() -> void:
	_label.text = text
