extends AudioStreamPlayer3D
@export var player: Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.z = player.position.z
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.z = player.position.z
	pass
