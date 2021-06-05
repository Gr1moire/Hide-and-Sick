extends PathFollow2D

export var runSpeed = 1

func _process(delta):
	set_offset(get_offset() + runSpeed + delta / 2)
