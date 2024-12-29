extends CharacterBody2D

@export var stats: PlayerStats
@export var flip: Node2D
var _input = Vector2.ZERO

func _ready():
	add_to_group("Player")

func _process(delta):
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	_input = Vector2(x, y)
	
	if get_global_mouse_position().x > global_position.x:
		flip.scale.x = 1
	elif get_global_mouse_position().x < global_position.x:
		flip.scale.x = -1

func _physics_process(delta):
	var speed = stats.move_speed
	if Input.is_action_pressed("noclip"):
		speed *= 10
	move_and_collide(_input * speed)


func _on_death(area):
	set_process(false)
	set_physics_process(false)
	await get_tree().create_timer(1.0).timeout
	set_process(true)
	set_physics_process(true)
	

func _on_hurt_box_on_hit(area):
	pass
	#print("Was hit")
