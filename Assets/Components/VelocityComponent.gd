class_name VelocityComponent extends Node2D

@export var mass = 10.0
@export var fric = 0.5

var _linear_velocity := Vector2.ZERO
var _time_since_change = 0.0

func get_time_since_move():
	return _time_since_change
	
func add_force(force: Vector2):
	"""Considers the mass in the calculation of velocity."""
	var dir = force.normalized()
	var acceleration = force.length() / mass
	add_velocity(dir * acceleration)

func add_velocity(velocity: Vector2):
	_linear_velocity += velocity
	_time_since_change = 0

func get_direction():
	return _linear_velocity.normalized()

func get_velocity():
	return _linear_velocity

func get_speed():
	return _linear_velocity.length()

func get_friction(vel):
	return fric * pow(vel.length(), 2)

func _process(delta):
	_time_since_change += delta

func _physics_process(delta):
	print(str(get_speed()) + "  " + str( get_speed() - (get_friction(_linear_velocity) * delta))+ "  " + str( get_friction(_linear_velocity) * delta ) )
	
