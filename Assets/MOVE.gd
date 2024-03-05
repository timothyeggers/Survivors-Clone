extends Node2D

func _physics_process(delta):
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	var mod = 4 if  Input.is_action_pressed("noclip") else 1
	
	position += Vector2(x, y).normalized() * 64 * delta * mod


func _on_hurt_box_on_hit(area):
	print("HOW")
