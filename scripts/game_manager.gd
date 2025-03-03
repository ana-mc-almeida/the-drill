class_name GameManager
extends Node

func play(scene: PackedScene):
	var node = scene.instantiate()
	node.get_node("Level").set_game_manager(self)
	get_tree().root.add_child(node)
	
