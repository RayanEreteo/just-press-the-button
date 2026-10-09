extends CharacterBody3D

@export_category("Movement Settings")
@export var speed: float = 5.0
@export var mouse_sensitivity: float = 0.003

@export_category("Footstep Settings")
@export var footstep_interval: float = 2.0

# Get the gravity from the project settings to keep synced with physics
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var footstep_distance: float = 0.0

@onready var head: Node3D = $Head
@onready var footstep = $Footstep
@onready var glitch = $CanvasLayer/Glitch

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)

		head.rotate_x(-event.relative.y * mouse_sensitivity)
		head.rotation.x = clamp(
			head.rotation.x,
			deg_to_rad(-89.0),
			deg_to_rad(89.0)
		)


func _physics_process(delta: float) -> void:
	# Handle Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get WASD Input Direction
	var input_dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	var direction: Vector3 = (
		transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	).normalized()

	# Apply Horizontal Velocity
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

	# Footsteps
	handle_footsteps(delta)


func handle_footsteps(delta: float) -> void:
	# Don't make footsteps while airborne
	if not is_on_floor():
		footstep_distance = 0.0
		return

	# Get horizontal movement speed
	var horizontal_velocity := Vector2(velocity.x, velocity.z)
	var current_speed := horizontal_velocity.length()

	# Player isn't moving
	if current_speed < 0.1:
		footstep_distance = 0.0
		return

	# Add distance traveled this frame
	footstep_distance += current_speed * delta

	# Time for another footstep
	if footstep_distance >= footstep_interval:
		footstep_distance = 0.0

		footstep.play()

func activate_glitch(status: bool):
	glitch.visible = status
