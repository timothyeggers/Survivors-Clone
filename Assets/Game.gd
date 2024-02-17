extends Node

signal enemy_spawned(node)
signal exp_gained(amount)

const knockback_duration = 0.2

const screen_width = 1152
const screen_height = 648

var max_enemies = 20
var experience = 0.0 : set = _add_experience, get = _get_experience

var _player: Node2D


func _ready():
	var player = Node2D.new()
	player.add_to_group("Player Empty")
	player.name = "Player Empty"
	
	var level = Node2D.new()
	level.add_to_group("Level Empty")
	level.name = "Level Empty"
	
	var root = get_tree().root.get_child(0)
	root.add_child(level)
	level.add_child(player)

func _add_experience(value):
	experience += value
	emit_signal("exp_gained", value)
	
func _get_experience():
	return experience

func look_at():
	return get_viewport().get_camera_2d().get_global_mouse_position()

func color_ratio(percent: float) -> Color:
	return Color.WHITE
	if percent < 0.45:
		return Color.WHITE
	if percent < 0.55:
		return Color.ORANGE
	if percent < 0.8:
		return Color.ORANGE_RED
	return Color.RED

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

func get_level() -> Node2D:
	var level = get_tree().get_first_node_in_group("Level")
	if level:
		return level
	
	var temp = get_tree().get_first_node_in_group("Level Empty")
	return temp

func can_spawn_more() -> bool:
	return get_tree().get_nodes_in_group("Enemy").size() < max_enemies
