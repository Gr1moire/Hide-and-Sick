extends Node2D

onready var fade = $FadeToBlack/AnimationPlayer

func _on_Timer_timeout():
	fade.play("fade")
