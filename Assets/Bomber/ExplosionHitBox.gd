extends HitBox


func _ready():
	visible = false

func explode():
	visible = true
	trigger()
