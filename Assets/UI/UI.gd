extends Node2D

var damage_number = preload("res://Assets/DamageNumber/DamageNumber.tscn")

func create_number(at: Vector2, label, color):
	var number = damage_number.instantiate() as DamageNumber
	number.label = str(label)
	number.color = color
	number.global_position = at
	
	Game.get_world().add_child(number)
	
	var tween = create_tween()
	tween.tween_property(number, "position", at + Vector2.UP * 30, 1)
	tween.finished.connect(number.queue_free)
