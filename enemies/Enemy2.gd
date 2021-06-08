extends KinematicBody2D

const MAX_SPEED = 40
const ACCELERATION = 300
const FRICTION = 100
const SPEED = 40

onready var detection_zone = $PlayerDetection
onready var player = get_node(playerPath)
onready var touch_player = $TouchPlayer
onready var actual_direction = player_not_found
onready var sprite = $Sprite

export(Vector2) var player_not_found
export(NodePath) var playerPath

var playerDetected := false
var velocity = Vector2.DOWN
var path: Array = []
var levelNaviguation: Navigation2D = null
var move_direction = 0

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
	AnimationLoop()

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
		sprite.set_flip_h(true)
	else:
		sprite.set_flip_h(false)
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
