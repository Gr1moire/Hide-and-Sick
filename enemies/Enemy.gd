extends KinematicBody2D

onready var remote_transform = get_node("../../EnemyPath/PathFollow2D")

var speed = 0.1
var move_direction = 0

func _physics_process(delta):
	MovementLoop(delta)
	
func _process(delta):
	AnimationLoop()
	
func MovementLoop(delta):
	var prepos = remote_transform.get_global_position()
	remote_transform.set_offset(remote_transform.get_offset() + speed + delta / 2)
	var pos = remote_transform.get_global_position()
	move_direction = (pos.angle_to_point(prepos) / 3.14) * 180 

func AnimationLoop():
	var animation_direction : String
	if move_direction <= 15 && move_direction >= -15:
		animation_direction = "Walk Right"
	elif move_direction <= -165 && move_direction >= 165:
		animation_direction = "Walk Left"
	elif move_direction <= 60 && move_direction >= 15:
		animation_direction = "Walk Right"
	elif move_direction <= 120 && move_direction >= 60:
		animation_direction = "Walk Down"
	elif move_direction <= 165 && move_direction >= 120:
		animation_direction = "Walk Left"
	elif move_direction >= -60 && move_direction <= -15:
		animation_direction = "Walk Right"
	elif move_direction >= -120 && move_direction <= -60:
		animation_direction = "Walk Up"
	elif move_direction >= -165 && move_direction <= -120:
		animation_direction = "Walk Left"
	else:
		animation_direction = "Walk Left"
	get_node("AnimationPlayer").play(animation_direction)
