class_name Player
extends CharacterBody3D

@onready var visuals = $visuals
@onready var camera_mount = $camera_mount
@onready var camera = $camera_mount/Camera3D
@onready var animation_player = $visuals/mixamo_base/AnimationPlayer

@export var SPEED = 5.0
@export var CAN_RUN = true
@export var RUN_SPEED = 5.0
@export var CAN_DASH = false
@export var DASH_SPEED = 5.0
@export var DASH_TIME = 0.3
@export var JUMP_VELOCITY = 4.5
@export var LOCK_CAMERA = false
@export var LOCK_CHARACTER = false

@export var sens_horizontal = 0.5
@export var sens_vertical = 0.5

@export var cameraRotationTop = 90
@export var cameraRotationBottom = -90

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion && !LOCK_CAMERA:
		rotate_y(deg_to_rad(-event.relative.x*sens_horizontal))
		visuals.rotate_y(deg_to_rad(event.relative.x*sens_horizontal))
		var finalCameraRotation = camera_mount.rotation_degrees+camera.rotation_degrees
		if(finalCameraRotation.x >= cameraRotationBottom && finalCameraRotation.x <= cameraRotationTop):
			camera_mount.rotate_x(deg_to_rad(-event.relative.y*sens_vertical))


func _physics_process(delta):
	
	#Apply camera restrictions
	var finalCameraRotation = camera_mount.rotation_degrees+camera.rotation_degrees
	if finalCameraRotation.x < cameraRotationBottom:
		camera_mount.rotation_degrees.x = cameraRotationBottom - camera.rotation_degrees.x
	else: if finalCameraRotation.x > cameraRotationTop:
		camera_mount.rotation_degrees.x = cameraRotationTop - camera.rotation_degrees.x
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
			
		visuals.look_at(position + direction)
		
		#Speed
		var usedVel = SPEED
		if CAN_RUN && Input.is_action_pressed("run"):
			usedVel = RUN_SPEED
			if animation_player.current_animation != "running":
				animation_player.play("running")
		else: if CAN_DASH && Input.is_action_just_pressed("dash"):
			usedVel = DASH_SPEED
		else:
			if animation_player.current_animation != "walking":
				animation_player.play("walking")
		velocity.x = direction.x * usedVel
		velocity.z = direction.z * usedVel
	else:
		if animation_player.current_animation != "idle":
			animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

func lockCharacter(state):
	LOCK_CHARACTER = state
