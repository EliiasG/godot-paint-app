class_name StartMenuTab
extends Tab


var content: Control


var _start_menu_scene: PackedScene = preload("res://Scenes/UI/StartScreen.tscn")

func _can_be_closed() -> bool:
	return false


func _get_name() -> String:
	return "Start Menu"


func _get_content() -> Control:
	if not content is Control:
		content = _start_menu_scene.instance()
	return content


func _close() -> bool:
	return true
