tool

extends Area2D

export(String, FILE) var next_scene_path = ""

func _get_configuration_warning() -> String:
	if next_scene_path == "":
		return "Next scene path must be set"
	else:
		return ""


func _on_Portal_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene(next_scene_path)
