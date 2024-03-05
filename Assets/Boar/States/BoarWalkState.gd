class_name BoarWalkState extends EntityWalkState

@export var charge_cooldown = 4
@export var charge_range = 125
@export var charge_likelihood = 0.05

var _charge_cd = 0.0

func enter():
	super.enter()
	_charge_cd = charge_cooldown

func process(delta):
	_charge_cd -= delta
	if _charge_cd > 0:
		return
	
	if Game.get_distance_to_player(root) <= charge_range:
		var rand = randf_range(0, 1)
		if rand <= charge_likelihood:
			emit_signal("transitioned", self, "BoarChargePrepState")
