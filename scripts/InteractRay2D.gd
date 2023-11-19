extends RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_exception(owner)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_colliding():
		var object = get_collider()
		var interactableClass = null
		if object.has_node("Interactable"):
			interactableClass = object.get_node("Interactable")
		if interactableClass:
			if Input.is_action_just_pressed(interactableClass.promptAction):
				interactableClass.interact(self)
