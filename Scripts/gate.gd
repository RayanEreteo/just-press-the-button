extends CSGCombiner3D

@export var btn_activated = 0
@onready var scheme: AudioStreamPlayer = $"../../AudioStreamPlayer"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func upd_state() -> void:
	if btn_activated == 3:
		scheme.play()
		position.y = 5
