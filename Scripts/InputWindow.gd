extends CanvasLayer

export var line_edit_path: NodePath
export var label_path: NodePath

var is_open: bool = false

onready var _input_ui: Control = $InputUI
onready var _line_edit: LineEdit = get_node(line_edit_path)
onready var _label: Label = get_node(label_path)

signal closed(selected_text)

func open(is_text: bool, label_text: String = "", default_text: String = "") -> void:
	is_open = true
	_input_ui.visible = true
	get_tree().paused = true
	_label.text = label_text
	_line_edit.visible = is_text
	if is_text:
		_line_edit.text = default_text
		_line_edit.select_all()
		_line_edit.grab_focus()

func cancel() -> void:
	is_open = false
	_input_ui.visible = false
	get_tree().paused = false
	emit_signal("closed", null)

func confirm() -> void:
	is_open = false
	_input_ui.visible = false
	get_tree().paused = false
	emit_signal("closed", _line_edit.text)

func _text_entered(_new_text: String) -> void:
	confirm()
