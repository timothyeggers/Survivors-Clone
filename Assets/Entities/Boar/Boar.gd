extends RigidBody2D

signal on_charge()
signal on_charge_end()

@export var death: TransformNode2D

@export var move_speed = 50
@export var chance_to_charge = 0.1
@export var charge_time = 0.3
@export var charge_run_time = 1.7
@export var charge_distance = 200

var _move_speed = move_speed
var _charge_dt = null
var _fixed_direction = null

@onready var _sprite = $AnimatedSprite2D
@onready var _trail = $Trail

func _in_charge_run() -> bool:
	return _fixed_direction != null

func _ready():
	on_charge.connect(_on_charge)
	on_charge_end.connect(_on_charge_end)


func _process(delta):
	if _charge_dt and _charge_dt > 0:
		_charge_dt -= delta
		var amount = 1 * delta
		if not _in_charge_run():
			scale.x += amount
			scale.y += amount

	elif _charge_dt and _charge_dt <= 0:
		_charge_dt = null
		if not _in_charge_run():
			emit_signal("on_charge")
		else:
			emit_signal("on_charge_end")
	else:
		if Game.get_distance_to_player(self) > charge_distance:
			return
		var rand = randf_range(0, 1)
		if rand <= chance_to_charge:
			_charge_dt = charge_time
			_move_speed = 0


func _physics_process(delta):
	var direction = Game.get_direction_to_player(self)
	
	if _fixed_direction:
		direction = _fixed_direction
	
	if direction.x > 0: 
		_sprite.flip_h = false
	elif direction.x < 0:
		_sprite.flip_h = true
	
	move_and_collide(direction * _move_speed * delta)


func _on_hit(area):
	_sprite.play("hit")
	_sprite.self_modulate = Color(1, 0, 0)
	await _sprite.animation_finished
	_sprite.play("default")
	_sprite.self_modulate = Color.WHITE
	

func _on_charge():
	_fixed_direction = Game.get_direction_to_player(self)
	_move_speed = move_speed * 5
	_charge_dt = charge_run_time
	_trail.emitting = true


func _on_charge_end():
	_move_speed = move_speed
	_fixed_direction = null
	_charge_dt = null
	_trail.emitting = false
	scale = Vector2.ONE


func _on_knockback(strength):
	apply_central_impulse(-Game.get_direction_to_player(self) * strength)


func _on_stun(duration):
	pass


func _on_stun_timeout():
	return
	_sprite.play("default")
	_sprite.self_modulate  = Color(1,1,1)

func _on_death(area):
	if death:
		var d = death.transform(self)
		queue_free()
