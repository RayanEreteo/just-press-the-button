extends Area3D

var canPress = false
var activated = false

var greenMat = preload("res://Textures/green.tres")

@onready var gate = $"../../NavigationRegion3D/Gate"
@onready var click = $"../Click"
@onready var led = $"../StatusLED"

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		canPress = true

func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		canPress = false

func _process(_delta: float) -> void:
	if canPress && !activated:
		if Input.is_action_just_pressed("action"):
			gate.btn_activated += 1
			led.material_override = greenMat
			click.play()
			activated = true
