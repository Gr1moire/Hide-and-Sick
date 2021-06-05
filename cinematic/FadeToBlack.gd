extends Node2D

export(String, FILE) var next_scene = ""

func end_fade():
	get_tree().change_scene(next_scene)
