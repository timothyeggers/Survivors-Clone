class_name HitBox
extends Area2D

signal on_trigger()

@export var stats: HitStats
@export var ignore_parent_hurtbox = true

func trigger():
	#print( "Attack for " + str(stats.damage) )
	
	var areas = get_overlapping_areas()
	for area in areas:
		if ignore_parent_hurtbox and get_parent() == area.get_parent():
			continue
		area.emit_signal("area_entered", self)
	emit_signal("on_trigger")
