extends TextureButton

var on

signal menu_close

func _on_FullScreen_Button_pressed():
	if on == false:
		get_parent().modulate = Color("00EFFF")
	else:	
		get_parent().get_parent().get_node("Windowed").modulate = Color("F4F4F4")
		on == true
		get_parent().modulate = Color("00EFFF")
	print("Screen is now Full")
	pass # Replace with function body.


func _on_Windowed_Button_pressed():
	if on == false:
		get_parent().modulate = Color("00EFFF")
	else:
		get_parent().get_parent().get_node("Fullscreen").modulate = Color("F4F4F4")
		on == true
		get_parent().modulate = Color("00EFFF")
	print("Screen is now Hungry")
	pass # Replace with function body.


func _on_XButton_pressed():
	emit_signal("menu_close")
	print("X Button Pressed and Menu Close signal Emitted")
