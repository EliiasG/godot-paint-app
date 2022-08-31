class_name ProjectManager
extends Control


var path: String
var _clipboard: String = ""
var _file_dictionary: Dictionary #TreeItem: String (path)
var _double_click_timer: float = 0

export var folder_icon: Texture
export var sprite_icon: Texture
export var unknown_icon: Texture

onready var _popup: PopupMenu = $Tree/FolderPopup
onready var _tree: Tree = $Tree

func _process(delta: float) -> void:
	_double_click_timer = max(_double_click_timer - delta, 0)


func get_selected_path() -> String:
	return _file_dictionary[_tree.get_selected()]


func _ready() -> void:
	_redraw()


func _get_open_folders() -> Array:
	var open_folders: Array = Array()
	for item in _file_dictionary.keys():
		if not item.collapsed:
			open_folders.append(_file_dictionary[item])
	return open_folders


func _draw_file(parent: TreeItem, path: String):
	var new_item: TreeItem = _tree.create_item(parent)
	var item_name: String = Util.get_name_from_path(path)
	new_item.set_text(0, item_name)
	if item_name.ends_with(".res"):
		new_item.set_icon(0, sprite_icon)
		_file_dictionary[new_item] = path
	else:
		new_item.set_icon(0, unknown_icon)


func _draw_directory(parent: TreeItem, path: String, open_folders: Array) -> void:
	var dir: Directory = Directory.new()
	var new_item: TreeItem = _tree.create_item(parent)
	new_item.collapsed = not open_folders.has(path)
	new_item.set_text(0, Util.get_name_from_path(path))
	new_item.set_icon(0, folder_icon)
	_file_dictionary[new_item] = path
	if dir.open(path) == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				_draw_directory(new_item, path + "/" + file_name, open_folders)
			else:
				_draw_file(parent, path)
			file_name = dir.get_next()
	else:
		print("Unable to load path: \"" + path + "\", redrawing")
		_redraw()
	


func _redraw() -> void:
	#get a list of open folders
	var open_folders = _get_open_folders()
	#clear dictionary of files
	_file_dictionary.clear()
	#clear tree
	_tree.clear()
	#add files to tree and dictionary
	_draw_directory(null, path, open_folders)


func _item_selected() -> void:
	pass


func _item_activated() -> void:
	_item_double_clicked()


func _item_double_clicked() -> void:
	var path: String =  _file_dictionary[_tree.get_selected()]
	if path is String:
		print(path)


func _item_rmb_selected(position: Vector2) -> void:
	_popup.popup(Rect2(position, _popup.rect_size))


func _popup_id_pressed(id: int) -> void:
	var selected_path: String = get_selected_path()
	var dir: Directory = Directory.new()
	match id:
		0:
			# Add Folder
			pass
		1:
			# Add Sprite
			pass
		2:
			# Rename
			InputWindow.open(true, "Rename File", Util.get_name_from_path(selected_path))
			# not static typed because it can be null
			var result = yield(InputWindow, "closed")
			if result is String:
				var new_path: String = Util.get_parent_from_path(selected_path) + "/" + result
				if path == selected_path:
					path = new_path
				dir.rename(selected_path, new_path)
		3:
			# Copy
			_clipboard = selected_path
			print(_clipboard)
		4:
			# Paste Into
			Util.copy_dir(_clipboard, selected_path)
		5:
			#Delete
			InputWindow.open(false, "Delete \"" + Util.get_name_from_path(selected_path) + "\"")
			var result = yield(InputWindow, "closed")
			if result is String:
				dir.remove(selected_path)
		6:
			# Show in File Manager
			OS.shell_open(get_selected_path())
	_redraw()

