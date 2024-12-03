extends Area3D

@export var mixer: AudioStreamPlayer
var stream
@export var player: Player
@export var clip: int = 0

func _ready():
	stream = mixer.get_stream_playback()

func _on_body_entered(body):
	if (body == player):
		stream.switch_to_clip(clip)

	if (!mixer.playing):
		player.play()