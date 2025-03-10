extends Node2D

@export var _max_distance: float = 50
var _total_puzzles: int


func _ready():
	var start_node: Node2D = get_node("Start")
	var end_node: Node2D =	get_node("End")
	_max_distance = abs(start_node.position.y - end_node.position.y)

func set_total_puzzles(total_puzzles: int) -> void:
	_total_puzzles = total_puzzles

func drill():
	position.y += _max_distance / (_total_puzzles)
