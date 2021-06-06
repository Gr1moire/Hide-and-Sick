tool

extends Area2D

export (String, FILE) var next_scene_path = ""

func _get_configuration_warning() -> String:
	if next_scene_path == "":
		return "Next scene path must be set"
	else:
		return ""

func _input(event):
	if Input.is_action_just_pressed("hide") && PlayerVariable.canInteract :
		get_tree().change_scene(next_scene_path)
