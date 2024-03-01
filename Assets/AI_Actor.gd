class_name AI_Actor extends Area2D

@export var avoid_force = 5.0
@export var avoid_radius = 24

var _c_avoid_force := Vector2.ZERO
var _shape: Shape2D
var _shape_rid: RID
var _params: PhysicsShapeQueryParameters2D

var _visible_notifier: VisibleOnScreenNotifier2D

func is_on_screen() -> bool:
	return _visible_notifier.is_on_screen()

func get_avoidance_force() -> Vector2:
	return _c_avoid_force

func _ready():
	AI.add_actor(self)
	
	# for checking screen status
	_visible_notifier = VisibleOnScreenNotifier2D.new()
	add_child(_visible_notifier)
	
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
	# updates the query parameters to reflect where it is in area space
	_params.transform.origin = global_transform.origin
	
	# checks if the shapes intersect
	var hits = get_world_2d().direct_space_state.intersect_shape(_params, 5)
	
	_c_avoid_force = Vector2.ZERO
	
	for hit in hits:
		var node = hit["collider"]
		var id = get_instance_id()
		var o = node.get_instance_id()
		if node != self:
			var direction = global_position - node.global_position
			var force = 1.0 / direction.length()
			_c_avoid_force += direction * force

	
