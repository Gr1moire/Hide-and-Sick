extends Node2D

onready var lastGuard = $"Personnage/Last Guard"
onready var prisoner = $"Personnage/Prisoner"
onready var firstGuard = $"Personnage/First Guard"
onready var fade = $FadeToBlack/AnimationPlayer

func _ready():
	firstGuard.play("animation")
	prisoner.play("animation")
	lastGuard.play("animation")

func launch_fade():
	fade.play("fade")
