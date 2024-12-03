extends RayCast3D

@export var camera: Camera3D
var current_sound: AudioStreamPlayer3D = null

func _process(_delta):
	if (is_colliding()):
		var colliding_with = get_collider()

		if (colliding_with.is_in_group("StethoscopeSound")):
			colliding_with.emit_signal("play_sound")
			current_sound = colliding_with.sound

	if (!is_colliding() && current_sound != null):
		current_sound.volume_db = -80.0
		current_sound = null
