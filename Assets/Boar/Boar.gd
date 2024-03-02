extends Node2D

signal on_charge()
signal on_charge_end()

@export_category("")
@export var actor: AI_Actor
@export var speed = 32

@export_category("Charge Properties")
const CHARGE_GROWTH = 1.25
@export var charge_speed = 7
@export var chance_to_charge = 0.05
@export var charge_prep_time = 0.4
@export var distance_to_attempt_charge = 125
var _charge_distance: float = distance_to_attempt_charge * 1.5
var _charge_run_time: float = _charge_distance / (charge_speed * speed)

@onready var _sprite: Sprite2D
@onready var _trail: CPUParticles2D

var _velocity := Vector2.ZERO
var _speed = speed

# if we haven't moved (due to body blocking), then increment this.
var _time_since_move = 0.0

# charge for a given time, and set a fixed direction.
var _charge_dt = null
var _charge_prep_dt = null
var _charge_dir = null


func in_charge_run() -> bool:
	return _charge_dt != null

func in_charge_prep() -> bool:
	return _charge_prep_dt != null

func _ready():
	add_to_group("Enemy")
	
	on_charge.connect(_on_charge)
	on_charge_end.connect(_on_charge_end)
	
	_sprite = $Sprite2D
	_trail = $Trail

func _physics_process(delta):
	# roll the dice to charge the player.
	if not in_charge_run() and not in_charge_prep():
		if Game.get_distance_to_player(self) <= distance_to_attempt_charge:
			var rand = randf_range(0, 1)
			if rand <= chance_to_charge:
				_charge_prep_dt = charge_prep_time + delta
	
	# charge wind-up
	if in_charge_prep():
		_charge_prep_dt -= delta
		# grow the character
		_sprite.scale = lerp(
			Vector2.ONE * CHARGE_GROWTH,
		 	Vector2.ONE, 
			_charge_prep_dt / charge_prep_time)
		# release charge
		if _charge_prep_dt < 0:
			emit_signal("on_charge")

	# charge time remaining
	if in_charge_run():
		_charge_dt -= delta
		# stop charge run
		if _charge_dt < 0:
			emit_signal("on_charge_end")
	
	if actor.get_avoidance_force().length() > _velocity.length() + _time_since_move:
		_velocity = Vector2.ZERO
		_time_since_move += delta
	else:
		_velocity = global_position.direction_to(Game.get_player().global_position)
		_time_since_move = 0.0
	
	if in_charge_prep():
		_velocity = Vector2.ZERO
	
	if _charge_dir:
		_velocity = _charge_dir
	
	global_position += (_velocity + actor.get_avoidance_force()).normalized() * _speed * delta


func _on_charge():
	_charge_prep_dt = null
	_charge_dt = _charge_run_time
	_charge_dir = Game.get_direction_to_player(self)
	_speed = speed * charge_speed
	_trail.emitting = true
	_sprite.scale = Vector2.ONE
	actor.set_disabled(true)


func _on_charge_end():
	_charge_dt = null
	_speed = speed
	_charge_dir = null
	_trail.emitting = false
	actor.set_disabled(false)
