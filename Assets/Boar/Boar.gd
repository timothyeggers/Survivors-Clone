extends Node2D

@export var actor: AI_Actor
@export var sprite: Sprite2D
@export var speed = 64

var _time_since_move = 0.0
var _velocity := Vector2.ZERO

func _ready():
	add_to_group("Enemy")

func _physics_process(delta):
	if actor.get_avoidance_force().length() > _velocity.length() + _time_since_move:
		_velocity = Vector2.ZERO
		_time_since_move += delta
	else:
		_velocity = global_position.direction_to(Game.get_player().global_position)
		_time_since_move = 0.0
	global_position += (_velocity + actor.get_avoidance_force()).normalized() * speed * delta

