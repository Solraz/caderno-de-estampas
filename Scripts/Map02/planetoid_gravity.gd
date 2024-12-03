extends StaticBody3D

@export var player : Player
@export var gravity_well : Node3D
var cutoff : float = -2.09952235221863
var is_player_above : bool = true
var gravity_direction : Vector3
var player_height : float = 2

func _ready():
	gravity_well_relative()

func _physics_process(delta):
	# var vector_to_player : float = self.global_position.y - player.global_position.y - player_height
	# print(vector_to_player)
	# var distance_to_player : float = self.global_position.distance_to(player.global_position)

	# var player_to_cutoff : float = player.global_position.y + 2.09952235221863
	
	# if (player_to_cutoff < 0.2 && is_player_above == true):
	# 	is_player_above = false
	# else:
	# 	is_player_above = true
	# if (!is_player_above):
	# 	rotate_basis(delta)

	change_gravity(delta)
	gravity_well_relative()
	print(player.stats.ply_gravity)

func gravity_well_relative():
	gravity_direction = (gravity_well.global_transform.origin - player.global_transform.origin).normalized()

func camera_relative():
	

func change_gravity(delta):
	player.stats.ply_gravity -= 60 * gravity_direction.y
	player.stats.ply_gravity = clamp(player.stats.ply_gravity, -60, 60)
