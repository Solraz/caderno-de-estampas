extends Button

@export var level_name = ""
var level_name_formatted = ""

func _ready():
	level_name_formatted = "res://Scenes/{level_name}.tscn"
	level_name_formatted = level_name_formatted.format({"level_name": level_name})

func _on_pressed():
	get_tree().change_scene_to_file(level_name_formatted)
