extends Button

var _cell_type = CellType.EMPTY
var _grid_position: Vector2i

func _ready() -> void:
	pressed.connect(click)

func set_grid_position(grid_position: Vector2i) -> void:
	_grid_position = grid_position
	
func get_grid_position() -> Vector2i:
	return _grid_position

func next_cell_type() -> void:
	var index: int = CellType.keys().find(_cell_type)
	index += 1
	if index >= len(CellType.keys()):
		index = 0
	_cell_type = CellType.keys()[index]
	print(_cell_type)

func click() -> void:
	next_cell_type()
	#get_parent().click(self)
	# visible = false
	#mouse_filter = Control.MOUSE_FILTER_IGNORE
	
enum CellType {EMPTY, PICKAXE, DYNAMITE}
