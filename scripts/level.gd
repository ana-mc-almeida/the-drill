class_name GridCell
extends Node2D

var _matrix_solved
var _current_matrix
var _size

func printMatrix(matrix): # debug
	for line in range(_size):
		print(matrix.slice(line * _size, line * _size + _size))


func get_cell_size(grid_size: float) -> float:
	return grid_size / _size

func generate_grid(grid_size: float) -> void:
	var cell_scene = preload("res://scenes/cell.tscn")
	var cell_size = get_cell_size(grid_size)

	for i in range(_size):
		for j in range(_size):
			var cell = cell_scene.instantiate()
			cell.set_grid_position(Vector2i(i, j))
			cell.set_scale(Vector2(cell_size / cell.size.x, cell_size / cell.size.y))
			cell.position = Vector2(position.x + i * cell_size, position.y + j * cell_size)
			add_child(cell)

func load_matrix():
	var file = "res://levels.json"
	var jsonString = FileAccess.get_file_as_string(file)
	var puzzlesAllSizes = JSON.parse_string(jsonString)
	
	var puzzles = puzzlesAllSizes['size' + str(_size)]

	var puzzle = puzzles[randi() % puzzles.size()]

	_matrix_solved = puzzle.full
	_current_matrix = puzzle.empty


func initiate(grid_size: float, level_size: int):
	_size = level_size
	generate_grid(grid_size)
	load_matrix()


#func click(grid_position: Vector2i) -> void:
func click(btn: Node) -> void:
	print(name, " ", btn.get_grid_position())
	remove_child(btn)
