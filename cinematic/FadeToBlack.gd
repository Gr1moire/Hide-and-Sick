extends Node2D

export(String, FILE) var next_scene = ""

func end_fade():
	if next_scene != "":
		get_tree().change_scene(next_scene)