extends Button

var dynamite_sprite: Sprite2D
var pickaxe_sprite: Sprite2D

var _cell_type: CellType = CellType.EMPTY
var _grid_position: Vector2i

func _ready() -> void:
	pressed.connect(click)
	dynamite_sprite = get_node("dynamite")
	pickaxe_sprite = get_node("pickaxe")
	update_image_type()

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
	var next_index = int(_cell_type) + 1
	if next_index >= len(CellType.keys()):
		next_index = 0
	_cell_type = CellType.values()[next_index]
	update_image_type()

func update_image_type() -> void:
	if _cell_type == CellType.DYNAMITE:
		dynamite_sprite.visible = true
		pickaxe_sprite.visible = false
	elif _cell_type == CellType.PICKAXE:
		dynamite_sprite.visible = false
		pickaxe_sprite.visible = true
	else:
		dynamite_sprite.visible = false
		pickaxe_sprite.visible = false

func click() -> void:
	next_cell_type()
	get_parent().click(self)
	
enum CellType {EMPTY, PICKAXE, DYNAMITE}
