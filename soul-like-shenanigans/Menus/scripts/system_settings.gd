extends Control


@onready var fullscreen_mode = $"PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Screen Mode"
@onready var window_resolution = $"PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Window Resolution"
@onready var main_volume_slider = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/MainVolume
@onready var music_volume_slider = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/MusicVolume
@onready var audio_player := preload("res://Menus/menu_music.tscn").instantiate()

func _ready():
	var video_settings = ConfigFileHandler.load_video_setting()
	fullscreen_mode.selected = video_settings.fullscreen
	window_resolution.selected = video_settings.resolution
	
	var audio_settings = ConfigFileHandler.load_audio_setting()
	main_volume_slider.value = audio_settings.main_volume
	music_volume_slider.value = audio_settings.music_volume
	

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Menus/main_menu_PHDR.tscn")


func _on_keybinds_pressed():
	get_tree().change_scene_to_file("res://Menus/keybinds.tscn")


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



	
