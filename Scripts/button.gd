extends Area3D

@onready var confirmed: CanvasLayer = get_node("/root/ButtonConfirmed")
@export var inspect: Label
@export var click: AudioStreamPlayer
var canPress = false

@export var isDisabled = false
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
			if isDisabled:
				click.play()
				inspect.visible = true
				await  get_tree().create_timer(2).timeout
				inspect.visible = false
			else :
				get_tree().change_scene_to_file(targetLVL)
				confirmed.visible = true
