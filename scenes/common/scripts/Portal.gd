tool
extends Area2D

onready var fade = $FadeToBlack/AnimationPlayer

func _input(event):
	if Input.is_action_just_pressed("hide") && PlayerVariable.canInteract :
		fade.play("fade")
