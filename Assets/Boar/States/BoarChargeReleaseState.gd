class_name BoarChargeReleaseState extends EntityState

@export var velocity: VelocityComponent
@export var stats := ChargeStats.new()
var _charge_dt = 0.0
var _charge_dir := Vector2.ZERO

func enter():
	super.enter()
	_charge_dt = stats.distance / (stats.speed)
	_charge_dir = Game.get_direction_to_player(root)
	
	var force = _charge_dir * stats.speed
	velocity.add_velocity(force)
	

func physics_process(delta):
	var force = _charge_dir * stats.speed
	velocity.add_velocity(force * delta)
	root.global_position += velocity.get_velocity() * delta
	
	_charge_dt -= delta
	# stop charge run
	if _charge_dt < 0:
		emit_signal("transitioned", self, "BoarWalkState")
