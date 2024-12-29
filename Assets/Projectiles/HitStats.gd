class_name HitStats
extends Resource

enum DamageType {
	MELEE,
	MAGIC
}

@export var damage = 4
@export var knockback = 6
@export var stun = 0.1
@export var piereces = 0
@export var type := DamageType.MELEE
