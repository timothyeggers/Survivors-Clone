extends RigidBody2D

@export var death: TransformNode2D
@export var dist_to_explode = 25.0

@onready var _move_speed = 1.5
@onready var sprite = $Sprite2D
@onready var health = $HurtBox

func _ready():
	$Animation.animation_finished.connect(_explode)

func _physics_process(delta):
	var direction = Game.get_direction_to_player(self)
	
	if direction.x > 0: 
		sprite.flip_h = true
	elif direction.x < 0:
		sprite.flip_h = false
	
	move_and_collide(direction * _move_speed)
	
	var distance = Game.get_player().global_position.distance_to(global_position)
	if distance <= dist_to_explode:
		set_physics_process(false)
		$Animation.play("detonate")


func _explode(name):
	health.emit_signal("on_death", self)


func _on_death(area):
	death.transform(self)
	queue_free()
