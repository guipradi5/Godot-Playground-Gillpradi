extends Node
class_name Interactable

signal interacted(body)
var isPlayerColliding = false
var playerBody = false
@export var promptAction = "interact"

func _process(delta):
	if Input.is_action_just_pressed(promptAction) && isPlayerColliding:
		interact(playerBody)

func interact(body):
	emit_signal("interacted", body)

func _on_enterBody(body):
	if body is Player:
		isPlayerColliding = true
		playerBody = body
		
func _on_exitBody(body):
	if body is Player && isPlayerColliding:
		isPlayerColliding = false
		playerBody = null
