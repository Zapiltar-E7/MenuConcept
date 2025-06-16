extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	#MenuMusic.play_music_menu()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	pass
		
func _on_new_game_pressed():
	pass


func _on_settings_button_pressed():
	%"Start Screen".visible = false
	%"System Settings".visible = true

func _on_exit_pressed():
	get_tree().quit()
