extends Node

var num_players = 8
var bus = "SFX"

var available = []  # The available players.
var queue: Array[SoundEffect] = []  # The queue of sounds to play.

var hit_stream = AudioStreamPlayer.new()


func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	add_child(hit_stream)
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.finished.connect(_on_stream_finished.bind(p))
		p.bus = bus


func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again.
	available.append(stream)


func play(sound: SoundEffect):
	var count = 0
	for s in queue:
		if s.stream == sound.stream:
			count += 1 
	if count <= sound.max_concurrent:
		queue.append(sound)


func _process(delta):
	# Play a queued sound if any players are available.
	if queue.size() > 0 and available.size() > 0:
		var sound = queue.pop_front()
		available[0].stream = sound.stream
		available[0].pitch_scale = randf_range(sound.pitch_min, sound.pitch_max)
		available[0].play()
		available.pop_front()
