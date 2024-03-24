extends Node2D

var damage_number = preload("res://Assets/DamageNumber/DamageNumber.tscn")

func create_number(at: Vector2, label):
	var number = damage_number.instantiate() as DamageNumber
	number.label = str(label) 
	number.global_position = at
	
	Game.get_world().add_child(number)
	
	var tween = create_tween()
	tween.tween_property(number, "position", at + Vector2.UP * 30, 0.5)
	tween.finished.connect(number.queue_free)

func create_texture_tween(at: Vector2, texture: Texture):
	var sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.global_position = at
	
	Game.get_world().add_child(sprite)
	
	var tween = create_tween()
	tween.tween_property(sprite, "position", at + Vector2.UP * 30, 0.5)
	tween.finished.connect(sprite.queue_free)
