extends Node

var size: int = 5
var cell_texture: Texture2D = load("res://icon.svg")
var cell_size = cell_texture.get_width()
var offset = cell_size / 2
var matrix = []

func _ready() -> void:
	for i in range(size):
		var row = []
		for j in range(size):
			var cell = Sprite2D.new()
			cell.position = Vector2(i * cell_size + offset, j * cell_size + offset)
			cell.texture = load("res://icon.svg")
			cell.name = "cell %d,%d" % [i, j]
			
			row.append(cell)
			add_child(cell)
		matrix.append(row)
	print(matrix)
