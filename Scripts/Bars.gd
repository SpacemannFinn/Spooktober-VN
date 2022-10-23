extends Control

var textMouseInSlider = false
var musicMouseInSlider = false
var sfxMouseInSlider = false

func _input(event):
	if(textMouseInSlider && Input.is_mouse_button_pressed(BUTTON_LEFT)):
		setValue($TextSpeedLevel/TextureProgress)
	if(musicMouseInSlider && Input.is_mouse_button_pressed(BUTTON_LEFT)):
		setValue($MusicLevel/MusicProgress)
	if(sfxMouseInSlider && Input.is_mouse_button_pressed(BUTTON_LEFT)):
		setValue($SFXLevel/SFXProgress)


func setValue(slider : TextureProgress):
	slider.value = ratioInBody(slider) * slider.max_value
	print(slider.name, "Speed", slider.value)

func ratioInBody(slider : TextureProgress):
	var posClicked = get_local_mouse_position() - slider.rect_position
	var ratio = posClicked.x / slider.rect_size.x
	if(ratio > 1.0):
		ratio = 1.0
	elif(ratio < 0.0):
		ratio = 0.0
	return ratio

func _on_TextureProgress_mouse_entered():
	textMouseInSlider = true
	print("Text Speed Entered")

func _on_TextureProgress_mouse_exited():
	textMouseInSlider = false
	print("Text Speed Exited")

func _on_MusicProgress_mouse_entered():
	musicMouseInSlider = true
	print("Music Speed Entered")

func _on_MusicProgress_mouse_exited():
	musicMouseInSlider = false
	print("Music Speed Exited")

func _on_SFXProgress_mouse_entered():
	sfxMouseInSlider = true
	print("SFX Speed Entered")

func _on_SFXProgress_mouse_exited():
	sfxMouseInSlider = false
	print("SFX Speed Exited")
