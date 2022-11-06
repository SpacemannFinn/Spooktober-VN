extends TextureRect
var font

func _ready():
	$SettingsMenu/Labels/X/XButton.connect("menu_close", self, "_menu_closed")
	
	$start/StartButton.connect("mouse_entered", self, "_on_mouse_entered", [$start])
	$quit/QuitButton.connect("mouse_entered", self, "_on_mouse_entered", [$quit])
	$load/LoadButton.connect("mouse_entered", self, "_on_mouse_entered", [$load])
	
	$start/StartButton.connect("mouse_exited", self, "_on_mouse_exited", [$start])
	$quit/QuitButton.connect("mouse_exited", self, "_on_mouse_exited", [$quit])
	$load/LoadButton.connect("mouse_exited", self, "_on_mouse_exited", [$load])

func _on_mouse_entered(node):
	font =  node.get("custom_fonts/normal_font")
	font.outline_color = Color("D0001F")
	font.outline_size = 8
	font.update_changes()

func _on_mouse_exited(node):
	font = node.get("custom_fonts/normal_font")
	font.outline_size = 0
	font.update_changes()

func _on_settings_pressed():
	$SettingsMenu.show()

func _menu_closed():
	$SettingsMenu/Labels/X.modulate = Color("F4F4F4")
	$SettingsMenu.hide()

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/VisualNovel.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()


