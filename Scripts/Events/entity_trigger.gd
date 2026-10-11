extends Area3D

const ENTITY = preload("res://Scenes/Entity.tscn")
var spawn_pos = Vector3(-7.89, 1, 4)

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		var entity = ENTITY.instantiate()
		get_tree().current_scene.add_child(entity)
		entity.global_position = spawn_pos
		queue_free()
