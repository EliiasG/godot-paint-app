class_name Util

static func swap(array: Array, index1: int, index2: int) -> void:
	var tmp = array[index1]
	array[index1] = array[index2]
	array[index2] = tmp

static func move(array: Array, index: int, amount: int) -> void:
	if index >= -amount and index < array.size() - amount:
		swap(array, index, index + amount)
