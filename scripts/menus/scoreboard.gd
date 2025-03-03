extends Node

var scores = [1000, 20000, 2 , 3,4,5,6,7,8,9,1]
var score_scene: PackedScene

func _ready():
	score_scene = preload("res://scenes/score.tscn")
	for score in scores:
		var node = score_scene.instantiate()
		node.text = str(score)
		get_node("Scores/VBoxContainer").add_child(node)



func _on_return_pressed() -> void:
	self.visible = false
	get_node("../StartMenu").visible = true
