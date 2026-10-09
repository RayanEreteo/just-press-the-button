extends Area3D

@export var SFX: AudioStreamPlayer3D

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		SFX.play()
		queue_free()
