class_name EntityState extends State

@export var root: Node2D
@export var sprite: AnimatedSprite2D
@export var player: AnimationPlayer
# Doubles for AnimationPlayer and AnimatedSprite2D
@export var animation_name: String

func enter():
	if animation_name:
		if player:
			player.play(animation_name)
		if sprite:
			sprite.play(animation_name)
