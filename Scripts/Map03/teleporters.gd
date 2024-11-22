extends Area3D

@export var player: Player
@export var from: Area3D = self
@export var to: Area3D

func _on_body_entered(body):
	if (body == player):
		player.global_position = to.global_position
