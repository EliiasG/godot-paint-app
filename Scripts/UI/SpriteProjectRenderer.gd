class_name SpriteProjectRenderer
extends Node2D

export var editor_path: NodePath
export var sprite_item_renderer_scene: PackedScene
export var camera_path: NodePath

onready var _editor: SpriteProjectEditor = get_node(editor_path)
onready var _camera: CameraController = get_node(camera_path)

func _ready() -> void:
	var root_item: SpriteItemRenderer = sprite_item_renderer_scene.instance()
	root_item.sprite_item = _editor.sprite_project.root
	root_item.camera = _camera
	add_child(root_item)
	root_item.setup()
