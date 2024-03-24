class_name EntityState extends State

@export var root: Node2D

@export_category("Animation")
@export var sprite: AnimatedSprite2D
@export var player: AnimationPlayer
@export var start_animation: String
@export var exit_animation: String

func enter():
	if start_animation:
		if player:
			player.play(start_animation)
		if sprite:
			sprite.play(start_animation)

func exit():
	if exit_animation:
		if player:
			player.play(exit_animation)
		if sprite:
			sprite.play(exit_animation)
