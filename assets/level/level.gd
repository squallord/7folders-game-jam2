extends Node

@export var _tile_matrix_width : int = 25
@export var _tile_matrix_height : int = 50

const _tile_scene = preload("res://assets/tile/tile.tscn")
const _player_scene = preload("res://assets/player/player.tscn")

var _tile_matrix = []
var _player

func _ready():
	var tile_offset = 16
	for i in range(_tile_matrix_height):
		for j in range(_tile_matrix_width):
			var tile = _tile_scene.instantiate()
			tile.position += Vector2(tile.position.x + tile_offset * j, tile.position.y + tile_offset * i)
			self.add_child(tile)
			_tile_matrix.append(tile)
	
	_player = _player_scene.instantiate()
	self.add_child(_player)

func _get_tile_position(x : int, y : int):
	pass

func _process(delta):
	pass
