extends Area3D

@onready var label: Label = $"../CanvasLayer/Inspect"
@onready var confirmed: CanvasLayer = get_node("/root/ButtonConfirmed")

var canPress = false

@export var targetLVL: PackedScene = null

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		label.visible = true
		canPress = true


func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		label.visible = false
		canPress = false

func _process(_delta: float) -> void:
	if canPress:
		if Input.is_action_just_pressed("action"):
			get_tree().change_scene_to_packed(targetLVL)
			confirmed.visible = true
