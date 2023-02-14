extends Control
onready var global = get_node("/root/global")

func _on_savebutton_pressed():
	global.image = get_viewport().get_texture().get_data()
	global.image.flip_y()
	
	var saveMenu = load("res://Scenes/Save.tscn").instance()
	get_tree().current_scene.add_child(saveMenu)
	global._saveInfo = get_tree().get_nodes_in_group("DialogueController")[0].saveData()
	print(global._saveInfo)
	
	get_tree().get_current_scene().get_node("SaveMenu/Labels/X/XButton").connect("menu_close", self, "_menu_closed")


func _on_loadbutton_pressed():
	var loadMenu = load("res://Scenes/Load.tscn").instance()
	get_tree().current_scene.add_child(loadMenu)
	
	get_tree().get_current_scene().get_node("LoadMenu/Labels/X/XButton").connect("menu_close", self, "_menu_closed")


func _on_histbutton_pressed():
	var history = load("res://Scenes/History.tscn").instance()
	get_tree().current_scene.add_child(history)
	
	get_tree().get_current_scene().get_node("HistoryMenu/Labels/X/XButton").connect("menu_close", self, "_menu_closed")


func _on_menuButton_pressed():
	var settingsMenu = load("res://Scenes/SettingsMenu.tscn").instance()
	get_tree().current_scene.add_child(settingsMenu)
	
	get_tree().get_current_scene().get_node("SettingsMenu/Labels/X/XButton").connect("menu_close", self, "_menu_closed")


func _menu_closed(node):
	var disconnectLabel = str(node)+"/Labels/X/XButton"
	get_tree().get_current_scene().get_node(disconnectLabel).disconnect("menu_close", self, "_menu_closed")
	node.queue_free()
