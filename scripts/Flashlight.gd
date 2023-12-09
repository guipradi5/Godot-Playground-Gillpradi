extends Node3D

@export var isOn:bool = false:
	set(value):
		isOn = value
@export var flashlightAction = ''
@onready var light = %Light

# Called when the node enters the scene tree for the first time.
func _ready():
	if isOn:
		light.show()
	else:
		light.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed(flashlightAction):
		isOn = !isOn
	
	if isOn && !light.is_visible_in_tree():
		light.show()
	else: if !isOn && light.is_visible_in_tree():
		light.hide()
