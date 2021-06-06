extends Area2D

onready var player = null

func _on_DetectionZone_body_entered(body):
	player = body
	print("nouveau player")

func _on_DetectionZone_body_exited(_body):
	player = null
	print("plus de player")
