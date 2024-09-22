extends Node2D

@export var touchControllerScale : float = 0.5
@export var touchControllerOpacity : float = 0.5

func _ready():
	scale *= touchControllerScale
	modulate.a *= touchControllerOpacity


func _process(delta):
	pass
