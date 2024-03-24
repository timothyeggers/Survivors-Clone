class_name ProjectileComponent extends Node

@export var rotate_speed = 13.0
@export var speed = 80.0
var direction := Vector2.ZERO

func _ready():
	Projectiles.add_projectile(self)
