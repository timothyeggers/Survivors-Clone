class_name AIComponentManager extends Node
"""
AIComponentManager processes all registered AIComponent, updating a fixed amount per frame
in order to increase performance.
"""

var _ai_s: Array[AIComponent] = []

var _area: Area2D

var _update_index = 0 # which ai was last updated?
var _update_index_low = 0

func add_ai(ai : AIComponent):
	_ai_s.append(ai)

func _process(delta):
	# clean dead enemies
	var in_tree: Array[AIComponent] = []
	for ai in _ai_s:
		var weak = weakref(ai)
		if weak.get_ref():
			in_tree.append(ai)
	_ai_s = in_tree
	
	# update ai's!
	for ai in _ai_s:
		if not ai.is_on_screen():
			continue
		
		if _update_index >= len(_ai_s):
			_update_index = 0
		
		ai.update_avoidance()
		_update_index += 1
