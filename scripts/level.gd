class_name GridCell
extends GridContainer

var cell_scene: PackedScene

func generate_grid(n: int) -> void:
	columns = n
	cell_scene = preload("res://scenes/cell.tscn")

	for i in range(columns * columns):
		add_child(cell_scene.instantiate())

func click():
	print("Click")
