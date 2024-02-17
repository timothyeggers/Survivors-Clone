extends RigidBody2D

@export var death: TransformNode2D

@onready var _move_speed = 1.5
@onready var sprite = $Sprite2D
@onready var player: Node2D = get_tree().get_first_node_in_group("Player")


func _physics_process(delta):
	var direction = position.direction_to(player.position)
	
	if direction.x > 0: 
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	
	move_and_collide(direction * _move_speed)


func _on_death(area):
	death.transform(self)
	queue_free()
