extends Node

func _ready() -> void:
	var level1 = get_node("Level1")
	var level2 = get_node("Level2")
	var level3 = get_node("Level3")
	var level4 = get_node("Level4")
	var level5 = get_node("Level5")
	level1.generate_grid(400, 4)
	level2.generate_grid(400, 6)
	level3.generate_grid(400, 8)
	level4.generate_grid(400, 10)
	level5.generate_grid(400, 12)
