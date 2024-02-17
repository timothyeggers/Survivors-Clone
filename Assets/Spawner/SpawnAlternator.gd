extends Node

var spawners = []
var index = 0

func _ready():
	var childs = get_children()
	for c in childs:
		if c is Spawner:
			spawners.append(c)
	$Timer.timeout.connect(_on_timeout)

func _on_timeout():
	if Game.can_spawn_more():
		if index < spawners.size():
			var spawner = spawners[index] as Spawner
			spawner.spawn()
			index += 1
		else:
			index = 0
