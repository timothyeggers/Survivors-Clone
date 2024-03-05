extends Label

var n_killed = 0

func _ready():
	var enems = get_tree().get_nodes_in_group("Enemy")
	for e in enems:
		_add_hook_to_enemy_death(e)

func _add_hook_to_enemy_death(node):
	node.tree_exiting.connect(_update_ui)

func _update_ui():
	n_killed += 1 
	text = str(n_killed)
