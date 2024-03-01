extends Label

func _process(delta):
	text = "Enemy Count: " + str(Game.get_enemy_count())
