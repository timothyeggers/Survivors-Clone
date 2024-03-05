class_name VelocityComponent extends Node2D

@export var speed = 32

var _linear_velocity := Vector2.ZERO
var _speed = speed

# if we haven't moved (due to body blocking), then increment this.
var _time_since_change = 0.0

func get_time_since_move():
	return _time_since_change

func set_velocity(velocity: Vector2):
	_linear_velocity = velocity
	_time_since_change = 0

func add_velocity(velocity: Vector2):
	_linear_velocity += velocity
	_time_since_change = 0

func get_direction():
	return _linear_velocity.normalized()

func get_velocity():
	return _linear_velocity

func _process(delta):
	_time_since_change += delta

