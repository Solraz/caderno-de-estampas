extends Node3D

var rotation_speed: float = 0.1

var children

func _ready():
	children = get_tree().get_nodes_in_group("StethoscopeSound")

func _physics_process(delta):
	self.rotation.y += rotation_speed * delta * 0.2

	for planet in children:
		planet.rotation.y += planet.rotation_speed_mult * rotation_speed * delta
