extends Node2D

var color : Color = Color(.2, .2, .2, 1)

func _ready():
	change_color(color)

func change_color(color : Color):
	$Sprite2D.modulate = color

func _process(delta):
	pass
