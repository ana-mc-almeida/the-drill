class_name GridCell
extends Node2D

var _matrix

func get_cell_size(grid_size: float, level_size: int) -> float:
	return grid_size / level_size

func generate_grid(grid_size: float, level_size: int) -> void:
	var cell_scene = preload("res://scenes/cell.tscn")
	var cell_size = get_cell_size(grid_size, level_size)

	for i in range(level_size):
		for j in range(level_size):
			var cell = cell_scene.instantiate()
			cell.set_grid_position(Vector2i(i, j))
			cell.set_scale(Vector2(cell_size / cell.size.x, cell_size / cell.size.y))
			cell.position = Vector2(position.x + i * cell_size, position.y + j * cell_size)
			add_child(cell)

#func click(grid_position: Vector2i) -> void:
func click(btn: Node) -> void:
	print(name, " ", btn.get_grid_position())
	remove_child(btn)
