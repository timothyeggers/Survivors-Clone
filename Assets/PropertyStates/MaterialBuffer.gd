class_name MaterialBuffer extends Node

@export var target: Node2D

var _buffer: Material

func assign(material: Material):
	target.material = material
	_buffer = target.material

func buffer(temp_material: Material):
	target.material = temp_material

func release():
	target.material = _buffer
