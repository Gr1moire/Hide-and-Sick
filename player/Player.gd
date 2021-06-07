extends KinematicBody2D

export var ACCELERATION = 750
export var MAX_SPEED = 50
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
	if !PlayerVariable.isHided:
		move()

func move():
	velocity = move_and_slide(velocity)

func _on_HidingSpot_body_entered(body):
	if body.is_in_group("player") :
		PlayerVariable.canHide = true
		get_child(4).visible = true

func _on_HidingSpot_body_exited(body):
	if body.is_in_group("player") :
		PlayerVariable.canHide = false
		get_child(4).visible = false

func _on_Portal_body_entered(body):
	PlayerVariable.canInteract = true
	get_child(4).visible = true

func _on_Portal_body_exited(body):
	PlayerVariable.canInteract = false
	get_child(4).visible = false

func _on_Voice1_body_entered(body):
	if get_node("../../Audio/Voice1/Voice1Audio"):
		if body.is_in_group("player") && !get_node("../../Audio/Voice1/Voice1Audio").playing:
			get_node("../../Audio/Voice1/Voice1Audio").play()

func _on_Voice1Audio_finished():
	get_node("../../Audio/Voice1/Voice1Audio").queue_free()
