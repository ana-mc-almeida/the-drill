extends Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(play)

func play():
	print('play')
	var easy = preload("res://scenes/levels/easy.tscn")
	
	get_tree().root.add_child(easy.instantiate())
