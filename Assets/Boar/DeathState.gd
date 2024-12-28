class_name DeathState extends EntityState

@export var health: HealthComponent
@export var death_node: Node

func _ready():
	health.on_death.connect(_on_death)

func enter():
	super.enter()

func _on_death():
	emit_signal("force_transitioned", "DeathState")
	# implement death transition, for now just play animation
	await sprite.animation_finished
	get_parent().get_parent().queue_free()
	
