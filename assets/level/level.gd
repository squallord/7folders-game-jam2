extends Node

@export var tile_matrix_width : int = 25
@export var tile_matrix_height : int = 50
@export var player_start_position : Vector2 = Vector2(20, 40)
@export var update_interval : float = 0.5  # Update every 2 seconds
@export var game_over_timeout : float = 1.0

const _tile_scene = preload("res://assets/tile/tile.tscn")
const _player_scene = preload("res://assets/player/player.tscn")
const _fruit_scene = preload("res://assets/fruit/fruit.tscn")

var _tile_matrix = []
var _player
var _fruit
var _counter : float = 0.0
var _free_positions = []
var _score = 0
var _game_over : bool = false

func _ready():
	var tile_offset = 16
	for i in range(tile_matrix_height):
		for j in range(tile_matrix_width):
			var tile = _tile_scene.instantiate()
			tile.position += Vector2(tile.position.x + tile_offset * j, tile.position.y + tile_offset * i)
			self.add_child(tile)
			_tile_matrix.append(tile)
	
	_player = _player_scene.instantiate()
	self.add_child(_player)
	reset_game()

func reset_game():
	_player._start_position = player_start_position
	_draw_player()
	_calculate_free_positions()
	_generate_fruit()

func _calculate_free_positions():
	if !_free_positions.is_empty():
		_free_positions = []
	for i in range(_tile_matrix.size()):
		_free_positions.append(i)
	for bp in _player.body:
		_free_positions.erase(_get_tile_position(bp.position))

func _generate_fruit():
	var random_position_index = randi() % _free_positions.size()
	_fruit = _fruit_scene.instantiate()
	_fruit.tile_position = _free_positions[random_position_index]
	self.add_child(_fruit)

func _compute_position(x : int, y : int):
	return x + y * tile_matrix_width

func _get_tile_position(x, y = null):
	if y == null and x is Vector2: # then x must be a Vector2
		return _compute_position(x.x, x.y)
	elif y != null and y is int and x is int:         # then both x and y must be int
		return _compute_position(x, y)
	else:
		push_error("expected x as vector and y as null or both x an y as int")

func _get_vector_from_tile(tile_position : int):
	var y = int(tile_position) / int(tile_matrix_width)
	var x = tile_position - y * tile_matrix_width
	return Vector2(x, y)

func _draw_level():
	for tile in _tile_matrix:
		tile.change_color(tile.color)

func _draw_player():
	for bp in _player.body:
		_tile_matrix[_get_tile_position(bp.position)].change_color(_player.color)

func _draw_fruit():
	if _fruit != null:
		_tile_matrix[_fruit.tile_position].change_color(_fruit.color)

func _draw():
	if not _game_over:
		_draw_level()
		_draw_fruit()
		_draw_player()

func _check_fruit_collision():
	if _player.get_head().position == _get_vector_from_tile(_fruit.tile_position):
		_score += 1
		_calculate_free_positions()
		_generate_fruit()
		_player.grow()
		print("snake ate a fruit!")
		print("score: " + str(_score))

func _check_self_collision():
	for i in range(1, _player.body.size()):
		if _player.get_head().position == _player.body[i].position:
			_game_over = true
			print("snake collided with itself!")

func _check_level_boundary_collision():
	var position = _player.get_head().position
	if position.x > tile_matrix_width - 1 or position.x < 0 or position.y > tile_matrix_height - 1 or position.y < 0:
		_game_over = true
		print("snake collided with the level boundaries!")

func _check_collisions():
	_check_fruit_collision()
	_check_self_collision()
	_check_level_boundary_collision()

func _update():
	if not _game_over:
		_player.update()
		_check_collisions()
	else:
		await get_tree().create_timer(game_over_timeout).timeout
		get_tree().change_scene_to_file("res://assets/game_over/game_over.tscn")

func _process(delta):
	_counter += delta
	if _counter >= update_interval:
		_update()
		_draw()
		_counter = 0.0
