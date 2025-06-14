extends AudioStreamPlayer


const menu_music = preload("res://audio/menu music/fatalechoes.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	stream = music
	volume_db = volume
	play()
func play_music_menu():
	_play_music(menu_music)
