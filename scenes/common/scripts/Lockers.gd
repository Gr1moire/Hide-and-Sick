extends YSort

export (NodePath) var PlayerNode
onready var player = get_node(PlayerNode)

func _input(event):
	if player:
		if get_child(1).overlaps_body(player):
			if Input.is_action_just_pressed("hide") && PlayerVariable.canHide:		
				PlayerVariable.canHide = false
				PlayerVariable.isHided = true
				get_child(2).play()
				player.visible = false
			elif Input.is_action_just_pressed("hide") && PlayerVariable.isHided:
				PlayerVariable.canHide = true
				PlayerVariable.isHided = false
				player.visible = true 
	else:
		print("No player path given in ", self.name)
