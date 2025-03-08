extends Node

func _on_play_pressed() -> void:
	self.visible = false
	get_node("../Play").visible = true

func _on_scoreboard_pressed() -> void:
	self.visible = false
	var scoreboard_node = 	get_node("../Scoreboard")
	scoreboard_node.visible = true
	scoreboard_node.update()

func _on_credits_pressed() -> void:
	self.visible = false
	get_node("../Credits").visible = true
