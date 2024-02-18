class_name Spawner
extends Node2D

@export var node: PackedScene

@export var spawn_count = 1
@export_range(1, 5)  var spawn_count_range = 1

@export_enum("X", "Y") var spawn_axis = "Y"

func spawn():
	if not node:
		return
	
	var half_height = Game.screen_height / 2
	var half_width = Game.screen_width / 2
	
	var player_position = Game.get_player().global_position
	
	var rand = randi_range(1, spawn_count_range)
	
	for i in rand:
		var temp = node.instantiate()
		var x = half_width * sign(randf_range(-1, 1))
		if spawn_axis == "X": 
			x = randf_range(-half_width, half_width)
		x += player_position.x
		
		var y = half_height * sign(randf_range(-1, 1))
		if spawn_axis == "Y": 
			y = randf_range(-half_height, half_height)
		y += player_position.y
		
		temp.global_position = Vector2(x,y)
		Game.get_world().add_child(temp)
		Game.emit_signal("enemy_spawned", temp)
