extends Node

var size: int = 7
var cell_scene = preload("res://scenes/cell.tscn")
var matrix = []
var turn: int = 0

func _ready() -> void:
	for i in range(size):
		var row = []
		for j in range(size):
			var cell = cell_scene.instantiate()
			add_child(cell)
			cell.init(i, j, self)
			row.append(cell)
		matrix.append(row)

	for i in range(size):
		for j in range(size):
			if i > 0:
				matrix[i][j].cell_updated.connect(matrix[i-1][j].on_update)
				matrix[i][j].collapse.connect(matrix[i-1][j].on_collapse)
			if i < size - 1:
				matrix[i][j].cell_updated.connect(matrix[i+1][j].on_update)
				matrix[i][j].collapse.connect(matrix[i+1][j].on_collapse)
			if j > 0:
				matrix[i][j].cell_updated.connect(matrix[i][j-1].on_update)
				matrix[i][j].collapse.connect(matrix[i][j-1].on_collapse)
			if j < size - 1:
				matrix[i][j].cell_updated.connect(matrix[i][j+1].on_update)
				matrix[i][j].collapse.connect(matrix[i][j+1].on_collapse)
