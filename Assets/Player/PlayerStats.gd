class_name PlayerStats
extends Resource

@export var mind = 1 # implants, cpus
@export var body = 1 # chrome, cybernetics
@export var soul = 1 # capacitors, regulators

@export_group("Mind")
@export var mana = 10
@export var mana_regen = 5
@export var spell_dmg = 1

@export_group("Body")
@export var health = 10
@export var armor = 1
@export var move_speed = 1

#@export_group("Soul")
#@export var attacks = 2
#@export var attack_speed = 1
#@export var attack_cd = 0.5
