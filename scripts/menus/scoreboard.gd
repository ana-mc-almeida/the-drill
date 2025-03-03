class_name Scoreboard
extends Node
var score_scene: PackedScene

var easy_scores: Array = []
var medium_scores: Array = []
var hard_scores: Array = []

func update():
	score_scene = preload("res://scenes/score.tscn")
	for score in easy_scores:
		var node = score_scene.instantiate()
		node.text = LevelManager.format_score(score[0]) + " " + score[1]
		get_node("Scores/VBoxContainer").add_child(node)

func add_score(score: float, name: String, mode: String):
	match mode:
		"easy":
			easy_scores.append([score, name])
			easy_scores.sort()
		"medium":
			medium_scores.append([score, name])
			medium_scores.sort()
		"hard":
			hard_scores.append([score, name])
			hard_scores.sort()

func _on_return_pressed() -> void:
	self.visible = false
	get_node("../StartMenu").visible = true
