extends Node2D

onready var first_guard = $"perso/First Guard"
onready var second_guard = $"perso/Last Guard"
onready var prisoner = $"perso/Prisoner"
onready var fade_1 = $FadeToBlack/AnimationPlayer
onready var fade_2 = $FadeToBlack2/AnimationPlayer
onready var fade_3 = $FadeToBlack3/AnimationPlayer

func _ready():
	first_guard.play("anime")
	prisoner.play("anime")
	second_guard.play("anime")
	
func fade1():
	fade_1.play("fade")
