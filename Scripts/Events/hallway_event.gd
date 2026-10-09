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
