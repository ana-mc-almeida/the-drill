extends Node

var _score: float = 0
var _dificulty: String
var _name_text: TextEdit

func _ready():
	_name_text = get_node("TextEdit")

func _save_score_pressed():
	var db_ref = Firebase.Database.get_database_reference("scores")
	print('Got database reference' if (db_ref) else 'Error getting db_ref') # debug

	var player_name = _name_text
	if _name_text.text == null:
		player_name = _name_text.placeholder_text
		
	db_ref.push({'name': _name_text.text, 'time': _score, 'mode': _dificulty})
	self.visible = false
	get_node("../StartMenu").visible = true

func set_score(score: float, difficulty: String):
	_score = score
	_dificulty = difficulty
	print('WIN with score=' + str(score))
