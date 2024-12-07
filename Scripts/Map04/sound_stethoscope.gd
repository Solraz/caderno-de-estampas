extends StaticBody3D

@export var player: Player
@export var sound: AudioStreamPlayer3D
@export var rotation_speed_mult: float = 1.0

signal play_sound

func _ready():
	sound.volume_db = -80.0
	# look_at(player.get_global_transform().origin, Vector3.UP, true)

func _on_play_sound():
	if (!sound.playing):
		sound.play()

	if (sound.volume_db < 0.0):
		sound.volume_db = 0.0
