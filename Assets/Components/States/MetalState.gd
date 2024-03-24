class_name MetalState extends State

const METAL_SHADER = preload("res://Assets/Metal.gdshader")

@export var root: Node
@export var velocity: VelocityComponent
@export var material: MaterialBuffer

# values when state is entered, used for reverting.
var _drag = 1.0
var _mass = 1.0

func enter():
	_drag = velocity.drag
	_mass = velocity.mass
	
	velocity.drag /= 4.0
	velocity.mass *= 4.0
	
	if material:
		var metal = ShaderMaterial.new()
		metal.shader = METAL_SHADER
		material.assign(metal)
	
	root.add_to_group("Metal")

func exit():
	velocity.drag = _drag
	velocity.mass = _mass
	
	root.remove_from_group("Metal")
