class_name CursorSelect extends Area2D

signal areas_selected(areas)

@export var ui: Panel

var _start := Vector2.ZERO
var _end := Vector2.ZERO

@onready var _collider = $CollisionShape2D

func _process(delta):
	if Input.is_action_just_pressed("select"):
		_start = get_global_mouse_position()
		if ui: ui.global_position = _start
	
	if Input.is_action_pressed("select"):
		if _start.x < get_global_mouse_position().x:
			scale.x = 1
		if _start.x > get_global_mouse_position().x:
			scale.x = -1
		if _start.y < get_global_mouse_position().y:
			scale.y = 1
		if _start.y > get_global_mouse_position().y:
			scale.y = -1
		
		var size = (get_global_mouse_position() - _start) 
		
		if ui: 
			ui.scale = scale
			ui.size = abs(size)
		_end = get_global_mouse_position()
	
func _physics_process(delta):
	var temp = RectangleShape2D.new()
	temp.size = abs(_end - _start)
	
	_collider.shape = temp
	_collider.scale = scale
	
	global_position = _end - ( temp.size / 2*scale )

	if Input.is_action_just_released("select"):
		var overlaps = get_overlapping_areas()
		emit_signal("areas_selected", overlaps)
		
		if ui: ui.size = Vector2.ZERO
