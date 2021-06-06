extends KinematicBody2D

export var ACCELERATION = 750
export var MAX_SPEED = 200
export var ROLL_SPEED = 130
export var FRICTION = 700

enum {
	MOVE,
	ROLL,
	ATTACK    
}

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

var velocity = Vector2.ZERO
var state = MOVE
var isHided = false
var canHide = false


func _ready():
	randomize()
	animationTree.active = true
	get_child(4).visible = false

func _physics_process(delta):
			
	match state:
		MOVE:
			move_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationState.travel("Walk")
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION *delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)    
	if !isHided:
		move()

func move():
	velocity = move_and_slide(velocity)

func _input(event):
	if canHide:
		if Input.is_action_just_pressed("hide") && !isHided:
			isHided = true
			visible = false
			get_child(5).play()
		elif Input.is_action_just_pressed("hide") && isHided:
			isHided = false
			visible = true

func _on_HidingSpot_body_entered(body):
	if body.is_in_group("player") :
		canHide = true
		print(body)	
		get_child(4).visible = true

func _on_HidingSpot_body_exited(body):
	if body.is_in_group("player") :
		canHide = false
		print(body)
		get_child(4).visible = false
