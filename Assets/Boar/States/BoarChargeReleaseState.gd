class_name BoarChargeReleaseState extends EntityState

@export var velocity: VelocityComponent
@export var charge_distance = 195.0
@export var charge_speed_mod = 7.0

var _charge_dt = 0.0
var _charge_dir := Vector2.ZERO

func enter():
	super.enter()
	_charge_dt = charge_distance / (velocity.speed * charge_speed_mod)
	_charge_dir = Game.get_direction_to_player(root)
	velocity.set_velocity(_charge_dir * velocity.speed * charge_speed_mod)

func physics_process(delta):
	root.global_position += velocity.get_velocity() * delta
	_charge_dt -= delta
	# stop charge run
	if _charge_dt < 0:
		emit_signal("transitioned", self, "BoarChargeCooldown")
