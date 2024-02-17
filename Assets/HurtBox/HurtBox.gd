class_name HurtBox
extends Area2D

signal on_hit(area)
signal on_stun(duration)
signal on_stun_timeout()
signal on_knockback(strength)
signal on_death(area)

@export var hurt_stats: HurtBoxStats
@export var sound_effect: SoundEffect

@onready var stun_timer: Timer = $"Stun Timer"
@onready var knockback_cd_timer: Timer = $"Knockback CD"

@onready var _health = hurt_stats.health
@onready var _can_knockback = true


func _ready():
	area_entered.connect(_on_hit)
	stun_timer.timeout.connect(_on_stun_timeout)
	knockback_cd_timer.timeout.connect(_on_knockback_cd_timer)

func _on_hit(area):
	print(get_parent().name + " was hit from: " + area.get_parent().name)
	Audio.play(sound_effect)
	emit_signal("on_hit", area)
	
	if "stats" in area:
		var hit = area.stats
	
		if hit.damage:
			var ratio: float = hit.damage / hurt_stats.health
			var color = Game.color_ratio(hit.damage / hurt_stats.health)
			
			UI.create_number(global_position, hit.damage, color)
			
			_health -= hit.damage
			if _health <= 0:
				emit_signal("on_death", area)
				set_deferred("monitorable", false)
				#knockback_timer.stop()
				return
		
		if hit.stun:
			stun_timer.start(hit.stun)
			emit_signal("on_stun", hit.stun)
		
		if hit.knockback and _can_knockback:
			emit_signal("on_knockback", hit.knockback)
			knockback_cd_timer.start(hurt_stats.knockback_cd)
			_can_knockback = false


func _on_knockback_cd_timer():
	_can_knockback = true


func _on_stun_timeout():
	emit_signal("on_stun_timeout")

