extends Node

@export var activated = false
@export var next: Area3D
@export var pillar: Area3D
@onready var player = $"../../Player"
var red = preload("res://Textures/red.tres")
var green = preload("res://Textures/green.tres")
var canPress = false
@onready var button: CSGCylinder3D = $StaticBody3D/Button
@onready var audio_stream_player: AudioStreamPlayer = $"../../AudioStreamPlayer"
@onready var rumb_le: AudioStreamPlayer = $"../../Rumb;le"
@onready var world_environment: WorldEnvironment = $"../../WorldEnvironment"
@onready var static_: AudioStreamPlayer = $"../../Static"

var baseSkyColor = Color(0.518, 0.553, 0.608)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !activated:
		button.material_override = red

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canPress && activated:
		if Input.is_action_just_pressed("action"):
			button.material_override = red
			activated = false
			audio_stream_player.play()
			var tween = create_tween()
			tween.tween_property(pillar, "position:y", -40, 4.0)
			rumb_le.play()
			await get_tree().create_timer(4).timeout
			if next:
				var skytweeen = create_tween()
				skytweeen.tween_property(
					world_environment.environment, 
					"fog_light_color", 
					Color.RED, 
					2.0
					)
				skytweeen.tween_property(world_environment.environment, "fog_light_color", baseSkyColor, 2.0)
				await get_tree().create_timer(4).timeout
				next.activated = true
				next.get_child(1).get_child(1).material_override = green
			else :
				player.get_child(1).get_child(0).get_child(1).visible = true
				static_.play()
				player.speed = 0
				Globals.canFlash = false
				await get_tree().create_timer(8).timeout
				get_tree().change_scene_to_file("res://Scenes/Levels/final_screen.tscn")

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		canPress = true

func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		canPress = false
