extends Node

var mouse_position: Vector2

var grid_size: float = 0.1

const WIDTH: int = 1440
const HEIGHT: int = 810


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


