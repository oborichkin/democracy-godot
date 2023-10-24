extends Area2D

var x: int
var y: int
var _index: int = 0
var occupied: bool = false
var last_update: int = 0
var grid: Node

@onready var size: float = $sprite.texture.get_width()

signal cell_updated(inc)
signal collapse()


func init(i: int, j: int, parent: Node) -> void:
	grid = parent
	position = Vector2(i * size + size / 2, j * size + size / 2)
	name = "cell %d,%d" % [i, j]
	x = i
	y = j


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed() \
	and not occupied:
		occupy()


func occupy() -> void:
	occupied = true
	set_idx(_index+1)
	if _index < 3:
		emit_signal("cell_updated", 1)



func deoccupy() -> void:
	occupied = false
	set_idx(_index-1)
	emit_signal("cell_updated", -1)


func on_update(inc) -> void:
	set_idx(_index+inc)


func on_collapse() -> void:
	if occupied:
		deoccupy()
		emit_signal("collapse")


func set_idx(value):
	_index = value
	$collider/text.set_text(str(_index))
	if value >= 3:
		on_collapse()
