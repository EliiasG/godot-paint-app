class_name SpriteItemShape
extends Resource

export var vertices: PoolVector2Array setget set_vertices


func set_vertices(new_value: PoolVector2Array):
	vertices = new_value
	emit_signal("changed")
