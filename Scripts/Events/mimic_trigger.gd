extends Area3D

@onready var mimic: CharacterBody3D = $"../Mimic"

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		pass
