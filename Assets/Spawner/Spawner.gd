class_name Spawner
extends Node2D

## The node being spawned
@export var node: PackedScene

## Minimum amount to spawn
@export_range(1, 100, 1, "or_greater")  var min_amount = 1
## Maximum amount to spawn
@export_range(1, 100, 1, "or_greater")  var max_amount = 5
## The random range to position around spawn origin
@export_range(0, 10, 1, "or_greater") var spread = 5

## Mostly spawners are on an X/Y axis of the screen.
## XY will be randomized between X/Y when spawn is called.
@export_enum("X", "Y", "XY") var axis = "XY"


func spawn(g_position: Vector2):
	var temp = node.instantiate()
	temp.global_position = g_position
	Game.get_world().add_child(temp)

func spawn_axis():
	var half_height = Game.SCREEN_HEIGHT / 2
	var half_width = Game.SCREEN_WIDTH / 2
	
	var player_position = Game.get_player().global_position
	var spawn_count = randi_range(min_amount, max_amount)
	var axis = axis
	
	if self.axis == "XY":
		axis = "Y" if randf() > 0.5 else "X"
	
	for i in spawn_count:
		var min_x = half_width * sign(randf_range(-1, 1))
		var min_y = half_height * sign(randf_range(-1, 1))
		
		# set to min screen height and width
		var x = min_x
		var y = min_y
		
		if axis == "X": 
			x = randf_range(-half_width, half_width)
			y *= randf_range(1.5, spread)
		
		if axis == "Y": 
			y = randf_range(-half_height, half_height)
			x *= randf_range(1.5, spread)
		
		#  offset so it's around player
		y += player_position.y
		x += player_position.x
		
		spawn(Vector2(x,y))


func spawn_circle(position: Vector2, radius: float = spread):	
	var spawn_count = randi_range(min_amount, max_amount)
	
	for i in spawn_count:
		var temp = node.instantiate()
		
		# set to min screen height and width
		var x =  position.x + randf_range(-radius, radius)
		var y =  position.y + randf_range(-radius, radius)
		
		temp.global_position = Vector2(x,y)
		Game.get_world().add_child(temp)
		Game.emit_signal("enemy_spawned", temp)

