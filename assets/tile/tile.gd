extends Node2D

@export var scale_factor : float = 0.12
var color : Color = Color(.2, .2, .2, 1)

func _ready():
	$Sprite2D.scale = Vector2($Sprite2D.scale.x * scale_factor, $Sprite2D.scale.y * scale_factor)
	change_color(color)

func change_color(color : Color):
	$Sprite2D.modulate = color

func _process(delta):
	pass
