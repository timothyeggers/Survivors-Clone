class_name WaterState extends State

const WATER_SHADER = preload("res://Assets/Water.gdshader")

@export var root: Node
@export var material: MaterialBuffer
@export var hurtbox: Area2D

func enter():
	if material:
		var water = ShaderMaterial.new()
		water.shader = WATER_SHADER
		material.assign(water)
	
	root.add_to_group("Water")

func exit():
	root.remove_from_group("Water")
	
