extends Node2D

@export var radius = 150
@export var repel_force = 150
@export var explode_force = 500
@export var area: Area2D

var _shape
var _shape_rid

var repulse = false
var explode = false


func _input(event):
	if event is InputEventKey:
		if event.pressed and not event.echo:
			match event.keycode:
				KEY_1:
					repulse = !repulse
				KEY_2:
					explode = true
				KEY_4:
					ALTER(get_global_mouse_position(), radius, "MetalState")
					
			




func _physics_process(delta):
	if repulse:
		REPEL(global_position, radius / 4, repel_force)
	if explode:
		REPEL(get_global_mouse_position(), radius, explode_force, true)
		explode = false
	
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	var mod = 4 if  Input.is_action_pressed("noclip") else 1
	
	position += Vector2(x, y).normalized() * 64 * delta * mod


func _on_hurt_box_on_hit(area):
	print("HOW")


func MAKE_CIRCLE_SHAPE(radius: float):
	if _shape:
		PhysicsServer2D.area_clear_shapes(area)
	_shape = CircleShape2D.new()
	_shape_rid = PhysicsServer2D.circle_shape_create()
	PhysicsServer2D.shape_set_data(_shape_rid, radius)
	PhysicsServer2D.area_clear_shapes(area.get_rid())
	PhysicsServer2D.area_add_shape(area.get_rid(), _shape_rid)

func REPEL(global_pos: Vector2, radius: float, force: float,  distance_magnitude := false):
	print("HIT")

	MAKE_CIRCLE_SHAPE(radius)
	
	area.global_position = global_pos
	area.force_update_transform()
	var colls = area.get_overlapping_areas()
	for a in colls:
		var vel = a.get_parent().get_node("VelocityComponent")
		var health = a.get_parent().get_node("HealthComponent")
		if vel:
			var dir = vel.global_position - area.global_position
			var magnitude = force
			if distance_magnitude:
				var amount =  1 - (dir.length() / radius)
				magnitude = amount * force
			vel.add_force( magnitude * dir.normalized() )
			health.take_damage(10)


func ALTER(global_pos: Vector2, radius: float, property: String):
	MAKE_CIRCLE_SHAPE(radius)
	area.global_position = global_pos
	area.force_update_transform()
	var colls = area.get_overlapping_areas()
	for a in colls:
		var prop = a.get_parent().find_child("PropertyStateMachine")
		if prop:
			prop.transition("MetalState")
	
