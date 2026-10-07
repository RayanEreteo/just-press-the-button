extends CharacterBody3D

@export_category("Movement Settings")
@export var speed: float = 5.0
@export var mouse_sensitivity: float = 0.003

# Get the gravity from the project settings to keep synced with physics
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head: Node3D = $Head

func _ready() -> void:
	# Lock mouse cursor to game window and hide it
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	# Mouse look implementation
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		# Rotate body left/right (Y axis)
		rotate_y(-event.relative.x * mouse_sensitivity)
		
		# Rotate head up/down (X axis) and clamp angle to prevent flipping
		head.rotate_x(-event.relative.y * mouse_sensitivity)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89.0), deg_to_rad(89.0))

func _physics_process(delta: float) -> void:
	# Handle Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get WASD Input Direction
	var input_dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Apply Horizontal Velocity
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
