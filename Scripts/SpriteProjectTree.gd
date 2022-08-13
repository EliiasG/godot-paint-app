class_name SpriteProjectTree
extends Tree

export var editor_path: NodePath

signal selected_item(new_item)

var _sprite_item_dictionary: Dictionary = {}# TreeItem: SpriteItem
var _clipboard: Resource = null
var _selected_item: Resource = null

onready var _popup: PopupMenu = $Popup
onready var _editor: SpriteProjectEditor = get_node(editor_path)
onready var _root: SpriteItem = _editor.sprite_project.root


func _ready() -> void:
	redraw()

func _process(delta: float) -> void:
	if Input.is_action_pressed("control") and get_selected_sprite_item() != null:
		if Input.is_action_just_pressed("up"):
			get_selected_sprite_item().move(-1)
		if Input.is_action_just_pressed("down"):
			get_selected_sprite_item().move(1)

func redraw() -> void:
	var closed_items: Array = _get_closed_items()
	_sprite_item_dictionary = {}
	clear()
	_draw_sprite_item(closed_items, null, _root)


func _get_closed_items() -> Array:
	var closed: Array = []
	for key in _sprite_item_dictionary.keys():
		if key.collapsed:
			closed.append(_sprite_item_dictionary[key])
	return closed


func _draw_sprite_item(closed_items: Array, parent: TreeItem, sprite_item: Resource) -> void:
	_connect_sprite_item(sprite_item)
	var new_tree_item: TreeItem = create_item(parent)
	new_tree_item.set_text(0, sprite_item.name)
	new_tree_item.collapsed = closed_items.has(sprite_item)
	#new_tree_item.set_cell_mode(1, TreeItem.CELL_MODE_RANGE)
	#new_tree_item.set_range_config(1, 0, 100, 1, false)
	
	_sprite_item_dictionary[new_tree_item] = sprite_item
	for child in sprite_item.get_children():
		_draw_sprite_item(closed_items, new_tree_item, child)


func _connect_sprite_item(sprite_item: Resource):
	for signal_name in ["children_changed", "name_changed"]:
		if not sprite_item.is_connected(signal_name, self, "redraw"):
			sprite_item.connect(signal_name, self, "redraw")


func _on_item_rmb_selected(position: Vector2) -> void:
	for i in [1, 3, 4, 7]:
		_popup.set_item_disabled(i, get_selected_sprite_item() == _root)
	_popup.popup(Rect2(position, _popup.rect_size))


func _on_item_selected() -> void:
	if _selected_item is SpriteItem:
		_selected_item.is_selected = false
	_selected_item = _sprite_item_dictionary[get_selected()]
	_selected_item.is_selected = true
	emit_signal("selected_item", _selected_item)


func _rename_sprite_item(sprite_item: Resource) -> bool:
	InputWindow.open(true, "Rename Part", sprite_item.name)
	# not static typed because it can be null
	var result = yield(InputWindow, "closed")
	if result is String:
		sprite_item.name = result
	return result is String

func get_selected_sprite_item() -> Resource:
	return _sprite_item_dictionary[get_selected()] if get_selected() != null else null

func _on_id_pressed(id: int) -> void:
	match id:
		0:
			# Add Child
			InputWindow.open(true, "Add Part", "New Part")
			var result = yield(InputWindow, "closed")
			if result is String:
				var new_sprite_item: SpriteItem = SpriteItem.new()
				new_sprite_item.name = result
				get_selected_sprite_item().add_child(new_sprite_item)
		1:
			# Rename
			_rename_sprite_item(get_selected_sprite_item())
		2:
			# Cut
			_clipboard = get_selected_sprite_item().copy()
			get_selected_sprite_item().delete()
		3:
			# Copy
			_clipboard = get_selected_sprite_item().copy()
		4:
			# Paste Into
			if _clipboard != null:
				get_selected_sprite_item().add_child(_clipboard.copy())
		5:
			# Delete
			InputWindow.open(false, "Delete \"" + get_selected_sprite_item().name + "\"")
			var result = yield(InputWindow, "closed")
			if result is String:
				get_selected_sprite_item().delete()
