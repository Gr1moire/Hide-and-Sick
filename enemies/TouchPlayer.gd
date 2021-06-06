extends Area2D

onready var touched_player = null

func _on_TouchPlayer_body_entered(body):
	touched_player = body

func _on_TouchPlayer_body_exited(body):
	touched_player = null
