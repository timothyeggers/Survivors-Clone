class_name DamageNumber
extends Node2D

var label: String = "123"
var color: Color = Color.WHITE

func _enter_tree():
	$Container/Label.text = label
	$Container/Label.set("theme_override_colors/font_color", color)
	$AnimationPlayer.play("default")


func _on_animation_finished(anim_name):
	queue_free()
