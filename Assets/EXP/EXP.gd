extends Area2D

@export var value = 10

@onready var sprite = $Sprite2D

func _ready():
	if value <= 10:
		sprite.texture = $Sprite2D/Screw.get_texture()
	elif value <= 20:
		sprite.texture = $Sprite2D/TwoBolts.get_texture()
	elif value <= 30:
		sprite.texture = $Sprite2D/BoltAndNut.get_texture()

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	Game.experience += value
	queue_free()
