class_name SwingHitBox
extends HitBox

@export var swing: TransformNode2D
@export var sound: SoundEffect

func _process(delta):
	look_at(Game.look_at())

func trigger():
	super.trigger()
	Audio.play(sound)
	swing.transform(self)
