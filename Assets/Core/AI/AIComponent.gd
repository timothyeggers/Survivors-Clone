class_name AIComponent extends Area2D
"""
AIComponent supplies a suggestion on where to move with a magnitude, based on
the goal of avoiding other AIComponent's
"""

# MAX_COLLS directly determines the accuracy in which avoidance occurs when there's multiple AI's overlapping.
const MAX_COLLS = 32

## Size to check avoidance overlap.  Area2D collision mask is used for checking avoidance.
@export var avoid_radius = 20.0
## Priority forces avoidance navigation every phys frame at the expense of performance.
@export var high_priority = false

var _c_avoid_force := Vector2.ZERO
var _shape: Shape2D
var _shape_rid: RID
var _params: PhysicsShapeQueryParameters2D
var _disabled = false

func set_disabled(value: bool):
	_disabled = value

func get_avoidance_direction() -> Vector2:
	return _c_avoid_force.normalized()

func get_avoidance_force() -> Vector2:
	"""Uncapped, and magnitude is determined by number of overlaps."""
	return _c_avoid_force

func _ready():
	AI.add_ai(self, high_priority)
	
	# create collision shape
	_shape = CircleShape2D.new()
	_shape.radius = avoid_radius
	_shape_rid = PhysicsServer2D.circle_shape_create()
	PhysicsServer2D.shape_set_data(_shape_rid, avoid_radius)
	PhysicsServer2D.area_add_shape(get_rid(), _shape_rid)
	
	# build query for checking avoidance
	_params = PhysicsShapeQueryParameters2D.new()
	_params.shape = _shape
	_params.shape_rid = _shape_rid
	_params.transform = transform
	_params.collision_mask = collision_mask
	_params.collide_with_areas = true


func update_avoidance():
	if _disabled: return
	
	# updates the query parameters to reflect where it is in area space
	_params.transform.origin = global_transform.origin
	
	# checks if the shapes intersect
	var hits = get_world_2d().direct_space_state.intersect_shape(_params, MAX_COLLS)
	
	_c_avoid_force = Vector2.ZERO
	
	for hit in hits:
		var node = hit["collider"]
		var id = get_instance_id()
		var o = node.get_instance_id()
		if node != self:
			var direction = global_position - node.global_position
			var force = 1.0 / direction.length()
			_c_avoid_force += direction * force

