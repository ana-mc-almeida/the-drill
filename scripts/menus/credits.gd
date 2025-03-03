extends Node


func _on_return_pressed() -> void:
	self.visible = false
	get_node("../StartMenu").visible = true
