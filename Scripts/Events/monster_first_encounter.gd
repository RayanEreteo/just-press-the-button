extends Area3D

@onready var breaklight = $"../BreakingLight"
@onready var breaklight2 = $"../OmniLight3D3"
@onready var monnster = $"../MonsterBreathing"
@onready var lightoff = $"../LightsOff"
@onready var walk = $"../Walk"

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		breaklight.queue_free()
		breaklight2.queue_free()
		lightoff.play()
		await get_tree().create_timer(2).timeout
		walk.play()
		await get_tree().create_timer(2.50).timeout
		monnster.play(5.40)
		await get_tree().create_timer(1.50*3).timeout
		walk.stop()
