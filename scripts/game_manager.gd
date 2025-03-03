class_name GameManager
extends Node

func play(scene: PackedScene):
	var node = scene.instantiate()
	node.get_node("Level").set_game_manager(self)
	get_tree().root.add_child(node)
	
func win(score: float, difficulty: String):
	var win_node = get_node('Win')
	win_node.set_score(score, difficulty)
	win_node.visible = true
