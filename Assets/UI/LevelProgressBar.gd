extends TextureProgressBar

func _ready():
	Game.exp_gained.connect(_update_ui)

func _update_ui(amount):
	value = 100 * Game.get_level_ratio()
	$Level.text = "Level " + str(Game.get_level())
