extends Node2D

const GLOBAL_CD = 0.2

@export var stats: ProjectileSpawnerStats

@onready var _proj_remain = stats.spawn_count

func _ready():
	spawn_projectile()

func spawn_projectile():
	var proj = stats.projectile.instantiate()
	
	Game.get_world().add_child(proj)
	proj.global_position = global_position
	proj.look_at(get_global_mouse_position())

	
	if (_proj_remain > 0):
		_proj_remain -= 1
		get_tree().create_timer(GLOBAL_CD).timeout.connect(spawn_projectile)
	else:
		_proj_remain = stats.spawn_count-1
		get_tree().create_timer(stats.attack_cd).timeout.connect(spawn_projectile)
	print(_proj_remain)
