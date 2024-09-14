extends Node

func play_sound(file_path: String) -> void:
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	
	var audio_stream = load(file_path) as AudioStream
	if audio_stream:
		audio_player.stream = audio_stream
		audio_player.play()
		audio_player.finished.connect(Callable(audio_player, "queue_free"))
	else:
		print("Failed to load audio file: ", file_path)
