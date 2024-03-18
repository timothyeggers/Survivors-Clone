class_name MetalState extends State

const METAL_SHADER = preload("res://Assets/Metal.gdshader")

@export var root: Node
@export var velocity: VelocityComponent
@export var material: Node2D

var _start_material: Material

func enter():
	velocity.drag /= 4.0
	velocity.mass *= 4.0
	
	if material:
		_start_material = material.material
		
		var metal = ShaderMaterial.new()
		metal.shader = METAL_SHADER
		material.material = metal
	
	root.add_to_group("Metal")

func exit():
	material.material = _start_material
	root.remove_from_group("Metal")
