extends Node3D

@export var rotate_per_tick: Vector3

func _process(delta):
	rotation_degrees += rotate_per_tick * delta
