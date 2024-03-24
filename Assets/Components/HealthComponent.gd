class_name HealthComponent extends Node

signal on_hurt(area)
signal on_knockback(strength)
signal on_death(area)

@export var health = 8

@export_category("Optional")
@export var box: Area2D
@export var hurt_sfx: SoundEffect
@export var death_sfx: SoundEffect

@onready var _health = health

func set_health(amount):
	_health = amount

func _ready():
	if box:
		box.area_entered.connect(_on_hurt)

func take_damage(hit: HitStats):
	emit_signal("on_hurt", hit.damage)
	
	var total_damage = hit.damage
	var groups = get_parent().get_groups()
	
	match hit.type:
		HitStats.DamageType.MELEE:
			if "Water" in groups:
				total_damage = 0
			if "Metal" in groups:
				total_damage = 0
	
	# finalize damage
	_health -= total_damage
	UI.create_number(box.global_position,total_damage)
	
	if _health <= 0:
		emit_signal("on_death")
	
	if hurt_sfx and _health > 0: 
		Audio.play(hurt_sfx)
	if death_sfx and _health <= 0:
		Audio.play(death_sfx)

func _on_hurt(area: Area2D):
	var hit: HitComponent = area.get_parent().get_node("HitComponent")
	if hit and hit.box != box:
		take_damage(hit.stats)
		(hit as HitComponent).hit_registered.emit(area)
		


