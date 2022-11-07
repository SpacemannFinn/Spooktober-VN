extends Control

var sfx = AudioServer.get_bus_index('SFX')
var music = AudioServer.get_bus_index('Music')
var sfx_spectrum
var music_spectrum
var sfx_volume
var music_volume
var _timer

func _ready():
	sfx_spectrum = AudioServer.get_bus_effect_instance(sfx, 0)
	music_spectrum = AudioServer.get_bus_effect_instance(music, 0)

func _on_Timer_timeout():
	music_volume = music_spectrum.get_magnitude_for_frequency_range(0, 10000).length()
	sfx_volume = sfx_spectrum.get_magnitude_for_frequency_range(0, 10000).length()
	
	print(sfx_volume * 1000)
	print(music_volume * 1000)
	
	$SFX.value = sfx_volume * 1000
	$Music.value = music_volume * 1000
