extends Timer

# we need to clean this up, but this is a temporary way of spawning attacks.

@export var projectile_spawner: Spawner

const GLOBAL_CD = 0.2

func _ready():
	timeout.connect(_spawn)

func _spawn():
	print("Thing")
	projectile_spawner.spawn(get_parent().global_position)
	
