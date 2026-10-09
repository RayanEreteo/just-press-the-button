extends Area3D

var debounce = true

@onready var wall = $"../MovingWall"
@onready var bass = $"../Bass"
@onready var player = $"../Player"
@onready var speciallight = $"../SpecialLight"
@onready var sfx = $"../Glitch"

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player" && debounce:
		debounce = false
		var tween = get_tree().create_tween()
		tween.tween_property(wall, "position:z", 48.898, 1)
		tween.play()
		bass.play()
		speciallight.visible = true

func _on_tp_trigger_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player.position = Vector3(-12, 1.546, 7.286)
		player.activate_glitch(true)
		sfx.play(1.63)
		await get_tree().create_timer(0.4).timeout
		player.activate_glitch(false)
