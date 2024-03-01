extends Node

signal enemy_spawned(node)
signal exp_gained(amount)
signal level_up(level)

const base_experience = 100
const growth_factor = 1.5

var screen_width = 1152
var screen_height = 648

var experience: get = get_experience

var difficulty = Difficulty.new()

var _player: Node2D
var _level = 1
var _exp: float = get_experience_required(_level)
var _elapsed_time = 0.0

func _process(delta):
	_elapsed_time += delta

func _ready():
	var player = Node2D.new()
	player.add_to_group("Player Empty")
	player.name = "Player Empty"
	
	var world = Node2D.new()
	world.add_to_group("World Empty")
	world.name = "World Empty"
	
	var root = get_tree().root.get_child(0)
	root.add_child(world)
	world.add_child(player)

func get_time_elapsed():
	return _elapsed_time

func add_experience(value):
	_exp += value
	
	while _exp >= get_experience_required(_level + 1):
		_level += 1
		emit_signal("level_up", get_level())
		print( "Experience: " + str(_exp) + " Level: " + str(_level) ) 
	
	emit_signal("exp_gained", value)

func get_experience_required(level: int):
	return base_experience * (growth_factor ** (level - 1))

func get_experience():
	return _exp

func get_level():
	return _level

func get_level_ratio():
	var level_up_diff = get_experience_required(_level + 1) - get_experience_required(_level)
	var level_diff = get_experience_required(_level + 1) - _exp
	var ratio = 1 - (level_diff / level_up_diff)
	return ratio

func look_at():
	return get_viewport().get_camera_2d().get_global_mouse_position()

func get_player() -> Node2D:
	if _player and _player.is_inside_tree(): return _player
	
	_player = get_tree().get_first_node_in_group("Player")
	if _player:
		return _player
	
	var temp = get_tree().get_first_node_in_group("Player Empty")
	return temp

func get_direction_to_player(from: Node2D):
	return from.global_position.direction_to(get_player().global_position)

func get_distance_to_player(from: Node2D):
	return from.global_position.distance_to(get_player().global_position)

func get_world() -> Node2D:
	var world = get_tree().get_first_node_in_group("World")
	if world:
		return world
	
	var temp = get_tree().get_first_node_in_group("World Empty")
	return temp

func can_spawn_more() -> bool:
	return difficulty.can_spawn_more()


func get_enemy_count():
	return get_tree().get_nodes_in_group("Enemy").size()
