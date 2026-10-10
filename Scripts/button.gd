extends Area3D

@onready var confirmed: CanvasLayer = get_node("/root/ButtonConfirmed")

var canPress = false

@export var targetLVL: String

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		canPress = true


func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		canPress = false

func _process(_delta: float) -> void:
	if canPress:
		if Input.is_action_just_pressed("action"):
			get_tree().change_scene_to_file(targetLVL)
			confirmed.visible = true
