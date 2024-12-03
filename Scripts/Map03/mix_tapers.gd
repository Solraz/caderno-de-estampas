extends AudioStreamPlayer

@export var mixer: AudioStreamPlayer
@export var counter: Node
var streamer
@export var player: Player

func _ready():
	mixer.play()
	streamer = mixer.get_stream_playback()

func switch_clip(body, number):
	if (!mixer.playing):
		mixer.play()

	if (body == player):
		print(counter.current_clip)
		# if (counter.current_clip != clip):
		# stream.switch_to_clip_by_name(clip)
		streamer.switch_to_clip(number)

		print(counter.current_clip)

func _on_03_body_entered(body):
	switch_clip(body, 3)

func _on_02_body_entered(body):
	switch_clip(body, 2)

func _on_01_body_entered(body):
	switch_clip(body, 1)

func _on_00_body_entered(body):
	switch_clip(body, 0)


func _on_first_corridor_mix_01_body_entered(body):
	pass # Replace with function body.
