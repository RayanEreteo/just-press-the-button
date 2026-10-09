extends Area3D

@export var disapearingWall: CSGBox3D
@export var hiddenEye: Sprite3D
@onready var eyesfx = $"../../AudioStreamPlayer"


func _on_area_entered(area: Area3D) -> void:
	if area.name == "FlashTrigger":
		switchWalls()
		get_parent().queue_free()

func switchWalls():
	eyesfx.play()
	disapearingWall.visible = false
	if hiddenEye:
		hiddenEye.visible = true
