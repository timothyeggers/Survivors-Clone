extends ProjectileComponent 

func _ready():
	var animation = get_node("AnimationPlayer")
	animation.play("swing")
	animation.look_at(Game.get_world().get_global_mouse_position())
