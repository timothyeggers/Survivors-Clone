class_name HitComponent extends Node

"""Hit is called when HitComponent hits something."""
signal hit(area)

"""Hit registered is called when HitComponent is told it hit something."""
signal hit_registered(area)

@export var stats: HitStats
@export var box: Area2D

@onready var _piereces = stats.piereces

func _ready():
	connect("hit_registered", _on_hit_registered)

# called from hurtbox
func _on_hit_registered(area):
	emit_signal("hit", area)
	_piereces -= 1
