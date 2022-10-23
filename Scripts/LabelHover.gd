extends Label

func _on_XButton_mouse_entered():
	modulate = Color("#FF1000")
	print("X Entered")

func _on_XButton_mouse_exited():
	modulate = Color("F4F4F4")
	print("X Exited")
