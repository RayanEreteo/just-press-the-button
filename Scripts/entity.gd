extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var player: CharacterBody3D = $"../Player"

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

func _on_kill_trigger_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player.death()
