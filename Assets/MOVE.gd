extends Node2D

@export var explosion_radius = 55
@export var explosion_force = 500
@export var area: Area2D

var _shape
var _shape_rid

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if not _shape or _shape.radius != explosion_radius:
			_shape = CircleShape2D.new()
			_shape.radius = explosion_radius
			_shape_rid = PhysicsServer2D.circle_shape_create()
			PhysicsServer2D.shape_set_data(_shape_rid, explosion_radius)
			PhysicsServer2D.area_clear_shapes(area.get_rid())
			PhysicsServer2D.area_add_shape(area.get_rid(), _shape_rid)
		area.global_position = get_global_mouse_position()
		var shiot = area.get_overlapping_areas()
		for a in shiot:
			var shit = a.get_parent().get_node("VelocityComponent")
			var health = a.get_parent().get_node("HealthComponent")
			if shit:
				var dir = shit.global_position - area.global_position
				shit.add_velocity(explosion_force * dir.normalized())
				health.take_damage(10)

func _physics_process(delta):
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	var mod = 4 if  Input.is_action_pressed("noclip") else 1
	
	position += Vector2(x, y).normalized() * 64 * delta * mod


func _on_hurt_box_on_hit(area):
	print("HOW")
