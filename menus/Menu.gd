extends Node

onready var fade = $FadeToBlack/AnimationPlayer

func _ready():
	$VBoxContainer/VBoxContainer/Start.grab_focus()


func _on_Start_pressed():
	fade.play("fade")

func _on_Exit_pressed():
	get_tree().quit()
