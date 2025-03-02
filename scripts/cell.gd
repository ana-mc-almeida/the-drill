extends Button

var _cell_type = CellType.EMPTY
var _grid_position: Vector2i

func _ready() -> void:
	pressed.connect(click)

func set_grid_position(grid_position: Vector2i) -> void:
	_grid_position = grid_position
	
func get_grid_position() -> Vector2i:
	return _grid_position

func get_cell_type() -> CellType:
	return _cell_type
	
func set_cell_type(cell_type):
	_cell_type = cell_type

func index_to_cell_type(index: int) -> CellType:
	return CellType.keys()[index]

func next_cell_type() -> void:
	_cell_type += 1
	if _cell_type >= len(CellType.keys()):
		_cell_type = 0

func click() -> void:
	next_cell_type()
	get_parent().click(self)
	# visible = false
	#mouse_filter = Control.MOUSE_FILTER_IGNORE
	
enum CellType {EMPTY, PICKAXE, DYNAMITE}
