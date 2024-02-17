extends RigidBody2D

func _ready():
	var animation = get_node("AnimatedSprite2D")
	animation.animation_finished.connect(queue_free)
	
	var dir = global_position.direction_to(Game.get_player().global_position)
	if dir.x > 0: 
		animation.flip_h = false
	elif dir.x < 0:
		animation.flip_h = true
	
	animation.play("death")
