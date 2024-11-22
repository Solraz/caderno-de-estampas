extends StaticBody3D

@export var player: Player
@export var sound: AudioStreamPlayer3D

signal play_sound

func _ready():
	look_at(player.get_global_transform().origin, Vector3.UP, true)

func _on_play_sound():
	if (!sound.playing):
		sound.play()
