class_name AIComponentManager extends Node
"""
AIComponentManager processes all registered AIComponent, updating a fixed amount per frame
in order to increase performance.
"""

@export var max_updates = 80

var _ai_s: Array[AIComponent] = []
var _ai_s_priority: Array[AIComponent] = []

var _update_index = 0

func add_ai(ai : AIComponent, high_priority := false):
	if high_priority:
		_ai_s_priority.append(ai)
	else:
		_ai_s.append(ai)

func _physics_process(delta):
	# update ai's!
	var start_i = _update_index
	var count = len(_ai_s)
	count = clamp(count, count, max_updates)
	for i in count:
		if _update_index >= len(_ai_s):
			_update_index = 0
		
		var ai = _ai_s[_update_index]
		
		# clean up non existant ai
		if not weakref(ai).get_ref():
			_ai_s.remove_at(_update_index)
			_update_index -= 1
			continue
		
		ai.update_avoidance()
		_update_index += 1
	
	# update priority ai's
	count = len(_ai_s_priority)
	var i = 0
	for none in count:
		if i >= len(_ai_s_priority):
			i = 0
			
		var ai = _ai_s_priority[i]
		
		# clean up non existant ai
		if not weakref(ai).get_ref():
			_ai_s_priority.remove_at(i)
			i -= 1
			continue
		
		ai.update_avoidance()
		i += 1
	
