extends Node

var max_enemies = 300

func can_spawn_more(): 
	var enemies = get_tree().get_nodes_in_group("Enemy")
	var in_range = []
	for i in enemies.size():
		if Game.get_distance_to_player(enemies[i]) > Game.screen_height:
			enemies[i].queue_free()
		else:
			in_range.append(enemies[i])
	return in_range.size() < max_enemies

