class_name LevelManager
extends Node

@export var TOTAL_PUZZLES = 5
@export var PREVIEWS_START_POSITION = Vector2(160, 10)
@export var PREVIEWS_MAX_SIZE = 400
@export var PREVIEW_GAP = 20

var PUZZLES_SIZE = [4, 6, 8, 10, 12]
var GRID_SIZE = 400

var _game_manager: GameManager
var _timer: RichTextLabel
var _current_time: float
var _puzzles: Array
var _completed_puzzles: int = 0
var _dificulty = 'easy' # TODO: FIXME

func _ready() -> void:
	_current_time = 0
	_timer = get_node("Timer")
	get_node("Drill").set_total_puzzles(TOTAL_PUZZLES)
	var puzzle_node = preload("res://scenes/puzzle.tscn")
	_puzzles = []

	var previews_size = calculate_previews_size(TOTAL_PUZZLES)
	var previews = get_node('Previews')
	# 150 is the position.y of levels node
	previews.position = Vector2(PREVIEWS_START_POSITION.x, 150 - PREVIEW_GAP - previews_size)

	for puzzle_number in range(TOTAL_PUZZLES - 1, -1, -1):
		var offset: float
		if puzzle_number == 0:
			offset = 30
			
		print('building puzzle', puzzle_number)
		var level = puzzle_node.instantiate()
		level.set_level_manager(self)
		level.initiate(puzzle_number,
			GRID_SIZE,
			PUZZLES_SIZE[puzzle_number],
			"res://assets/" + str(puzzle_number + 1) + ".png",
			previews_size,
			PREVIEW_GAP,
			offset)
		level.name = 'Level ' + str(puzzle_number)
		get_node("Puzzles").add_child(level)
		_puzzles.append(level)

func set_dificulty(dificulty: String) -> void:
	_dificulty = dificulty

func set_game_manager(game_manager: GameManager):
	_game_manager = game_manager

func calculate_previews_size(total_puzzles: int):
	return (float(PREVIEWS_MAX_SIZE) - (PREVIEW_GAP * (total_puzzles - 1))) / total_puzzles

func complete_puzzle():
	_completed_puzzles += 1
	get_node("Drill").drill()
	if _completed_puzzles == TOTAL_PUZZLES:
		_game_manager.win(_current_time, _dificulty)
		queue_free()

func _process(delta: float) -> void:
	_current_time += delta
	_timer.text = format_score(_current_time)

static func format_score(score: float) -> String:
	var minutes: int = int(score / 60)
	var seconds: int = int(fmod(score, 60))
	var decimals: int = int(fmod(score, 1) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, decimals]
