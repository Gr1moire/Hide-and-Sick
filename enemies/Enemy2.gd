extends KinematicBody2D

var speed = 0.1
var move_direction = 0

#########################
const MAX_SPEED = 40
const ACCELERATION = 300
const FRICTION = 100

onready var detection_zone = $PlayerDetection

export(NodePath) var playerPath
onready var player = get_node(playerPath)
var playerDetected := false
onready var touch_player = $TouchPlayer

var velocity = Vector2.DOWN

const SPEED = 40
var path: Array = []
var levelNaviguation: Navigation2D = null

export(Vector2) var player_not_found

onready var actual_direction = player_not_found
#########################

func _ready():
	randomize()
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNaviguation"):
		levelNaviguation = tree.get_nodes_in_group("LevelNaviguation")[0]
		assert(levelNaviguation)

func _physics_process(delta):
	chase_player(delta)
	var test = touch_player.touched_player
	if test && PlayerVariable.isHided == false:
		get_tree().change_scene("res://cinematic/getBackToYourBed.tscn")
	
func _process(delta):
	AnimationLoop()

#########################

func chase_player(delta):
	if PlayerVariable.isHided:
		make_path_finding("no")
	else:
		make_path_finding("yes")
	move()
	
func make_path_finding(flag):
	if levelNaviguation && player:
		if flag == "no":
			generate_path_no_player()
		elif flag == "yes":
			generate_path()
		naviguate()

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

func move():
	if velocity.x < 0:
		$Sprite.set_flip_h(true)
	else:
		$Sprite.set_flip_h(false)
	velocity = move_and_slide(velocity)

func naviguate():
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * SPEED
		if global_position == path[0]:
			path.pop_front()

func generate_path():
	if levelNaviguation:
		path = levelNaviguation.get_simple_path(global_position, player.global_position, false)

func generate_path_no_player():
	if levelNaviguation:
		path = levelNaviguation.get_simple_path(global_position, player_not_found, false)


#########################

#func MovementLoop(delta):
#	var prepos = remote_transform.get_global_position()
#	remote_transform.set_offset(remote_transform.get_offset() + speed + delta / 2)
#	var pos = remote_transform.get_global_position()
#	move_direction = (pos.angle_to_point(prepos) / 3.14) * 180 

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
	print(animation_direction)
	get_node("AnimationPlayer").play(animation_direction)


func _on_DetectionZone_body_entered(_body):
	playerDetected = true


func _on_DetectionZone_body_exited(_body):
	playerDetected = false
