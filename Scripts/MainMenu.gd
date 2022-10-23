extends TextureRect
var font

func _ready():
	$SettingsMenu/Labels/X/XButton.connect("menu_close", self, "menu_closed")

func _on_StartButton_mouse_entered():
	font = $start.get("custom_fonts/normal_font")
	font.outline_color = Color("D0001F")
	font.outline_size = 8
	font.update_changes()

func _on_StartButton_mouse_exited():
	font = $start.get("custom_fonts/normal_font")
	font.outline_size = 0
	font.update_changes()

func _on_LoadButton_mouse_entered():
	font = $load.get("custom_fonts/normal_font")
	font.outline_color = Color("D0001F")
	font.outline_size = 8
	font.update_changes()

func _on_LoadButton_mouse_exited():
	font = $load.get("custom_fonts/normal_font")
	font.outline_size = 0
	font.update_changes()

func _on_QuitButton_mouse_entered():
	font = $quit.get("custom_fonts/normal_font")
	font.outline_color = Color("D0001F")
	font.outline_size = 8
	font.update_changes()

func _on_QuitButton_mouse_exited():
	font = $quit.get("custom_fonts/normal_font")
	font.outline_size = 0
	font.update_changes()

func _on_settings_pressed():
	$SettingsMenu.show()

func menu_closed():
	$SettingsMenu/Labels/X.modulate = Color("F4F4F4")
	$SettingsMenu.hide()

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/VisualNovel.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()


