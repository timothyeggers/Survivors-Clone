extends TextureProgressBar

func _ready():
	Game.exp_gained.connect(_update_ui)

func _update_ui(amount):
	value = amount
