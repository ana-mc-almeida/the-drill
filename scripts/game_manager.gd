extends Node

@export var LEVELS_SIZE = [4, 6, 8, 10, 12]
@export var GRID_SIZE = 400

var _timer: RichTextLabel
var _current_time: float
var _levels: Array

func _ready() -> void:
	_current_time = 0
	_timer = get_node("Timer")

	var level_node = preload("res://scenes/level.tscn")
	var total_levels = len(LEVELS_SIZE)
	_levels = []

	for level_number in range(total_levels - 1, -1, -1):
		print('building level', level_number)
		var level = level_node.instantiate()
		level.initiate(GRID_SIZE, LEVELS_SIZE[level_number], "res://assets/" + str(level_number + 1) + ".png", get_node("Previews").get_children()[level_number])
		level.name = 'Level ' + str(level_number)
		add_child(level)
		_levels.append(level)


func _process(delta: float) -> void:
	_current_time += delta

	var minutes: int = int(_current_time / 60)
	var seconds: int = int(fmod(_current_time, 60))
	var decimals: int = int(fmod(_current_time, 1) * 100)

	_timer.text = "%02d:%02d:%02d" % [minutes, seconds, decimals]
