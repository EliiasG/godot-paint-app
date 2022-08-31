class_name StartMenuTab
extends Tab


func _init() -> void:
	_content_scene = preload("res://Scenes/UI/StartScreen.tscn")

func _can_be_closed() -> bool:
	return false

func _get_name() -> String:
	return "Start Menu"

func _close() -> bool:
	return true
