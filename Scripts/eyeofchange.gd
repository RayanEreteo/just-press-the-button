extends Area3D

@export var disapearingWall: CSGBox3D
@export var appearingWall: CSGBox3D

var status = false
var debounce = true

func _on_area_entered(area: Area3D) -> void:
	if area.name == "FlashTrigger" && debounce:
		debounce = false
		status = !status
		switchWalls()
		await get_tree().create_timer(0.40).timeout
		debounce = true

func switchWalls():
	if status == true:
		disapearingWall.visible = false
		appearingWall.visible = true
	else :
		disapearingWall.visible = true
		appearingWall.visible = false
