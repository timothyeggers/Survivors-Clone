class_name BoarChargeCooldown extends EntityState

@export var velocity: VelocityComponent
var _cooldown_dt = 0.0

func enter():
	super.enter()
	_cooldown_dt = 0.25
	velocity.set_velocity(Vector2.ZERO)


func process(delta):
	_cooldown_dt -= delta
	if _cooldown_dt < 0:
		emit_signal("transitioned", self, "BoarWalkState")
