class_name EntityWalkState extends EntityState

@export var ai: AIComponent
@export var velocity: VelocityComponent

func physics_process(delta):
	var avoidance_dir := Vector2.ZERO
	
	if ai:
		if ai.get_avoidance_force().length() > velocity.get_velocity().length() + velocity.get_time_since_move():
			velocity.set_velocity(Vector2.ZERO)
		avoidance_dir = ai.get_avoidance_force().normalized()
	
	var direction = root.global_position.direction_to(Game.get_player().global_position)
	var lv = (direction + avoidance_dir) * velocity.speed
	velocity.set_velocity(lv)
	root.global_position += lv * delta
	
	# flip character
	if direction.x > 0:
		root.scale.x = abs(root.scale.x)
	elif direction.x < 0:
		root.scale.x = abs(root.scale.x) * -1
