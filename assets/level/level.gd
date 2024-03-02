extends Node

@export var tile_matrix_width : int = 25
@export var tile_matrix_height : int = 50
@export var player_start_position : Vector2 = Vector2(20, 40)
@export var update_interval : float = 0.5  # Update every 2 seconds

const _tile_scene = preload("res://assets/tile/tile.tscn")
const _player_scene = preload("res://assets/player/player.tscn")

var _tile_matrix = []
var _player
var _counter : float = 0.0

func _ready():
	var tile_offset = 16
	for i in range(tile_matrix_height):
		for j in range(tile_matrix_width):
			var tile = _tile_scene.instantiate()
			tile.position += Vector2(tile.position.x + tile_offset * j, tile.position.y + tile_offset * i)
			self.add_child(tile)
			_tile_matrix.append(tile)
	
	_player = _player_scene.instantiate()
	_player._start_position = player_start_position
	self.add_child(_player)
	_draw_player()

func _compute_position(x : int, y : int):
	return x + y * tile_matrix_width

func _get_tile_position(x, y = null):
	if y == null and x is Vector2: # then x must be a Vector2
		return _compute_position(x.x, x.y)
	elif y != null and y is int and x is int:         # then both x and y must be int
		return _compute_position(x, y)
	else:
		push_error("expected x as vector and y as null or both x an y as int")

func _draw_level():
	for tile in _tile_matrix:
		tile.change_color(tile.color)

func _draw_player():
	for bp in _player.body:
		_tile_matrix[_get_tile_position(bp.position)].change_color(_player.color)

func _process(delta):
	_counter += delta
	if _counter >= update_interval:
		_draw_level()
		_player.update()
		_draw_player()
		_counter = 0.0
