extends RichTextLabel
var font


func _on_TextureButton_mouse_entered():
	font = get("custom_fonts/normal_font")
	font.outline_color = Color("BB0087")
	font.outline_size = 3
	print("Choice 1 Entered")
	font.update_changes()
	pass # Replace with function body.


func _on_TextureButton_mouse_exited():
	font = get("custom_fonts/normal_font")
	font.outline_color = Color.white
	font.outline_size = 0
	print("Choice 1 Exited")
	font.update_changes()
	pass # Replace with function body.


func _on_TextureButton2_mouse_entered():
	font = get("custom_fonts/normal_font")
	font.outline_color = Color("BB0087")
	font.outline_size = 3
	print("Choice 2 Entered")
	font.update_changes()
	pass # Replace with function body.


func _on_TextureButton2_mouse_exited():
	font = get("custom_fonts/normal_font")
	font.outline_color = Color.white
	font.outline_size = 0
	print("Choice 2 Exited")
	font.update_changes()
	pass # Replace with function body.


func _on_TextureButton3_mouse_entered():
	font = get("custom_fonts/normal_font")
	font.outline_color = Color("BB0087")
	font.outline_size = 3
	print("Choice 3 Entered")
	font.update_changes()
	pass # Replace with function body.


func _on_TextureButton3_mouse_exited():
	font = get("custom_fonts/normal_font")
	font.outline_color = Color.white
	font.outline_size = 0
	print("Choice 3 Exited")
	font.update_changes()
	pass # Replace with function body.


func _on_FullScreen_Button_mouse_entered():
	font = get("custom_fonts/normal_font")
	font.outline_color = Color("000ECF")
	font.outline_size = 3
	print("Fullscreen Entered")
	font.update_changes()
	pass # Replace with function body.

func _on_FullScreen_Button_mouse_exited():
	font = get("custom_fonts/normal_font")
	font.outline_size = 0
	print("Fullscreen Exited")
	font.update_changes()
	pass # Replace with function body. 

func _on_Windowed_Button_mouse_entered():
	font = get("custom_fonts/normal_font")
	font.outline_color = Color("000ECF")
	font.outline_size = 3
	print("Windowed Entered")
	font.update_changes()
	pass # Replace with function body.


func _on_Windowed_Button_mouse_exited():
	font = get("custom_fonts/normal_font")
	font.outline_size = 0
	print("Windowed Exited")
	font.update_changes()
	pass # Replace with function body.


