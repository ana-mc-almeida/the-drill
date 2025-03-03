class_name LevelManager
extends Node

@export var TOTAL_PUZZLES = 5
@export var PREVIEWS_START_POSITION = Vector2(160, 10)
@export var PREVIEWS_MAX_SIZE = 400
@export var PREVIEW_GAP = 20

var PUZZLES_SIZE = [4, 6, 8, 10, 12]
var GRID_SIZE = 400

var _dificulty
var _timer: RichTextLabel
var _current_time: float
var _puzzles: Array
var _completed_puzzles: int = 0

func _ready() -> void:
	_current_time = 0
	_timer = get_node("Timer")

	var puzzle_node = preload("res://scenes/puzzle.tscn")
	_puzzles = []

	var previews_size = calculate_previews_size(TOTAL_PUZZLES)
	var previews = get_node('Previews')
	# 150 is the position.y of levels node
	previews.position = Vector2(PREVIEWS_START_POSITION.x, 150 - PREVIEW_GAP - previews_size)

	for puzzle_number in range(TOTAL_PUZZLES - 1, -1, -1):
		print('building puzzle', puzzle_number)
		var level = puzzle_node.instantiate()
		level.set_level_manager(self)
		level.initiate(puzzle_number,
			GRID_SIZE,
			PUZZLES_SIZE[puzzle_number],
			"res://assets/" + str(puzzle_number + 1) + ".png",
			previews_size,
			PREVIEW_GAP)
		level.name = 'Level ' + str(puzzle_number)
		get_node("Puzzles").add_child(level)
		_puzzles.append(level)

func calculate_previews_size(total_puzzles: int):
	return (float(PREVIEWS_MAX_SIZE) - (PREVIEW_GAP * (total_puzzles - 1))) / total_puzzles

func complete_level():
	_completed_puzzles += 1
	#if _completed_puzzles == len(_puzzles):
		#_game_manager.win(_current_time, _dificulty)

func _process(delta: float) -> void:
	_current_time += delta
	var minutes: int = int(_current_time / 60)
	var seconds: int = int(fmod(_current_time, 60))
	var decimals: int = int(fmod(_current_time, 1) * 100)
	_timer.text = "%02d:%02d.%02d" % [minutes, seconds, decimals]
