extends Node

func _ready() -> void:
	var level1 = get_node("Level1")
	level1.generate_grid(4)
