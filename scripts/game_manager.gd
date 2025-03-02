extends Node

@export var LEVELS_SIZE = [4, 6, 8, 10, 12]
@export var GRID_SIZE = 400

var levels: Array

func _ready() -> void:
	var level_node = preload("res://scenes/level.tscn")
	var total_levels = len(LEVELS_SIZE)
	levels = []

	for level_number in range(total_levels - 1, -1, -1):
		print('building level', level_number)
		var level = level_node.instantiate()
		level.initiate(GRID_SIZE, LEVELS_SIZE[level_number], "res://assets/" + str(level_number + 1) + ".png", get_node("Previews").get_children()[level_number])
		level.name = 'Level ' + str(level_number)
		add_child(level)
		levels.append(level)
