class_name Player2D
extends CharacterBody2D

@export var SPEED = 300.0
@export var RUN_SPEED = 400.0
@export var LAST_DIRECTION = Vector2(0,-1)
@export var INTERACTION_DISTANCE = 25.0
@export var IS_RUNNING = false
@export var IS_LOCKED = false
@onready var animationPlayer = $visuals/Character/AnimationPlayer
@onready var rayCast = $RayCast2D

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "forward", "backwards")
	IS_RUNNING = Input.is_action_pressed("run")
	if direction && !IS_LOCKED:
		playAnimation(direction)
		velocity = direction * (RUN_SPEED if IS_RUNNING else SPEED)
		LAST_DIRECTION = direction
		rayCast.target_position = direction * INTERACTION_DISTANCE
	else:
		setIdleAnimation()
		velocity = Vector2(0,0)

	move_and_slide()

func animationDirectionName(direction):
	if direction.y > 0.0 && direction.y >= abs(direction.x):
		return 'down'
	if direction.y < 0.0 && direction.y <= -abs(direction.x):
		return 'up'
	if direction.x > 0.0 && direction.x >= abs(direction.y):
		return 'right'
	if direction.x < 0.0 && direction.x <= -abs(direction.y):
		return 'left'

func playAnimation(direction):
	var animationName = ('run_' if IS_RUNNING else 'walk_') + animationDirectionName(direction)
	animationPlayer.play(animationName)

func setIdleAnimation():
	var animationName = 'idle_' + animationDirectionName(LAST_DIRECTION)
	animationPlayer.play(animationName)

func lockCharacter(state):
	IS_LOCKED = state
