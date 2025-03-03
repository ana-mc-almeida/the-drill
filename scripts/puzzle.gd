extends Node2D

var _matrix_solved # The final solution
var _current_matrix # What is displayed to the user
var _correct_matrix # The cells that the user can be sure are correct
var _size
var _cells_matrix = []
var _cells_preview = []
var _preview: Node2D
var _level_manager: LevelManager

func set_level_manager(level_manager: LevelManager):
	_level_manager = level_manager

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

func generate_grid(grid_size: float, image_path: String, is_preview: bool, node: Node2D, offset: float) -> void:
	var cell_scene = preload("res://scenes/cell_preview.tscn") if is_preview else preload("res://scenes/cell.tscn")
	var cell_size = grid_size / _size

	var tile_width
	var tile_height
	var image
	if image_path:
		image = load(image_path).get_image()
		tile_width = image.get_width() / _size
		tile_height = image.get_height() / _size

	for i in range(_size):
		for j in range(_size):
			var cell_position = Vector2i(i, j)
			var cell = cell_scene.instantiate()
			cell.initiate()
			
			cell.set_grid_position(cell_position)
			cell.set_cell_type(_current_matrix[position_to_index(cell_position)])
			
			if _current_matrix[position_to_index(cell_position)] != 0:
				cell.disabled = true
				
			cell.set_scale(Vector2(cell_size / cell.size.x, cell_size / cell.size.y))
			cell.position = Vector2(position.x + i * cell_size - offset, position.y + j * cell_size - offset)
			
			if not is_preview:
				var tile_region = Rect2(i * tile_width, j * tile_height, tile_width + 5, tile_height + 5)
				var tile_image = image.get_region(tile_region)
				var texture = ImageTexture.create_from_image(tile_image)

				var sprite = Sprite2D.new()
				sprite.texture = texture
				sprite.centered = true
				sprite.scale = Vector2(cell.size.x / tile_width, cell.size.y / tile_height)
				sprite.position = Vector2(cell.size.x / 2, cell.size.y / 2)
				cell.add_child(sprite, false, InternalMode.INTERNAL_MODE_FRONT)
				_cells_matrix.append(cell)
			else:
				_cells_preview.append(cell)

			node.add_child(cell)

func load_matrix():
	var file = "res://levels.json"
	var jsonString = FileAccess.get_file_as_string(file)
	var puzzlesAllSizes = JSON.parse_string(jsonString)
	
	var puzzles = puzzlesAllSizes['size' + str(_size)]

	var puzzle = puzzles[randi() % puzzles.size()]

	_matrix_solved = puzzle.full
	_current_matrix = puzzle.empty
	_correct_matrix = puzzle.empty

func initiate(level_number: int, grid_size: float, size: int, image_path: String, preview_size: int,
	preview_gap: int, offset: float):
	_size = size
	load_matrix()
	generate_grid(grid_size + offset, image_path, false, self, offset / 2)
	createPreview(level_number, preview_size, preview_gap)
	
	printMatrix(_current_matrix)
	printMatrix(_matrix_solved)

func check_line(line: int):
	print('Checking line ' + str(line))
	print(get_line(_matrix_solved, line))
	return same_array(get_line(_matrix_solved, line), get_line(_current_matrix, line))
	
func check_column(column: int):
	print('Checking column ' + str(column))
	print(get_column(_matrix_solved, column))
	print(get_column(_current_matrix, column))
	
	return same_array(get_column(_matrix_solved, column), get_column(_current_matrix, column))
	
func check_new_position(cell_position: Vector2i):
	if (check_line(cell_position.y)): remove_line(cell_position.y)
	if (check_column(cell_position.x)): remove_column(cell_position.x)
	
func remove_line(line):
	print('Removing Line ' + str(line))
	for column in range(_size):
		var index = column * _size + line
		_correct_matrix[index] = _current_matrix[index]
		var child = _cells_matrix[index]
		if is_instance_valid(child) and child in get_children():
			remove_child(child)
			child.queue_free()
	print('_correct_matrix')
	printMatrix(_correct_matrix)
		
func remove_column(column):
	print('Removing column ' + str(column))
	for line in range(_size):
		var index = column * _size + line
		_correct_matrix[index] = _current_matrix[index]
		var child = _cells_matrix[index]
		if is_instance_valid(child) and child in get_children():
			remove_child(child)
			child.queue_free()
	print('_correct_matrix')
	printMatrix(_correct_matrix)

func update_position(btn: Node):
	var new_cell_type = btn.get_cell_type()
	_current_matrix[position_to_index(btn.get_grid_position())] = new_cell_type
	printMatrix(_current_matrix) # debug

	var preview_cell = _cells_preview[position_to_index_preview(btn.get_grid_position())]
	preview_cell.set_cell_type(new_cell_type)
	if same_array(_matrix_solved, _current_matrix):
		_level_manager.complete_puzzle()
	return
	
func position_to_index(cell_position: Vector2i) -> int:
	return cell_position.y * _size + cell_position.x

func position_to_index_preview(cell_position: Vector2i) -> int:
	return cell_position.x * _size + cell_position.y
	
func click(btn: Node) -> void:
	update_position(btn)
	check_new_position(btn.get_grid_position())
	print(name, " ", btn.get_grid_position())

func createPreview(level_number: int, preview_size: int, preview_gap: int):
	var preview = Node2D.new()
	var position_x = preview_gap * level_number
	preview.position.x = position_x + level_number * preview_size
	preview.name = 'Preview' + str(level_number)

	_level_manager.get_node('Previews').add_child(preview)
	
	generate_grid(preview_size, "", true, preview, 0)

	_preview = preview

	createPreviewResetButton(preview_size)

func createPreviewResetButton(preview_size):
	print('Creating Reset Button')
	var button = Button.new()
	button.custom_minimum_size = Vector2(preview_size, preview_size)
	button.position = _preview.position
	button.connect("pressed", Callable(self, "clearBoard"))
	button.name = 'Reset Button'
	_preview.add_child(button)
	print('Button Created')

func clearBoard():
	print('Cleaning Board')
	printMatrix(_correct_matrix)

	for j in range(_size):
		for i in range(_size):
			var index = position_to_index(Vector2(i, j))
			var cell_type = _correct_matrix[index]
			if(cell_type == 0):
				_cells_matrix[index].set_cell_type(cell_type)
				_cells_preview[index].set_cell_type(cell_type)

	_current_matrix = _correct_matrix
	print('Board Cleard')
