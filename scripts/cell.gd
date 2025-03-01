extends Button

var _grid_position: Vector2i

func _ready() -> void:
	pressed.connect(click)

func set_grid_position(grid_position: Vector2i) -> void:
	_grid_position = grid_position

func click() -> void:
	get_parent().click(_grid_position)
	visible = false
