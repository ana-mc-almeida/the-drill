extends Button

func _ready() -> void:
	pressed.connect(get_parent().click)
