class_name Tab
extends Node


func _can_be_closed() -> bool:
	return true


func _get_name() -> String:
	return "Unnamed tab"


func _get_content() -> Control:
	return null


func _close() -> bool:
	return true
