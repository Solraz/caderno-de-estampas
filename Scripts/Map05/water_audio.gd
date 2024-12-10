extends PathFollow3D
@export var player: Player

var start = 739 # 0
var end = -985 # 100
var size_of_path = 1724

func _ready() -> void:
	self.progress_ratio = 1 - ((player.position.z - end)) / (size_of_path)

func _process(_float):
	self.progress_ratio = 1 - ((player.position.z - end)) / (size_of_path)
