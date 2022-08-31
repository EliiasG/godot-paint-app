class_name ProjectManagerTab
extends Tab

var path: String

func _init(path) -> void:
	_content_scene = preload("res://Scenes/UI/ProjectManager.tscn")
	self.path = path


func _get_content() -> Control:
	._get_content()
	_content.path = path
	return _content


func _can_be_closed() -> bool:
	return false


func _get_name() -> String:
	return "Project"


func _close() -> bool:
	return false
