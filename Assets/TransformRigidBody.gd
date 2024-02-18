class_name TransformRigidBody
extends TransformNode2D

@export var inherit_velocity = true

func transform(from: RigidBody2D, to=target.instantiate(), attach_to=Game.get_world()):
	to = to as RigidBody2D
	
	if inherit_velocity:
		inherit_velocity = from.linear_velocity
		to.linear_velocity = inherit_velocity
	super.transform(from, to, attach_to)
