extends AudioStreamPlayer

func _ready():
	var audio = load(get_parent().Voiceline)
	audio.set_loop(false)
	stream = audio
func _on_VoiceArea_body_entered(body):
	if body.is_in_group("player") && !playing:
		play()
