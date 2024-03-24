class_name DefaultState extends State

@export var root: Node
@export var material: MaterialBuffer

func enter():
	if material:
		material.assign(null)
