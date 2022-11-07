extends TextureProgress

var sfx_bus = AudioServer.get_bus_index('SFX')
var music_bus = AudioServer.get_bus_index('Music')


func _on_TextSpeed_value_changed(value):
	pass


func _on_MusicProgress_value_changed(value):
	var newvalue = value - 30
	AudioServer.set_bus_volume_db(music_bus, newvalue)
	
	if value == -30:
		AudioServer.set_bus_mute(music_bus,true)
	else:
		AudioServer.set_bus_mute(music_bus,false)

func _on_SFXProgress_value_changed(value):
	var newvalue = value - 30
	AudioServer.set_bus_volume_db(sfx_bus, newvalue)
	
	if newvalue == -30:
		AudioServer.set_bus_mute(sfx_bus,true)
	else:
		AudioServer.set_bus_mute(sfx_bus,false)
