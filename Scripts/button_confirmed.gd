extends Label

@onready var audio = $"../AudioStreamPlayer"
func _ready() -> void:
	modulate.a = 0

func _on_button_confirmed_visibility_changed() -> void:
	if get_parent().visible == true:
		play_anim()

func play_anim():
	audio.play()
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1)
	tween.play()
	
	await get_tree().create_timer(2).timeout
	
	var fadeout = create_tween()
	fadeout.tween_property(self, "modulate:a", 0, 1)
	fadeout.play()
	
	await get_tree().create_timer(2).timeout
	
	get_parent().visible = false
