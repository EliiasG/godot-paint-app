class_name SpriteItemRenderer
extends Node2D

export var marker_scene: PackedScene

var sprite_item: Resource
var camera: CameraController

onready var _shape: Node2D = $Shape
onready var _children: Node2D = $Children


func _ready() -> void:
	sprite_item.connect("changed", self, "redraw_shape")
	sprite_item.connect("children_changed", self, "redraw_children")
	redraw_shape()
	redraw_children()


func redraw_shape() -> void:
	position = sprite_item.position
	name = sprite_item.name
	var new_shape: Polygon2D = Polygon2D.new()
	new_shape.name = "Shape"
	new_shape.polygon = sprite_item.shape.get_vertecies()
	new_shape.color = sprite_item.color
	
	
	for modifier in sprite_item.get_modifiers():
		new_shape = modifier.apply(new_shape)
	
	Util.clear(_shape)
	
	_shape.add_child(new_shape)
	
	if sprite_item.is_selected:
		var marker: SpriteItemRootMarker = marker_scene.instance()
		marker.sprite_item = sprite_item
		marker.camera = camera
		_shape.add_child(marker)


func redraw_children() -> void:
	Util.clear(_children)
	for child in sprite_item.get_children():
		var new_child: SpriteItemRenderer = duplicate()
		new_child.sprite_item = child
		new_child.camera = camera
		_children.add_child(new_child)
