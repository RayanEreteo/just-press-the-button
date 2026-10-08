extends Area3D

@onready var label: Label = $"../CanvasLayer/Inspect"
var canPress = false

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		label.visible = true
		canPress = true


func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		label.visible = false
		canPress = false

func _process(delta: float) -> void:
	if canPress:
		if Input.is_action_just_pressed("action"):
			get_tree().quit()
