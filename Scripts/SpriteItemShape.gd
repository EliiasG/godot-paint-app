class_name SpriteItemShape
extends Resource

export var _vertices: PoolVector2Array = PoolVector2Array()


func add_vertex(vertex: Vector2) -> void:
	insert_vertex(len(_vertices), vertex)


func insert_vertex(index: int, vertex: Vector2) -> void:
	for v in _vertices:
		if v.is_equal_approx(vertex):
			return
	_vertices.insert(index, vertex)
	emit_changed()


func set_vertex(index: int, vertex: Vector2) -> void:
	_vertices.set(index, vertex)
	emit_changed()


func remove_vertex(index: int) -> void:
	_vertices.remove(index)
	emit_changed()


func get_vertecies() -> PoolVector2Array:
	return _vertices
