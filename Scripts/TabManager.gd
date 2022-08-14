class_name TabManager
extends Tabs

var tabs: Array = Array()

export var content_container_path: NodePath

var old_index: int = 0

onready var _content_container: Control = get_node(content_container_path)

func open_tab(tab: Tab) -> void:
	tabs.append(tab)
	add_tab(tab._get_name())
	var new_content: Control = tab._get_content()
	new_content.visible = false
	_content_container.add_child(new_content)


func close(tab: Tab) -> void:
	_close_index(tabs.find(tab))


func _ready() -> void:
	State.tab_manager = self
	connect("tab_close", self, "_close_index")
	connect("tab_changed", self, "_tab_changed")
	add_tab("Start Menu")
	add_tab("Test")


func _close_index(index: int) -> void:
	if tabs[index]._close():
		remove_tab(index)
		_content_container.remove_child(get_child(index))
		tabs.remove(index)


func _tab_changed(index: int) -> void:
	var tab: Tab = tabs[index]
	_content_container.get_child(old_index).visible = false
	_content_container.get_child(index).visible = true
	tab_close_display_policy = Tabs.CLOSE_BUTTON_SHOW_ACTIVE_ONLY if tab._can_be_closed() else Tabs.CLOSE_BUTTON_SHOW_NEVER
	old_index = index
