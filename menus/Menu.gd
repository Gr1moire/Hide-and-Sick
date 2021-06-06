extends Node

func _ready():
	$VBoxContainer/VBoxContainer/Start.grab_focus()


func _on_Start_pressed():
	get_tree().change_scene("res://scenes/level1/Level1.tscn")


func _on_Exit_pressed():
	get_tree().quit()
