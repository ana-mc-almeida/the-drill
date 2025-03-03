extends Node
var _score: float

func set_score(score: float):
	_score = score
	get_node("Score").text = str(_score)
