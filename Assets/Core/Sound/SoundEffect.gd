class_name SoundEffect
extends Resource

@export var stream: AudioStream
@export var max_concurrent = 3
@export var cascade_sound = false
@export_range(0, 2) var pitch_min = 0.8
@export_range(0, 2) var pitch_max = 1.0
