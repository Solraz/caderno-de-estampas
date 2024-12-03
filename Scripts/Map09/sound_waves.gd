extends AudioStreamPlayer3D

@export var sample_hz: AudioStreamPlayer3D = self
@export var temporizer : Timer
@export var note_temporizer: Timer

var playback
var pulse_hz = 440.0


var c_major : Array = [
	262,
	277,
	294,
	311,
	330,
	349,
	370
]

var c_minor : Array = [
	131,
	146,
	155,
	174,
	196,
	207,
	233,
]

var c_arrays : Array = [
	c_major,
	c_minor
]

func _ready():
	sample_hz.play()
	playback = sample_hz.get_stream_playback()
	fill_buffer()

func fill_buffer():
	var phase = 0.0
	var increment = individual_column() / sample_hz.stream.mix_rate
	var frames_available = playback.get_frames_available()

	for i in range(frames_available):
		playback.push_frame(Vector2.ONE * sin(phase * TAU))
		phase = fmod(phase + increment, 1.0)

func individual_column():
	var note = c_arrays[rand_true_or_false()][rand_note()]
	return note


func rand_true_or_false():
	return randi_range(0, 1)

func rand_note():
	return randi_range(0, 11)
