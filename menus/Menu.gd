extends Node

func _ready():
	$VBoxContainer/VBoxContainer/Start.grab_focus()


func _on_Start_pressed():
	pass # Replace with function body.


func _on_Exit_pressed():
	get_tree().quit()
