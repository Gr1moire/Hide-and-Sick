extends YSort

export (NodePath) var PlayerNode
onready var player = get_node(PlayerNode)

func _input(event):
	if player:
		if get_child(1).overlaps_area(player.get_child(7)):
			if Input.is_action_just_pressed("hide") && PlayerVariable.canHide:		
				PlayerVariable.canHide = false
				PlayerVariable.isHided = true
				get_child(2).play()
				player.visible = false
				player.get_child(1).disabled = true
			elif Input.is_action_just_pressed("hide") && PlayerVariable.isHided:
				PlayerVariable.canHide = true
				PlayerVariable.isHided = false
				player.visible = true 
				player.get_child(1).disabled = false				
	else:
		return "No player path given in " + self.name
