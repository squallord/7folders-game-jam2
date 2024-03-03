extends Node

@export var direction : Vector2 = Vector2.UP
@export var size : int = 3
@export var color : Color = Color.LIME_GREEN

var body = []

var _start_position : Vector2 = Vector2(20, 40)
var _head : BodyPart

func _ready():
	_head = Head.new(_start_position, direction)
	body.append(_head)
	for i in range(1, size):
		var body_part_position = body[i - 1].position + Vector2.DOWN
		body.append(BodyPart.new(body_part_position, direction))
	print("Player scene instantiated!")
	pass

func get_head():
	return body[0]

func update():
	get_head().direction = direction
	#print("=== UPDATE STARTED ===")
	for i in range(body.size() - 1, 0, -1):
		body[i].direction = body[i - 1].position - body[i].position
		body[i].position += body[i].direction
		#print("i = " + str(i) + " -> position: " + str(body[i].position) + ", direction: " + str(body[i].direction))
	get_head().position += get_head().direction
	#print("=== UPDATE FINISHED ===")
	#print("")
	
func grow(): # append a new body part at the end of the snake
	var end = body.size() - 1
	var body_part_position = body[end - 1].position - body[end - 1].direction
	var body_part_direction = body[end - 1].direction
	body.append(BodyPart.new(body_part_position, body_part_direction))
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
	var direction: Vector2

	func _init(position : Vector2, direction : Vector2):
		self.position = position
		self.direction = direction
		
class Head extends BodyPart:
	func _init(position : Vector2, direction : Vector2):
		super._init(position, direction)
