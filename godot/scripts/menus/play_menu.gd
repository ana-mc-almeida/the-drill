extends Node

var _game_manager: GameManager

func _ready():
	_game_manager = get_parent()

func _on_easy_pressed() -> void:
	self.visible = false
	_game_manager.play(preload("res://scenes/levels/easy.tscn"), "easy")

func _on_medium_pressed() -> void:
	self.visible = false
	_game_manager.play(preload("res://scenes/levels/medium.tscn"), "medium")


func _on_hard_pressed() -> void:
	self.visible = false
	_game_manager.play(preload("res://scenes/levels/hard.tscn"), "hard")

func _on_return_pressed() -> void:
	self.visible = false
	get_node("../StartMenu").visible = true
