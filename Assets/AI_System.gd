extends Node

var _actors: Array[AI_Actor] = []

var _update_index = 0 # which actor was last updated?
var _update_index_low = 0

func add_actor(actor : AI_Actor):
	_actors.append(actor)

func _process(delta):
	# clean dead enemies
	var in_tree: Array[AI_Actor] = []
	for actor in _actors:
		var weak = weakref(actor)
		if weak.get_ref():
			in_tree.append(actor)
	_actors = in_tree
	
	# update actors!
	for actor in _actors:
		if not actor.is_on_screen():
			continue
		
		if _update_index >= len(_actors):
			_update_index = 0
		
		actor.update_avoidance()
		_update_index += 1
