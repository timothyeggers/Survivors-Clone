class_name HighlightComponent extends Node

const OUTLINE_SHADER = preload("res://Assets/Outline.gdshader")

@export var material: MaterialBuffer

func _ready():
	var parent = get_parent()
	if parent is Entity:
		(parent as Entity).on_entity_select.connect(_on_highlight)
		(parent as Entity).on_entity_deselect.connect(_on_unhighlight)

func _on_highlight(area):
	highlight()

func _on_unhighlight():
	unhighlight()

func highlight():
	var outline = ShaderMaterial.new()
	outline.shader = OUTLINE_SHADER
	material.buffer(outline)

func unhighlight():
	material.release()
