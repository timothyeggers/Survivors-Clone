class_name TransformRigidBody
extends TransformNode2D

@export var inherit_velocity = true

func transform(from: RigidBody2D, attach_to=Game.get_world()):
	var to = target.instantiate() as RigidBody2D
	
	if inherit_velocity:
		inherit_velocity = from.linear_velocity
		to.linear_velocity = inherit_velocity
	super.transform(from, attach_to)
