class_name StartScreen
extends Control


onready var _file_dialog: FileDialog = $FileDialog


func _open_button_pressed() -> void:
	_file_dialog.popup()


func _dir_selected(dir: String) -> void:
	var tab_manager = State.tab_manager
	
	tab_manager.close(tab_manager.get_tab_from_content(self))
