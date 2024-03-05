extends Node2D

@export var proximity_to_spawn = Game.SCREEN_WIDTH * 1.5

var _spawners = []

func _ready():
	var childs = get_children()
	for c in childs:
		if c is Spawner:
			_spawners.append(c)
	
func _process(delta):
	var dist = Game.get_distance_to_player(self)
	if dist <= proximity_to_spawn:
		for spawner in _spawners:
			var weak = weakref(spawner)
			if weak.get_ref():
				spawner.spawn_circle(self.global_position)
	set_process(false)
