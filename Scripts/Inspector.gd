extends Panel

export var sprite_project_tree_path: NodePath
export var number_property_scene: PackedScene
export var property_row_path: NodePath
export var name_label_path: NodePath

var _selected_item: SpriteItem

onready var _property_row: Control = get_node(property_row_path)
onready var _sprite_project_tree: SpriteProjectTree = get_node(sprite_project_tree_path)
onready var _name_label: Label = get_node(name_label_path)


func _ready() -> void:
	_sprite_project_tree.connect("selected_item", self, "_item_selected")


func _item_selected(new_item: SpriteItem) -> void:
	_selected_item = new_item
	_name_label.text = new_item.name
	Util.clear(_property_row)
	if new_item.parent != null: # if the parent is null, then the item is the root
		var layer_property: NumberProperty = number_property_scene.instance()
		layer_property.value = _selected_item.layer
		layer_property.text = "Layer"
		layer_property.is_int = true
		layer_property.connect("value_changed", self, "_layer_changed")
		_property_row.add_child(layer_property)


func _layer_changed(new_value: float) -> void:
	_selected_item.layer = int(new_value)
