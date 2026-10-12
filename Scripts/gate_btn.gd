extends Area3D

var canPress = false
var activated = false

var greenMat = preload("res://Textures/green.tres")

@onready var gate = $"../../NavigationRegion3D/Gate"
@onready var click = $"../Click"
@onready var led = $"../StatusLED"
@onready var omni_light_3d: OmniLight3D = $"../StatusLED/OmniLight3D"

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
			gate.upd_state()
			led.material_override = greenMat
			click.play()
			activated = true
			omni_light_3d.light_color = Color.GREEN
