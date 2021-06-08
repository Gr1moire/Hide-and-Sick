extends Node2D

onready var fade = $FadeToBlack/AnimationPlayer

func _ready():
	pass


func _on_Timer_timeout():
	fade.play("fade")
