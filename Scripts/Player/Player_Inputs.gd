extends CharacterBody3D
class_name PlayerInputs

@export var stats: Resource
var camera: Node3D

var main_menu = preload("res://Scenes/main_menu.tscn")

func _ready():
	push_warning("You should not be seeing this (player_inputs.gd is being initiated)")
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		InputMouse(event)
		
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if event.is_action_pressed("click"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
	if event.is_action_pressed("restart"):
		stats.vel = Vector3(0, 0, 0)
		get_tree().reload_current_scene()

	if event.is_action_pressed("back_to_menu"):
		stats.vel = Vector3(0, 0, 0)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_packed(main_menu)

func InputMouse(event):
	stats.xlook += -event.relative.y * stats.ply_xlookspeed
	stats.ylook += -event.relative.x * stats.ply_ylookspeed
	stats.xlook = clamp(stats.xlook, stats.ply_maxlookangle_down, stats.ply_maxlookangle_up)
	
func ViewAngles(_delta):
	camera.rotation_degrees.x = stats.xlook
	camera.rotation_degrees.y = stats.ylook
	
func InputKeys():
	stats.sidemove += int(stats.ply_sidespeed) * (int(Input.get_action_strength("move_left") * 50))
	stats.sidemove -= int(stats.ply_sidespeed) * (int(Input.get_action_strength("move_right") * 50))
	
	stats.forwardmove += int(stats.ply_forwardspeed) * (int(Input.get_action_strength("move_forward") * 50))
	stats.forwardmove -= int(stats.ply_backspeed) * (int(Input.get_action_strength("move_back") * 50))

	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		stats.sidemove = 0
	else:
		stats.sidemove = clamp(stats.sidemove, -4096, 4096)
		
	if Input.is_action_just_released("move_forward") or Input.is_action_just_released("move_back"):
		stats.upmove = 0
	else:
		stats.upmove = clamp(stats.upmove, -4096, 4096)
		
	if Input.is_action_just_released("move_forward") or Input.is_action_just_released("move_back"):
		stats.forwardmove = 0
	else:
		stats.forwardmove = clamp(stats.forwardmove, -4096, 4096)
