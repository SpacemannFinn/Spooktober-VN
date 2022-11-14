extends Label

func _on_XButton_mouse_entered():
	var font = get("custom_fonts/font")
	font.outline_size = 8
	font.outline_color = Color("#FF1000")
	print("X Entered")

func _on_XButton_mouse_exited():
	var font = get("custom_fonts/font")
	font.outline_size = 0
	print("X Exited")
