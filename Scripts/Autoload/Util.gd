extends Node

var mouse_position: Vector2

func swap(array: Array, index1: int, index2: int) -> void:
	var tmp = array[index1]
	array[index1] = array[index2]
	array[index2] = tmp


func move(array: Array, index: int, amount: int) -> void:
	if index >= -amount and index < array.size() - amount:
		swap(array, index, index + amount)


func clear(node: Node) -> void:
	for child in node.get_children():
		child.queue_free()


func snap(vector: Vector2, grid_size: float):
	return (vector / grid_size - Vector2(0.5, 0.5)).ceil() * grid_size


func copy_dir(path: String, to: String) -> void:
	#TODO fix
	var dir: Directory = Directory.new()
	var new_path: String = to + "/" + get_name_from_path(path)
	dir.make_dir(new_path)
	if dir.open(path) == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while file_name != "":
			print(file_name)
			var new_dir: Directory = Directory.new()
			if dir.current_is_dir():
				copy_dir(path + "/" + file_name, new_path)
			else:
				new_dir.copy(path + "/" + file_name, to + "/" + file_name)
		dir.list_dir_end()
	else:
		print("Unable to load path: \"" + path)


func get_name_from_path(path: String) -> String:
	return path.split("/")[-1].split("\\")[-1]


func get_parent_from_path(path: String) -> String:
	return path.substr(0, len(path) - len(Util.get_name_from_path(path)) - 1)
