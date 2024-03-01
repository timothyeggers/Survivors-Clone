class_name Spawner
extends Node2D

@export var node: PackedScene

@export_range(1, 100, 1, "or_greater")  var spawn_count_min = 1
@export_range(1, 100, 1, "or_greater")  var spawn_count_max = 5
@export_range(1, 10, 1, "or_greater") var spawn_spread = 5

@export_enum("X", "Y", "XY") var spawn_axis = "XY"

func spawn():
	if not node or not visible:
		return
	
	var half_height = Game.screen_height / 2
	var half_width = Game.screen_width / 2
	
	var player_position = Game.get_player().global_position
	
	var spawn_count = randi_range(spawn_count_min, spawn_count_max)
	
	var axis = spawn_axis
	
	if spawn_axis == "XY":
		axis = "Y" if randf() > 0.5 else "X"
	
	for i in spawn_count:
		var temp = node.instantiate()
		
		var min_x = half_width * sign(randf_range(-1, 1))
		var min_y = half_height * sign(randf_range(-1, 1))
		
		# set to min screen height and width
		var x = min_x
		var y = min_y
		
		if axis == "X": 
			x = randf_range(-half_width, half_width)
			y *= randf_range(1.5, spawn_spread)
		
		if axis == "Y": 
			y = randf_range(-half_height, half_height)
			x *= randf_range(1.5, spawn_spread)
		
		#  offset so it's around player
		y += player_position.y
		x += player_position.x
		
		temp.global_position = Vector2(x,y)
		Game.get_world().add_child(temp)
		Game.emit_signal("enemy_spawned", temp)
	

