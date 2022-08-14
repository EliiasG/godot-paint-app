class_name SpriteItem
extends Resource

signal children_changed
signal name_changed

export var name: String = "Root" setget set_name
export var position: Vector2 = Vector2.ZERO setget set_position
export var color: Color = Color.white setget set_color
export var layer: int = 0 setget set_layer
export var shape: Resource setget set_shape #set in _init to fire setter
export var parent: Resource = null setget set_parent
export(Array, Resource) var _modifiers: Array
export(Array, Resource) var _children: Array

var is_selected: bool = false setget set_is_selected

func _init() -> void:
	_children = []
	_modifiers = []
	self.shape = SpriteItemShape.new()

func move(amount: int) -> void:
	var index: int = parent._children.find(self)
	Util.move(parent._children, index, amount)
	parent.emit_signal("children_changed")

func copy() -> Resource:
	var new_item: Resource = duplicate(true)
	new_item.name = name
	new_item.position = position
	new_item.color = color
	new_item.shape = shape.duplicate()
	# TODO: implemt modifiers
	new_item.parent = null
	new_item._children.clear()
	for child in _children:
		new_item.add_child(child.copy())
	return new_item

func get_children() -> Array:
	return _children


func add_child(new_child: Resource) -> void:
	new_child.parent = self
	#signal is emitted by the child


func remove_child(child: Resource) -> void:
	_children.erase(child)
	emit_signal("children_changed")


func delete() -> void:
	if parent != null:
		parent.remove_child(self)


func set_name(new_value: String) -> void:
	name = new_value
	emit_changed()
	emit_signal("name_changed")

func set_position(new_value: Vector2) -> void:
	position = new_value
	emit_changed()


func set_color(new_value: Color) -> void:
	color = new_value
	emit_changed()


func set_layer(new_value: int) -> void:
	layer = new_value
	emit_changed()


func set_shape(new_value: Resource) -> void:
	if shape is Resource and shape.is_connected("changed", self, "emit_changed"):
		shape.disconnect("changed", self, "emit_changed")
	shape = new_value
	if not shape.is_connected("changed", self, "emit_changed"):
		shape.connect("changed", self, "emit_changed")
	emit_changed()


func set_parent(new_value: Resource) -> void:
	if parent != null:
		parent.remove_child(self)
	
	parent = new_value
	if parent != null:
		#not using add_child() as it sets the parent and would cause recursion
		parent._children.append(self)
		parent.emit_signal("children_changed")


func set_is_selected(new_value: bool) -> void:
	is_selected = new_value
	emit_changed()


func add_modifier(modifier: Resource) -> void:
	modifier.item = self
	_modifiers.append(modifier)
	if not modifier.is_connected("changed", self, "emit_changed"):
		modifier.connect("changed", self, "emit_changed")


func remove_modifier(modifier: Resource) -> void:
	modifier.item = null
	_modifiers.erase(modifier)
	if modifier.is_connected("changed", self, "emit_changed"):
		modifier.disconnect("changed", self, "emit_changed")


func get_modifiers() -> Array:
	return _modifiers
