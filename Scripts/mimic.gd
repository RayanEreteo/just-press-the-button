extends CharacterBody3D

@onready var mimic: Node3D = $mimic
@onready var anim_player = $mimic/AnimationPlayer
@onready var player: CharacterBody3D = $"../Player"
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

var isChasing = false

func mimic_hide():
	anim_player.play("Armature|Hiding")
	position.y = 1

func mimic_chase():
	anim_player.play("Armature|Walking")

func _ready() -> void:
	mimic_hide()

func _process(_delta: float):
	var dist = position.distance_to(player.position)
	if dist < 7:
		player.activate_glitch(true)
	else :
		player.activate_glitch(false)
	move_to_target()

func move_to_target() -> void:
	navigation_agent_3d.set_target_position(player.position)

func _physics_process(_delta: float) -> void:
	var destination = navigation_agent_3d.get_next_path_position()
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	
	velocity = direction * 2.0
	move_and_slide()
