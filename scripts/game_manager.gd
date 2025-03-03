class_name GameManager
extends Node

var db_email = 'speedjam9@gmail.com'
var db_pass = '5KdpvkTrZQWy6g=='
var scoreboard_scene: Scoreboard

func _ready():
	scoreboard_scene = get_node("Scoreboard")
	Firebase.Auth.login_succeeded.connect(_on_FirebaseAuth_login_succeeded)
	Firebase.Auth.login_failed.connect(_on_FirebaseAuth_login_failed)
	Firebase.Auth.login_with_email_and_password(db_email, db_pass)
	
func _on_FirebaseAuth_login_succeeded(auth):
	var db_ref = Firebase.Database.get_database_reference("scores", {})
	db_ref.new_data_update.connect(_on_db_data_update)
	db_ref.patch_data_update.connect(_on_db_data_update)
	db_ref.delete_data_update.connect(_on_db_data_update)

func _on_db_data_update(resource: Object):
	var player_name = resource.data.get("name")
	if player_name == null:
		player_name = ""
	scoreboard_scene.add_score(resource.data.time, player_name,
		resource.data.mode)
	
func _on_FirebaseAuth_login_failed(error_code, message):
	print("error code: " + str(error_code))
	print("message: " + str(message))

func play(scene: PackedScene):
	var node = scene.instantiate()
	node.get_node("Level").set_game_manager(self)
	get_tree().root.add_child(node)
	
func win(score: float, difficulty: String):
	var win_node = get_node('Win')
	win_node.set_score(score, difficulty)
	win_node.visible = true
