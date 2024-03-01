class_name Difficulty extends Node

var max_enemies = 500
var _cached_enemy_count = 0

func can_spawn_more():
	var enemies = Game.get_tree().get_nodes_in_group("Enemy")
	var in_range = []
	for i in enemies.size():
		if Game.get_distance_to_player(enemies[i]) > Game.screen_width * 1.5:
			enemies[i].queue_free()
		else:
			in_range.append(enemies[i])
	_cached_enemy_count = in_range.size()
	return in_range.size() < max_enemies

