extends Node2D

@export var explosion_radius = 150
@export var explosion_force = 500
@export var area: Area2D

var _shape
var _shape_rid

var repulse = false
var explode = false


func _input(event):
	if Input.is_key_pressed(KEY_1):
		repulse = !repulse
	
	if Input.is_key_pressed(KEY_2):
		explode = true


func _physics_process(delta):
	if repulse:
		REPEL(global_position)
	if explode:
		REPEL(get_global_mouse_position(), true)
		explode = false
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	var mod = 4 if  Input.is_action_pressed("noclip") else 1
	
	position += Vector2(x, y).normalized() * 64 * delta * mod


func _on_hurt_box_on_hit(area):
	print("HOW")


func REPEL(global_pos: Vector2, distance_magnitude := false):
		if not _shape or _shape.radius != explosion_radius:
			_shape = CircleShape2D.new()
			_shape.radius = explosion_radius
			_shape_rid = PhysicsServer2D.circle_shape_create()
			PhysicsServer2D.shape_set_data(_shape_rid, explosion_radius)
			PhysicsServer2D.area_clear_shapes(area.get_rid())
			PhysicsServer2D.area_add_shape(area.get_rid(), _shape_rid)
		area.global_position = global_pos
		var colls = area.get_overlapping_areas()
		for a in colls:
			var vel = a.get_parent().get_node("VelocityComponent")
			var health = a.get_parent().get_node("HealthComponent")
			if vel:
				var dir = vel.global_position - area.global_position
				var magnitude = explosion_force
				if distance_magnitude:
					var amount =  1 - (dir.length() / explosion_radius)
					magnitude = amount * explosion_force
				vel.add_velocity( magnitude * dir.normalized() )
				health.take_damage(10)
