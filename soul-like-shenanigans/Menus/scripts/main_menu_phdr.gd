extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	MenuMusic.play_music_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
func _on_new_game_pressed():
	pass


func _on_system_settings_pressed():
	get_tree().change_scene_to_file("res://Menus/system_settings.tscn")

func _on_exit_pressed():
	get_tree().quit()
