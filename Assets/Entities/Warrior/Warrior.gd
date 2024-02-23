extends CharacterBody2D

@export var hit_box: SwingHitBox
@export var stats: PlayerStats

const SWING_CD = 0.2

var _input = Vector2.ZERO
var _can_flip = true

@onready var _swings_left = stats.attacks
@onready var _attack_timer = $"Attack Speed"
@onready var _attack_cd_timer = $"Attack Cooldown"


func _ready():
	_attack_timer.wait_time = stats.attack_speed
	_attack_cd_timer.wait_time = stats.attack_cd
	
	_attack_timer.timeout.connect(_on_attack_timeout)
	_attack_cd_timer.timeout.connect(_on_attack_cd_timeout)
	$AnimationPlayer.play("walk")


func _process(delta):
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	
	_input = Vector2(x, y)
	
	if get_global_mouse_position().x > global_position.x:
		$Anchor.scale.x = 1
	elif get_global_mouse_position().x < global_position.x:
		$Anchor.scale.x = -1
	
	if Input.is_action_just_pressed("ui_accept"):
		stats.attacks += 1



func _physics_process(delta):
	var speed = stats.move_speed
	if Input.is_action_pressed("noclip"):
		speed *= 10
	move_and_collide(_input * speed)


func _on_attack_timeout():
	#var combo = false if _swings_left % 2 == 0 else true
	#print("Trigger " + str(_swings_left))
	if _swings_left <= 0:
		return
	
	_swings_left -= 1
	
	hit_box.trigger()
	$AnimationPlayer.seek(0)
	$AnimationPlayer.play("attack")
	
	
	if _swings_left > 0:
		_attack_timer.start(SWING_CD)
		return
	
	_attack_timer.stop()
	_attack_cd_timer.start()


func _on_attack_cd_timeout():
	_swings_left = stats.attacks
	_attack_timer.start(stats.attack_speed)
	_attack_cd_timer.stop()


func _on_death(area):
	set_process(false)
	set_physics_process(false)
	await get_tree().create_timer(1.0).timeout
	set_process(true)
	set_physics_process(true)
	


func _on_hurt_box_on_hit(area):
	pass
	#print("Was hit")
