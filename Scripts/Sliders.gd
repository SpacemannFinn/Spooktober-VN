extends Control

onready var global = get_node("/root/global")


var sfx_bus = AudioServer.get_bus_index('SFX')
var music_bus = AudioServer.get_bus_index('Music')

const SETTINGSPATH = "res://SavedData/config.cfg"

func _ready():
	if !File.new().file_exists(SETTINGSPATH):
		global.saveSettings(SETTINGSPATH)
	global.loadSettings(SETTINGSPATH)
	$Bars/TextSpeedLevel/TextureProgress.value = global._settings["settings"]["TextSpeed"]
	$Bars/MusicLevel/MusicProgress.value = global._settings["settings"]["MusicVolume"]
	$Bars/SFXLevel/SFXProgress.value = global._settings["settings"]["SFXVolume"]
	print(global._settings)
	pass

func _on_TextSpeed_value_changed(value):
	global._settings["settings"]["TextSpeed"] = value
	var newValue = value - 10
	global.textSpeed = abs(newValue)
	
	global.saveSettings(SETTINGSPATH)
	print(global._settings)


func _on_MusicProgress_value_changed(value):
	global._settings["settings"]["MusicVolume"]  = value
	var newvalue = value - 30
	AudioServer.set_bus_volume_db(music_bus, newvalue)
	
	if newvalue == -30:
		AudioServer.set_bus_mute(music_bus,true)
	else:
		AudioServer.set_bus_mute(music_bus,false)
	
	global.saveSettings(SETTINGSPATH)
	print(global._settings)


func _on_SFXProgress_value_changed(value):
	global._settings["settings"]["SFXVolume"]  = value
	var newvalue = value - 30
	AudioServer.set_bus_volume_db(sfx_bus, newvalue)
	
	if newvalue == -30:
		AudioServer.set_bus_mute(sfx_bus,true)
	else:
		AudioServer.set_bus_mute(sfx_bus,false)
	
	global.saveSettings(SETTINGSPATH)
	print(global._settings)



