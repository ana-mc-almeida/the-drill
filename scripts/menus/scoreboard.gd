extends Node

var scores = [1000, 20000]
var score_scene: PackedScene

func _ready():
	score_scene = preload("res://scenes/score.tscn")
	for score in scores:
		var node = score_scene.instantiate()
		node.text = str(score)
		get_node("Scores/VBoxContainer").add_child(node)
