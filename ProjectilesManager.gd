extends Node

var _projectiles: Array[ProjectileComponent] = []

func add_projectile(projectile: ProjectileComponent):
	_projectiles.append(projectile)

func _process(delta):
	var count = len(_projectiles)
	for i in count:
		var proj = _projectiles[i]
		
		# clean dead projectiles
		var root = proj.get_parent()
		if !(root is Node2D):
			_projectiles.remove_at(i)
			continue
		
		(root as Node2D).global_position += proj.direction * proj.speed * delta
		(root as Node2D).rotate(proj.rotate_speed * delta)
