class_name SpriteItemShape
extends Resource

export var _vertices: PoolVector2Array = PoolVector2Array()

func _init() -> void:
	add_vertex(Vector2(0, 0))
	add_vertex(Vector2(10, 0))
	add_vertex(Vector2(0, 10))


func add_vertex(vertex: Vector2) -> void:
	_vertices.append(vertex)
	emit_changed()


func set_vertex(index: int, vertex: Vector2) -> void:
	_vertices.set(index, vertex)
	emit_changed()


func remove_vertex(index: int) -> void:
	_vertices.remove(index)
	emit_changed()


func get_vertecies() -> PoolVector2Array:
	return _vertices
