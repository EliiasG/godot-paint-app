class_name SpriteItemRenderer
extends Node2D

var sprite_item: Resource

onready var _shape: Node2D = $Shape
onready var _children: Node2D = $Children

func setup() -> void:
	sprite_item.connect("changed", self, "redraw_shape")
	sprite_item.connect("children_changed", self, "redraw_children")
	redraw_shape()
	redraw_children()


func redraw_shape() -> void:
	position = sprite_item.position
	name = sprite_item.name
	var new_shape: Polygon2D = Polygon2D.new()
	new_shape.name = "Shape"
	new_shape.polygon = sprite_item.shape.vertices
	new_shape.color = sprite_item.color
	
	for modifier in sprite_item.get_modifiers():
		new_shape = modifier.apply(new_shape)
	
	_clear(_shape)
	
	_shape.add_child(new_shape)


func redraw_children() -> void:
	_clear(_children)
	for child in sprite_item.get_children():
		var new_child: SpriteItemRenderer = duplicate()
		new_child.sprite_item = child
		_children.add_child(new_child)
		new_child.setup()


func _clear(node: Node) -> void:
	for child in node.get_children():
		child.queue_free()
