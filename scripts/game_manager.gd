class_name GameManager
extends Node

@export var LEVELS_SIZE = [4, 6, 8, 10, 12]
@export var GRID_SIZE = 400
@export var PREVIEW_GAP = 20
@export var PREVIEWS_START_POSITION = Vector2(160, 10)

var _timer: RichTextLabel
var _current_time: float
var _levels: Array
var _completed_levels: int = 0

func calculate_previews_size(total_levels: int):
	return (float(GRID_SIZE) - (PREVIEW_GAP * (total_levels - 1))) / total_levels

func _ready() -> void:
	_current_time = 0
	_timer = get_node("Timer")

	var level_node = preload("res://scenes/level.tscn")
	var total_levels = len(LEVELS_SIZE)
	_levels = []

	var previews_size = calculate_previews_size(total_levels)
	var previews = get_node('Previews')
	# 150 is the position.y of levels node
	previews.position = Vector2(PREVIEWS_START_POSITION.x, 150 - PREVIEW_GAP - previews_size)

	for level_number in range(total_levels - 1, -1, -1):
		print('building level', level_number)
		var level = level_node.instantiate()
		level.set_game_manager(self)
		level.initiate(level_number,
			GRID_SIZE,
			LEVELS_SIZE[level_number],
			"res://assets/" + str(level_number + 1) + ".png",
			previews_size,
			PREVIEW_GAP)
		level.name = 'Level ' + str(level_number)
		get_node("Levels").add_child(level)
		_levels.append(level)

func complete_level():
	_completed_levels += 1
	if _completed_levels == len(_levels):
		win(_current_time)

func win(score: float): # TODO
	print("WIN with score = ", score)

func _process(delta: float) -> void:
	_current_time += delta
	var minutes: int = int(_current_time / 60)
	var seconds: int = int(fmod(_current_time, 60))
	var decimals: int = int(fmod(_current_time, 1) * 100)
	_timer.text = "%02d:%02d.%02d" % [minutes, seconds, decimals]
