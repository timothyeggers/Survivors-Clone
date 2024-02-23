class_name TransformNode2D
extends Resource

signal on_transform(from)
signal on_transform_to(to)

@export var inherit_position = true
@export var inherit_rotation = true
@export var inherit_scale = Vector2.ONE
@export var target: PackedScene

func transform(from, attach_to: Node2D = Game.get_world()):
	if target == null:
		return
	
	var to = target.instantiate()
	
	if inherit_position:
		to.global_position = from.global_position
	if inherit_rotation:
		to.rotation = from.rotation
	if inherit_scale.x != 0:
		to.scale.x = from.scale.x
	if inherit_scale.y != 0:
		to.scale.y = from.scale.y
	
	attach_to.add_child(to)

