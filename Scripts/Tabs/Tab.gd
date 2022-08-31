class_name Tab
extends Node

var _content: Control

var _content_scene: PackedScene

func _can_be_closed() -> bool:
	return true


func _get_name() -> String:
	return "Unnamed tab"


func _get_content() -> Control:
	if not _content is Control:
		_content = _content_scene.instance()
	return _content


func _close() -> bool:
	return true
