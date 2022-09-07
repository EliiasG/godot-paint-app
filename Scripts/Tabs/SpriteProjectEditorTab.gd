class_name SpriteProjectEditorTab
extends Tab

var path: String

func _init(path) -> void:
	_content_scene = preload("res://Scenes/UI/SpriteProjectEditor.tscn")
	self.path = path


func _get_content() -> Control:
	._get_content()
	_content.sprite_project = SpriteProjectSaver.load_sprite(path)
	return _content


func _can_be_closed() -> bool:
	return true


func _get_name() -> String:
	return Util.get_name_from_path(path)


func _close() -> bool:
	return true
