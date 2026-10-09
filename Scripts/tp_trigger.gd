extends Area3D

@export var player: CharacterBody3D = null
@export var destination: Vector3
@onready var sfx = $"../Glitch"

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player.position = destination
		player.activate_glitch(true)
		sfx.play(1.63)
		await get_tree().create_timer(0.4).timeout
		player.activate_glitch(false)
