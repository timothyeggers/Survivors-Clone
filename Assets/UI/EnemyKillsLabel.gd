extends Label

var n_killed = 0

func _ready():
	Game.enemy_spawned.connect(_add_hook_to_enemy_death)

func _add_hook_to_enemy_death(node):
	node.get_node("HurtBox").connect("on_death", _update_ui)

func _update_ui(area):
	n_killed += 1 
	text = str(n_killed)
