extends Node

var scores = []
var score_scene: PackedScene

func _ready():
	score_scene = preload("res://scenes/score.tscn")
	for score in scores:
		var node = score_scene.instantiate()
		node.text = str(score)
		get_node("Scores/VBoxContainer").add_child(node)

func add_score(score: String):
	scores.append(score)
	var node = score_scene.instantiate()
	node.text = score
	get_node("Scores/VBoxContainer").add_child(node)
	

func _on_return_pressed() -> void:
	self.visible = false
	get_node("../StartMenu").visible = true
