extends Node

var _score: float = 0
var _dificulty: String
var _name = 'Olá DB' # FIXME

func _save_score_pressed():
	var db_ref = Firebase.Database.get_database_reference("scores")
	print('Got database reference' if (db_ref) else 'Error getting db_ref') # debug

	print(_score)
	print(_dificulty)
	print(_name)
	db_ref.push({'name': _name, 'time': _score, 'mode': _dificulty})
	self.visible = false
	get_node("../StartMenu").visible = true

func set_score(score: float, difficulty: String):
	_score = score
	_dificulty = difficulty
	print('WIN with score=' + str(score))
