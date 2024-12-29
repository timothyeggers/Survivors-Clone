class_name EntityWalkState extends EntityState

@export var ai: AIComponent
@export var velocity: VelocityComponent
@export var move_speed: float

func physics_process(delta):
	var avoid_force = ai.get_avoidance_force() if ai else Vector2.ZERO
	var move_dir = root.global_position.direction_to(Game.get_player().global_position)
	var move_force  = (avoid_force + move_dir) * move_speed
	
	# Finalize move_force this frame, and update entity position.
	velocity.add_velocity(move_force * delta)
	root.global_position += velocity.get_velocity() * delta
	
	# flip character
	if move_dir.x > 0:
		root.scale.x = abs(root.scale.x)
	elif move_dir.x < 0:
		root.scale.x = abs(root.scale.x) * -1
