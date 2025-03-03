extends Node

func _on_play_pressed() -> void:
	self.visible = false
	get_node("../Play").visible = true

func _on_scoreboard_pressed() -> void:
	self.visible = false
	get_node("../Scoreboard").visible = true

func _on_credits_pressed() -> void:
	self.visible = false
	get_node("../Credits").visible = true
