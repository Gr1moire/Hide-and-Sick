extends Area2D

export (String, FILE) var Voiceline

func _on_VoiceAudio_finished():
	$VoiceAudio.queue_free()
