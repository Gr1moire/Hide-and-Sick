tool

extends Area2D

export (String, FILE) var next_scene_path = ""

onready var fade = $FadeToBlack/AnimationPlayer

func _get_configuration_warning() -> String:
	if next_scene_path == "":
		return "Next scene path must be set"
	else:
		return ""

func _input(event):
	if Input.is_action_just_pressed("hide") && PlayerVariable.canInteract :
		fade.play("fade")
