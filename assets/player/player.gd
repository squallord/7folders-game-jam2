extends Node

@export var start_position : Vector2
@export var direction : Vector2 = Vector2.UP

var _head : BodyPart
var _body = []

func _ready():
	_head = Head.new(start_position)
	print("Player scene instantiated!")
	pass

func _process(delta):
	if Input.is_action_just_pressed("up"):
		direction = Vector2.UP
	if Input.is_action_just_pressed("down"):
		direction = Vector2.DOWN
	if Input.is_action_just_pressed("left"):
		direction = Vector2.LEFT
	if Input.is_action_just_pressed("right"):
		direction = Vector2.RIGHT

class BodyPart:
	var position: Vector2

	func _init(position: Vector2):
		self.position = position
		
class Head extends BodyPart:
	func _init(position: Vector2):
		super._init(position)
