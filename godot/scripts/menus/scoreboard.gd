class_name Scoreboard
extends Node
var score_scene: PackedScene

var easy_scores: Array = []
var medium_scores: Array = []
var hard_scores: Array = []
var current_dificulty: int = int(Dificulty.EASY)

func update():
	var vbox_node = get_node("Scores/VBoxContainer")
	var children = vbox_node.get_children()
	for child in children:
		if is_instance_valid(child) and child in vbox_node.get_children():
			vbox_node.remove_child(child)
			child.queue_free()
	
	var selected_scores
	var dificulty_node = get_node("Dificulty")	

	match current_dificulty:
		Dificulty.EASY:
			selected_scores = easy_scores
			dificulty_node.text = "Easy"
		Dificulty.MEDIUM:
			selected_scores = medium_scores
			dificulty_node.text = "Medium"
		Dificulty.HARD:
			selected_scores = hard_scores
			dificulty_node.text = "Hard"
	
	score_scene = preload("res://scenes/score.tscn")
	for score in selected_scores:
		var node = score_scene.instantiate()
		node.text = LevelManager.format_score(score[0]) + " " + score[1]
		vbox_node.add_child(node)

func add_score(score: float, player_name: String, mode: String):
	match mode:
		"easy":
			easy_scores.append([score, player_name])
			easy_scores.sort()
		"medium":
			medium_scores.append([score, player_name])
			medium_scores.sort()
		"hard":
			hard_scores.append([score, player_name])
			hard_scores.sort()

func change_dificulty() -> void:
	current_dificulty = int(current_dificulty) + 1
	if current_dificulty == len(Dificulty.keys()):
		current_dificulty = int(Dificulty.EASY)
	update()

func _on_return_pressed() -> void:
	self.visible = false
	get_node("../StartMenu").visible = true

enum Dificulty {EASY, MEDIUM, HARD}
