class_name GridCell
extends Node2D

var _matrix_solved
var _current_matrix
var _size

func printMatrix(matrix): # debug
	for line in range(_size):
		print(matrix.slice(line * _size, line * _size + _size))
	print('---')

func same_array(array1, array2):
	for i in range(len(array1)):
		if array1[i] != array2[i]: return false
	return true

func get_line(matrix, line):
	return matrix.slice(line * _size, line * _size + _size)

func get_column(matrix, column):
	var columnArray = []
	for line in range(_size):
		columnArray.append(matrix[line * _size + column])
	return columnArray

func get_cell_size(grid_size: float) -> float:
	return grid_size / _size

func generate_grid(grid_size: float, image_path: String) -> void:
	var cell_scene = preload("res://scenes/cell.tscn")
	var cell_size = grid_size / _size

	var image = load(image_path).get_image()
	var tile_width = image.get_width() / _size
	var tile_height = image.get_height() / _size

	for i in range(_size):
		for j in range(_size):
			var tile_region = Rect2(i * tile_width, j * tile_height, tile_width, tile_height)
			var tile_image = image.get_region(tile_region)

			# Convert the image region to a texture
			var texture = ImageTexture.create_from_image(tile_image)

			# Create a Sprite2D to display the tile
			var sprite = Sprite2D.new()
			sprite.texture = texture
			sprite.centered = true

			var cell_position = Vector2i(i, j)
			var cell = cell_scene.instantiate()
			cell.set_grid_position(cell_position)
			cell.set_cell_type(_current_matrix[position_to_index(cell_position)])
			cell.set_scale(Vector2(cell_size / cell.size.x, cell_size / cell.size.y))
			cell.position = Vector2(position.x + i * cell_size, position.y + j * cell_size)

			# Center the sprite within the cell:
			sprite.scale = Vector2(cell.size.x / tile_width, cell.size.y / tile_height)
			sprite.position = Vector2(cell.size.x / 2, cell.size.y / 2)

			cell.add_child(sprite)
			add_child(cell)

func load_matrix():
	var file = "res://levels.json"
	var jsonString = FileAccess.get_file_as_string(file)
	var puzzlesAllSizes = JSON.parse_string(jsonString)
	
	var puzzles = puzzlesAllSizes['size' + str(_size)]

	var puzzle = puzzles[randi() % puzzles.size()]

	_matrix_solved = puzzle.full
	_current_matrix = puzzle.empty


func initiate(grid_size: float, size: int, image_path: String):
	_size = size
	load_matrix()
	generate_grid(grid_size, image_path)
	
	printMatrix(_current_matrix)
	printMatrix(_matrix_solved)

func check_line(line: int):
	print('Checking line ' + str(line))
	print(get_line(_matrix_solved, line))
	return same_array(get_line(_matrix_solved, line), get_line(_current_matrix, line))
	
func check_column(column: int):
	print('Checking column ' + str(column))
	print(get_column(_matrix_solved, column))
	
	return same_array(get_line(_matrix_solved, column), get_line(_current_matrix, column))
	
func check_new_position(position: Vector2i):
	print(check_line(position.y))
	print(check_column(position.x))

func update_position(btn: Node):
	_current_matrix[position_to_index(btn.get_grid_position())] = btn.get_cell_type()
	printMatrix(_current_matrix) # debug
	return
	
func position_to_index(position: Vector2i) -> int:
	return position.y * _size + position.x

func click(btn: Node) -> void:
	update_position(btn)
	check_new_position(btn.get_grid_position())
	print(name, " ", btn.get_grid_position())
	# remove_child(btn)
