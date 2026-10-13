extends Area3D

@export var lvl: String 
@onready var player: CharacterBody3D = $"../../../Player"

var activated = false
@onready var transition: ColorRect = $"../../../Transition"

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		activated = true
		player.speed = 0
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file(lvl)

func _process(delta: float) -> void:
	if activated:
		transition.modulate.a += 0.1
