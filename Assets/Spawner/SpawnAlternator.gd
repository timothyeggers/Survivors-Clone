extends Node
"""
Any children  of type Spawner will flip X/Y axis for spawning randomly.
This will also handle enemy swapping, etc, eventually.
"""

## The timer cooldown for spawning
@export var timer: Timer

var _spawners = []
var _index = 0

func _ready():
	var childs = get_children()
	for c in childs:
		if c is Spawner:
			_spawners.append(c)
	timer.timeout.connect(_on_timeout)

func _on_timeout():
	if Game.can_spawn_more():
		if _index < _spawners.size():
			var spawner = _spawners[_index] as Spawner
			spawner.spawn_axis()
			_index += 1
		else:
			_index = 0
