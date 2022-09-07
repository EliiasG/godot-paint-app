extends Node


func save(path: String, sprite: SpriteProject) -> void:
	ResourceSaver.save(path, sprite)


func create(path: String) -> void:
	save(path, SpriteProject.new())

func load_sprite(path: String) -> SpriteProject:
	return load(path) as SpriteProject
