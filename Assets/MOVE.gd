extends Node2D

@export var inventory: InventoryComponent
@export var radius = 150
@export var repel_force = 150
@export var explode_force = 2500
@export var area: Area2D
@export var selector: CursorSelect
@export var property_options = ["DefaultState", "MetalState"]

var _shape
var _shape_rid
var _property_index := 0

var _is_repulsing = false
var _selected: Array[Entity]

func _ready():
	selector.areas_selected.connect(_on_selection)

func _on_selection(areas):
	# unselect current
	for entity in _selected:
		entity.on_entity_deselect.emit()
	
	_selected = []
	for a in areas:
		var parent = a.get_parent()
		if parent is Entity:
			(parent as Entity).on_entity_select.emit(a)
			_selected.append(parent)

func _input(event):
	if event is InputEventKey:
		if event.pressed and not event.echo:
			match event.keycode:
				KEY_Q:
					_property_index -= 1
					if _property_index < 0:
						_property_index = len(property_options) - 1
				KEY_E:
					_property_index += 1
					if _property_index >= len(property_options):
						_property_index = 0
				KEY_R:
					if Inventory.get_item("Throwing Axe"):
						var axe = load("res://Assets/ThrowingAxe.tscn").instantiate()
						Game.get_world().add_child(axe)
						axe.get_node("ProjectileComponent").direction = (get_global_mouse_position() - Game.get_player().global_position).normalized()
						axe.global_position = Game.get_player().global_position
				KEY_T:
					if Inventory.get_item("Throwing Sword"):
						var sword = load("res://Assets/ThrowingSword.tscn").instantiate()
						Game.get_world().add_child(sword)
						var dir = (get_global_mouse_position() - Game.get_player().global_position).normalized()
						sword.get_node("ProjectileComponent").direction = dir
						sword.rotation = dir.angle()
						sword.global_position = Game.get_player().global_position
				KEY_1:
					_is_repulsing = !_is_repulsing
				KEY_2:
					for a in _selected:
						var vel = a.get_node("VelocityComponent")
						explode(get_global_mouse_position(), explode_force, true, vel)
				KEY_4:
					print("Applying material " + str(property_options[_property_index]))
					for a in _selected:
						
						var machine = a.get_node("PropertyStateMachine")
						if machine:
							(machine as StateMachine).transition(property_options[_property_index])
						
						a.on_entity_deselect.emit()




func _physics_process(delta):
	if _is_repulsing:
		REPEL(global_position, radius / 4, repel_force)
	
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

	MAKE_CIRCLE_SHAPE(radius)
	
	area.global_position = global_pos
	area.force_update_transform()
	var colls = area.get_overlapping_areas()
	for a in colls:
		var vel = a.get_parent().get_node("VelocityComponent")
		var health = a.get_parent().get_node("HealthComponent")
		if vel:
			_do_repel(force, distance_magnitude, vel, health)

func explode(at: Vector2, force, distance_magnitude, target: VelocityComponent):
	var dir = target.global_position - at
	var magnitude = force
	if distance_magnitude:
		var amount =  1 - (dir.length() / radius)
		magnitude = amount * force
	target.add_force( magnitude * dir.normalized() )

func _do_repel(force, distance_magnitude, vel: VelocityComponent, health: HealthComponent=null):
	if vel:
		var dir = vel.global_position - area.global_position
		var magnitude = force
		if distance_magnitude:
			var amount =  1 - (dir.length() / radius)
			magnitude = amount * force
		vel.add_force( magnitude * dir.normalized() )

	
