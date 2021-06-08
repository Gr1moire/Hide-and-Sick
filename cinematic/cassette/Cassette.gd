extends Node2D

onready var fade = $FadeToBlack/AnimationPlayer

func _on_AudioStreamPlayer_finished():
	fade.play("fade")
