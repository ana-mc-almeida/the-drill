extends Node

var db_email = 'speedjam9@gmail.com'
var db_pass = '5KdpvkTrZQWy6g=='

var _score: float
var _dificulty: String
var _name = 'Olá DB' # FIXME

func _ready():
	Firebase.Auth.login_succeeded.connect(_on_FirebaseAuth_login_succeeded)
	Firebase.Auth.login_failed.connect(_on_FirebaseAuth_login_failed)
	Firebase.Auth.login_with_email_and_password(db_email, db_pass)
	
func _on_FirebaseAuth_login_succeeded(auth):
	print('Login Succeded')
	# print(auth)
	
func _on_FirebaseAuth_login_failed(error_code, message):
	print("error code: " + str(error_code))
	print("message: " + str(message))

func _save_score_pressed():
	var db_ref = Firebase.Database.get_database_reference("scores")
	print('Got database reference' if (db_ref) else 'Error getting db_ref') # debug

	print(_score)
	print(_dificulty)
	print(_name)
	db_ref.push({'name': _name, 'time': _score, 'mode': _dificulty})

func set_score(score: float, difficulty: String):
	_score = score
	_dificulty = difficulty
	print('WIN with score=' + str(score))
