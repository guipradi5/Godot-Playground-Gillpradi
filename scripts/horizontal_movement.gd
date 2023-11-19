extends Node3D

@export var SPEED = 0.3
@export var focus = false
@export var focusOffset = Vector3(0,0,0)
@onready var focusObjective = $"../player"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !focus:
		var input_dir = Input.get_vector("left", "right", "forward", "backwards")
		var new_vector = (self.position + Vector3(input_dir.x, 0, input_dir.y)).normalized()
		self.position = self.position + Vector3(input_dir.x, 0, input_dir.y) * SPEED
	else:
		self.position.x = focusObjective.position.x + focusOffset.x
		self.position.z = focusObjective.position.z + focusOffset.z
