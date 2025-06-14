extends Node

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"


func _ready():
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("keybinding", "move_forward", "W")
		config.set_value("keybinding", "strafe_left", "A")
		config.set_value("keybinding", "strafe_right", "D")
		config.set_value("keybinding", "move_backward", "S")
		config.set_value("keybinding", "jump", "Space")
		config.set_value("keybinding", "crouch", "C")
		config.set_value("keybinding", "sprint", "L_Shift")
		config.set_value("keybinding", "primary_attack", "mouse_1")
		config.set_value("keybinding", "secondary_attack", "mouse_2")
		config.set_value("keybinding", "block", "F")
		config.set_value("keybinding", "cast_spell", "Q")
		config.set_value("keybinding", "player_interact", "E")
		
		config.set_value("video", "fullscreen", 0)
		config.set_value("video", "resolution", 0)
		
		config.set_value("audio", "main_volume", 0.5)
		config.set_value("audio", "music_volume", 0.75)
		
		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)


func save_video_setting(key: String, value):
	config.set_value("video", key, value)
	config.save(SETTINGS_FILE_PATH)

func load_video_setting():
	var video_settings = {}
	for key in config.get_section_keys("video"):
		video_settings[key] = config.get_value("video", key)
	return video_settings

func save_audio_setting(key: String, value):
	config.set_value("audio", key, value)
	config.save(SETTINGS_FILE_PATH)

func load_audio_setting():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings
