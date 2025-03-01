extends Node

func _ready() -> void:
	var level1 = get_node("Level1")
	var level2 = get_node("Level2")
	level2.generate_grid()
	level1.generate_grid()
