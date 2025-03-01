class_name GridCell
extends GridContainer

var cell_scene: PackedScene
var _matrix

func generate_grid() -> void:
	cell_scene = preload("res://scenes/cell.tscn")

	for i in range(columns):
		for j in range(columns):
			var cell = cell_scene.instantiate()
			cell.set_grid_position(Vector2i(i, j))
			add_child(cell)

func click(grid_position: Vector2i) -> void:
	print(name, " ", grid_position)
