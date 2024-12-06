extends StaticBody3D

@export var player: Player
@export var sound: AudioStreamPlayer3D
@export var center: Vector3 = Vector3.ZERO
@export var radius: float = 5.0
@export var angular_speed: float = 45.0
@export var rotation_axis: Vector3 = Vector3.UP

var current_angle: float = 0.0

signal play_sound

func _ready():
	sound.volume_db = -80.0
	look_at(player.get_global_transform().origin, Vector3.UP, true)

func _on_play_sound():
	if (!sound.playing):
		sound.play()

	if (sound.volume_db < 0.0):
		sound.volume_db = 0.0
		
func _process(delta: float) -> void:
	# Atualiza o ângulo atual baseado na velocidade angular
	current_angle += angular_speed * delta

	# Mantém o ângulo entre 0 e 360 graus
	current_angle = fmod(current_angle, 360)

	# Calcula a nova posição no círculo
	var radians = deg_to_rad(current_angle)
	var offset = Vector3(
		radius * cos(radians),
		0,
		radius * sin(radians)
	)
	
	offset = offset.rotated(Vector3.RIGHT, deg_to_rad(0)).rotated(rotation_axis, 0)
	position = center + offset
