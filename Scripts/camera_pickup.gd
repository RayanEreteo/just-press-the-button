extends Area3D

# Vitesse de rotation en radians par seconde sur chaque axe (X, Y, Z)
@export var rotation_speed: Vector3 = Vector3(0, 2.0, 0)
@onready var tuto = $"../Label"
var canPress = false

func _process(delta: float) -> void:
	# Fait tourner le noeud sur ses axes à chaque frame
	rotate_object_local(rotation_speed.normalized(), rotation_speed.length() * delta)
	if canPress:
		if Input.is_action_just_pressed("action"):
			Globals.canFlash = true
			tuto.visible = true
			visible = false
			await get_tree().create_timer(3).timeout
			tuto.visible = false
			queue_free()

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		canPress = true

func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		canPress = false
