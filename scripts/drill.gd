extends Node2D

@export var _max_distance: float = 50
var _total_puzzles: int

func set_total_puzzles(total_puzzles: int) -> void:
	_total_puzzles = total_puzzles

func drill():
	position.y += _max_distance / (_total_puzzles - 1)
