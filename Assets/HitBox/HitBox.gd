class_name HitBox
extends Area2D

signal on_trigger()

@export var stats: HitStats

func trigger():
	print( "Attack for " + str(stats.damage) )
	
	var areas = get_overlapping_areas()
	for area in areas:
		area.emit_signal("area_entered", self)
	emit_signal("on_trigger")
