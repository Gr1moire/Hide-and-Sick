extends Area2D

### Le fichier de la variable export DOIT être le fichier audio (.mp3, .ogg, etc) ###
## Surtout pas le .import. ### 

export (String, FILE, "*.mp3,*.ogg") var Voiceline

func _on_VoiceAudio_finished():
	$VoiceAudio.queue_free()
