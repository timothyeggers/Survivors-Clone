class_name HealthComponent extends Node

signal on_hurt(area)
signal on_knockback(strength)
signal on_death()

@export var health = 8

@export_category("Optional")
@export var hurtbox: Area2D
@export var hurt_sfx: SoundEffect
@export var death_sfx: SoundEffect

@onready var _health = health

func set_health(amount):
	_health = amount

func _ready():
	if hurtbox:
		hurtbox.area_entered.connect(_on_hurt)

func take_damage(hit: HitStats):
	# Just play a noise when you hit a dead healthcomponent.
	if _health <= 0:
		return
	
	# Calculate the damage and perform the UI/sound effects
	var total_damage = hit.damage
	var groups = get_parent().get_groups()
	
	#match hit.type:
		#HitStats.DamageType.MELEE:
			#if "Water" in groups:
				#total_damage = 0
			#if "Metal" in groups:
				#total_damage = 0
	# do sound
	if hurt_sfx and _health > 0: 
		Audio.play(hurt_sfx)
		
	# finalize damage
	_health -= total_damage
	UI.create_number(hurtbox.global_position,total_damage)
	
	
	
	if death_sfx and _health <= 0:
		Audio.play(death_sfx)
		
	if _health <= 0:
		emit_signal("on_death")


func _on_hurt(area: Area2D):
	var hit: HitComponent = area.get_parent().get_node("HitComponent")
	# make sure the hit and hurtbox don't share the same area2d.
	if hit and hit.hitbox != hurtbox:
		take_damage(hit.stats)
		(hit as HitComponent).hit_registered.emit(area)
		


