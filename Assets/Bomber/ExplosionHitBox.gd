extends Area2D


func _ready():
	$AnimationPlayer.play("explode")
	$AnimationPlayer.animation_finished(name).connect(explode)

func explode():
	var areas = get_overlapping_areas()
	for area in areas:
		area.emit_signal("area_entered", self)
