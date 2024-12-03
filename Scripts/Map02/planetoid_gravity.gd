extends StaticBody3D

@onready var player : Player = $Player

func _ready():
  pass

func _physics_process(_delta):
  var vector_to_player : Vector3 = self.global_position - player.global_position
  var distance_to_player : float = self.global_position.distance_to(player.global_position)
