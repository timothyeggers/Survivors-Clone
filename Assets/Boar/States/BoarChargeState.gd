class_name BoarChargePrepState extends EntityState

const PREP_TIME = 0.3

@export var velocity: VelocityComponent

var _prep_dt = 0.0

func enter():
	super.enter()
	_prep_dt = PREP_TIME
	#velocity.set_velocity(Vector2.ZERO)

func process(delta):
	# flip the character
	var direction = Game.get_direction_to_player(root)
	# flip character
	if direction.x > 0:
		root.scale.x = abs(root.scale.x)
	elif direction.x < 0:
		root.scale.x = abs(root.scale.x) * -1
	
	_prep_dt -= delta
	if _prep_dt < 0:
		emit_signal("transitioned", self, "BoarChargeReleaseState")

