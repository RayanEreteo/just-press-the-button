extends Area3D

@onready var mimic: CharacterBody3D = $"../Mimic"
@onready var button_2: Area3D = $"../Button2"

var spawn_pos: Vector3 = Vector3(-9.25, 1.028, 0.08)

const MIMIC = preload("res://Scenes/mimic.tscn")

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		button_2.queue_free()
		var mimicInstance = MIMIC.instantiate()
		get_tree().current_scene.add_child(mimicInstance)
		mimicInstance.global_position = spawn_pos
		queue_free()
