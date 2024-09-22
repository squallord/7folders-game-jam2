extends Sprite2D

@onready var parent : Node2D = $".."

var isTouchPressed : bool = false
var currentAction : InputEventAction = null

@export var maxLength = 150
@export var deadZone = 50

func _ready():
	maxLength *= parent.scale.x

func _process(delta):
	if isTouchPressed:
		if get_global_mouse_position().distance_to(parent.global_position) <= maxLength:
			global_position = get_global_mouse_position()
		else:
			var angle = parent.global_position.angle_to_point(get_global_mouse_position())
			global_position = parent.global_position + maxLength * Vector2(cos(angle), sin(angle))
		_calculate_wasd_input()
	else:
		global_position = lerp(global_position, parent.global_position, 0.25)
		_forget_wasd_input()

func _calculate_wasd_input():
	var relative_position = global_position - parent.global_position
	if relative_position.length() >= deadZone:
		if abs(relative_position.x) > abs(relative_position.y):
			if relative_position.x > 0:
				currentAction = _trigger_input_event("right")
			else:
				currentAction = _trigger_input_event("left")
		elif abs(relative_position.x) < abs(relative_position.y):
			if relative_position.y > 0:
				currentAction = _trigger_input_event("down")
			else:
				currentAction = _trigger_input_event("up")

func _forget_wasd_input():
	currentAction = null

func _wasd_input_changed(newActionString : String):
	if currentAction == null:
		return true
	if currentAction.action != newActionString:
		return true
	return false

func _trigger_input_event(key):
	var event = InputEventAction.new()
	event.action = key
	event.pressed = true
	if (_wasd_input_changed(key)):
		Input.parse_input_event(event)
	return event

func _on_button_button_down():
	isTouchPressed = true
	print("touch is pressed!")

func _on_button_button_up():
	isTouchPressed = false
