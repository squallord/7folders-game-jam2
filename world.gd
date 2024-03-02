extends Node2D

const _level_scene = preload("res://assets/level/level.tscn")

var _level

func _ready():
	_level = _level_scene.instantiate()
	self.add_child(_level)

func _process(delta):
	pass
