extends TextureButton

var on

signal menu_close(node)

func _on_FullScreen_Button_pressed():
	if on == false:
		get_parent().modulate = Color("00EFFF")
	else:	
		get_parent().get_parent().get_node("Windowed").modulate = Color("F4F4F4")
		on == true
		get_parent().modulate = Color("00EFFF")
		OS.set_window_fullscreen(true)
	print("Screen is now Full")


func _on_Windowed_Button_pressed():
	if on == false:
		get_parent().modulate = Color("00EFFF")
	else:
		get_parent().get_parent().get_node("Fullscreen").modulate = Color("F4F4F4")
		on == true
		get_parent().modulate = Color("00EFFF")
		OS.set_window_fullscreen(false)
		var size = Vector2(960, 540)
		OS.set_window_size(size)
		OS.center_window()
	print("Screen is now Hungry")

func _on_XButton_pressed():
	emit_signal("menu_close", get_parent().get_parent().get_parent())
	print("X Button Pressed and Menu Close signal Emitted")
