extends Control


@onready var fullscreen_mode = $"Video Settings Container/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Screen Mode"
@onready var window_resolution = $"Video Settings Container/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Window Resolution"
@onready var main_volume_slider = $"Audio Settings Container/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/MainVolume"
@onready var music_volume_slider = $"Audio Settings Container/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/MusicVolume"
@onready var sfx_volume_slider = $"Audio Settings Container/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/SFXVolume"

var master = AudioServer.get_bus_index("Master")
var music = AudioServer.get_bus_index("Music")
var sfx = AudioServer.get_bus_index("SFX")

func _ready():
	var video_settings = ConfigFileHandler.load_video_setting()
	fullscreen_mode.selected = video_settings.fullscreen
	window_resolution.selected = video_settings.resolution
	
	var audio_settings = ConfigFileHandler.load_audio_setting()
	main_volume_slider.value = audio_settings.main_volume
	music_volume_slider.value = audio_settings.music_volume
	sfx_volume_slider.value = audio_settings.sfx_volume
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		%"System Settings".visible = false
		%"Start Screen".visible = true
	
func _on_back_pressed():
	%"Button SFX".play()
	%"Start Screen".visible = true
	%"System Settings".visible = false

func _on_video_settings_button_pressed():
	%"Button SFX".play()
	%"Video Settings Container".visible = true
	%"Audio Settings Container".visible = false
	%Keybinds.visible = false

func _on_audio_settings_button_pressed():
	%"Button SFX".play()
	%"Video Settings Container".visible = false
	%"Audio Settings Container".visible = true
	%Keybinds.visible = false

func _on_keybinds_pressed():
	%"Button SFX".play()
	%Keybinds.visible = true
	%"Video Settings Container".visible = false
	%"Audio Settings Container".visible = false


func _on_screen_mode_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			ConfigFileHandler.save_video_setting("fullscreen", 0)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			ConfigFileHandler.save_video_setting("fullscreen", 1)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			ConfigFileHandler.save_video_setting("fullscreen", 2)



func _on_window_resolution_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
			ConfigFileHandler.save_video_setting("resolution", 0)
		1:
			DisplayServer.window_set_size(Vector2i(1080, 720))
			ConfigFileHandler.save_video_setting("resolution", 1)
		2:
			DisplayServer.window_set_size(Vector2i(640, 480))
			ConfigFileHandler.save_video_setting("resolution", 2)



func _on_main_volume_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_setting("main_volume", main_volume_slider.value)


func _on_music_volume_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_setting("music_volume", music_volume_slider.value)

func _on_sfx_volume_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_setting("sfx_volume", sfx_volume_slider.value)

func _on_main_volume_value_changed(value):
	AudioServer.set_bus_volume_db(master, linear_to_db(value))
	print("Master", AudioServer.get_bus_volume_db(master))

func _on_music_volume_value_changed(value):
	AudioServer.set_bus_volume_db(music, linear_to_db(value))
	print("Music:", AudioServer.get_bus_volume_db(music))


func _on_sfx_volume_value_changed(value):
	AudioServer.set_bus_volume_db(sfx, linear_to_db(value))
	print("SFX:", AudioServer.get_bus_volume_db(sfx))
