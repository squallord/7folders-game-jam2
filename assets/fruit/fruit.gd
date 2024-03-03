extends Node2D

@export var color : Color = Color.ORANGE_RED
@export var alpha_speed : float = 1.0
@export var transition_duration : float = 1.0  # Duration of the transition (in seconds)

var tile_base_color : Color = Color(.2, .2, .2, 1)

var tile_position : int
var vector_position : Vector2 # same as tile, but in vector coordinates
var _elapsed_time : float = 0.0

func _ready():
	pass

func _process(delta):
	_elapsed_time += delta
	
	# Calculate the interpolation factor (0 to 1)
	var t = clamp(_elapsed_time / transition_duration, 0.0, 1.0)
	
	# Interpolate the color channels
	color = color.lerp(tile_base_color, t)
	if color.is_equal_approx(tile_base_color):
		color = Color.ORANGE_RED
		_elapsed_time = 0.0
