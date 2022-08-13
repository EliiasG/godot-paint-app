class_name SpriteItemModifier
extends Resource

export var item: Resource


func apply(node: Polygon2D) -> Polygon2D:
	return _apply(node)


func move(amount: int) -> void:
	var index: int = item._modifiers.find(self)
	Util.move(item._modifiers, index, amount)
	item.emit_changed()


func _apply(node: Polygon2D) -> Polygon2D:
	return node


func _get_name() -> String:
	return "Name Not Set"
