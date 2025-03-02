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
	var cell_size = grid_size / _size

	var image = load("res://assets/S2 EP7 4K (71).jpg").get_image()
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
			sprite.scale = Vector2(cell_size / tile_width, cell_size / tile_height)

			var cell = cell_scene.instantiate()
			cell.set_grid_position(Vector2i(i, j))
			cell.set_scale(Vector2(cell_size / cell.size.x, cell_size / cell.size.y))
			cell.position = Vector2(position.x + i * cell_size, position.y + j * cell_size)

			# Center the sprite within the cell:
			sprite.position = Vector2(cell_size / 2, cell_size / 2)

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


func initiate(grid_size: float, size: int):
	_size = size
	generate_grid(grid_size)
	load_matrix()
	printMatrix(_matrix_solved)


#func click(grid_position: Vector2i) -> void:
func click(btn: Node) -> void:
	print(name, " ", btn.get_grid_position())
	remove_child(btn)
