class_name BoarWalkState extends EntityWalkState

@export var stats: ChargeStats = ChargeStats.new()

var _charge_cd = 0.0

func enter():
	super.enter()
	_charge_cd = stats.cooldown

func process(delta):
	_charge_cd -= delta
	if _charge_cd > 0:
		return
	
	if Game.get_distance_to_player(root) <= stats.range:
		var rand = randf_range(0, 1)
		if rand <= stats.likelihood:
			emit_signal("transitioned", self, "BoarChargePrepState")
