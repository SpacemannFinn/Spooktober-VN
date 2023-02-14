extends TextureRect
var font
onready var global = get_node("/root/global")

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Music'), (global._settings["settings"]["MusicVolume"] - 30))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('SFX'), (global._settings["settings"]["SFXVolume"] - 30))
	
	$start/StartButton.connect("mouse_entered", self, "_on_mouse_entered", [$start])
	$quit/QuitButton.connect("mouse_entered", self, "_on_mouse_entered", [$quit])
	$load/LoadButton.connect("mouse_entered", self, "_on_mouse_entered", [$load])
	
	$start/StartButton.connect("mouse_exited", self, "_on_mouse_exited", [$start])
	$quit/QuitButton.connect("mouse_exited", self, "_on_mouse_exited", [$quit])
	$load/LoadButton.connect("mouse_exited", self, "_on_mouse_exited", [$load])
	
	$Credits/saltycryptid.connect("mouse_entered", self, "_on_meta_hover_started", [$Credits/saltycryptid])
	$Credits/nen.connect("mouse_entered", self, "_on_meta_hover_started", [$Credits/nen])
	$Credits/leaflet.connect("mouse_entered", self, "_on_meta_hover_started", [$Credits/leaflet])
	
	$Credits/saltycryptid.connect("mouse_exited", self, "_on_meta_hover_ended", [$Credits/saltycryptid])
	$Credits/nen.connect("mouse_exited", self, "_on_meta_hover_ended", [$Credits/nen])
	$Credits/leaflet.connect("mouse_exited", self, "_on_meta_hover_ended", [$Credits/leaflet])

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		if $LoadMenu.visible:
			$LoadMenu.hide()
		if $SettingsMenu.visible:
			$SettingsMenu.hide()


func _on_mouse_entered(node):
	font = node.get("custom_fonts/normal_font")
	font.outline_color = Color("D0001F")
	font.outline_size = 8
	font.update_changes()

func _on_mouse_exited(node):
	font = node.get("custom_fonts/normal_font")
	font.outline_size = 0
	font.update_changes()

func _on_settings_pressed():
	var settingsMenu = load("res://Scenes/SettingsMenu.tscn").instance()
	get_tree().current_scene.add_child(settingsMenu)
	
	$SettingsMenu/Labels/X/XButton.connect("menu_close", self, "_menu_closed")

func _menu_closed(node):
	var disconnectLabel = str(node)+"/Labels/X/XButton"
	#get_node(disconnectLabel).disconnect("menu_close", self, "_menu_closed")
	node.queue_free()

func _on_StartButton_pressed():
	var dir = Directory.new()
	dir.remove("res://SavedData/history.json")
	get_tree().change_scene("res://Scenes/VisualNovel.tscn")

func _on_LoadButton_pressed():
	var loadMenu = load("res://Scenes/Load.tscn").instance()
	get_tree().current_scene.add_child(loadMenu)
	
	$LoadMenu/Labels/X/XButton.connect("menu_close", self, "_menu_closed")
	

func _on_QuitButton_pressed():
	get_tree().quit()



func _on_meta_hover_started(node):
	font = node.get("custom_fonts/normal_font")
	font.outline_color = Color("D0001F")
	font.outline_size = 2.5
	font.update_changes()

func _on_meta_hover_ended(node):
	font = node.get("custom_fonts/normal_font")
	font.outline_size = 0
	font.update_changes()

