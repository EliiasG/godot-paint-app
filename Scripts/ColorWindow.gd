extends CanvasLayer

signal closed(selected_color)

export var color_button_container: NodePath
export var color_select_button_scene: PackedScene

onready var _color_ui: Control = $ColorUI

onready var _color_button_container: GridContainer = get_node(color_button_container)


func open() -> void:
	_color_ui.visible = true
	get_tree().paused = true
	Util.clear(_color_button_container)
	for color in State.palette:
		var new_button: ColorSelectButton = color_select_button_scene.instance()
		new_button.color = color
		new_button.connect("clicked", self, "_selected_color")
		_color_button_container.add_child(new_button)


func _selected_color(color) -> void:
	_color_ui.visible = false
	get_tree().paused = false
	emit_signal("closed", color)


func _close_button_pressed() -> void:
	_selected_color(null)
