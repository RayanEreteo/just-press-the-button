extends Node3D

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 1, 2.0)
	await get_tree().create_timer(5).timeout
	get_tree().quit()
