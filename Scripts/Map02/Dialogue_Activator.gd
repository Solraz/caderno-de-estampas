extends Area3D

@export var player: Player
@export var dialogue : Array = []
var first_time : bool = true

func _on_body_entered(body):
	if (body == player):
		player.stats.dialoguing = true
		player.stats.dialogue = dialogue

		if (first_time):
			player.emit_signal("new_dialogue")
			first_time = false

		player.emit_signal("show_dialogue")

func _on_body_exited(body):
	if (body == player):
		player.stats.dialoguing = false
		player.emit_signal("close_dialogue")
