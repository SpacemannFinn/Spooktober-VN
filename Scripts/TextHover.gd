extends Control
var font


func _on_TextureButton_mouse_entered(label):
	font = get_node(label).get("custom_fonts/normal_font")
	font.outline_color = Color("BB0087")
	font.outline_size = 3
	print(label, " Entered")
	font.update_changes()
	pass # Replace with function body.


func _on_TextureButton_mouse_exited(label):
	font = get_node(label).get("custom_fonts/normal_font")
	font.outline_color = Color.white
	font.outline_size = 0
	print(label, " Exited")
	font.update_changes()
	pass # Replace with function body.


func _on_Menu_Button_mouse_entered(label):
	font = get_node(label).get("custom_fonts/normal_font")
	font.outline_color = Color("000ECF")
	font.outline_size = 3
	print(label, " Entered")
	font.update_changes()
	pass # Replace with function body.

func _on_Menu_Button_mouse_exited(label):
	font = get_node(label).get("custom_fonts/normal_font")
	font.outline_size = 0
	print(label, " Exited")
	font.update_changes()
	pass # Replace with function body. 


func _on_AIMTextureButton_mouse_entered(label):
	font = get_node(label).get("custom_fonts/normal_font")
	font.outline_color = Color("8E6CFF")
	font.outline_size = 3
	print("AIM ", label, " Entered")
	font.update_changes()
	pass # Replace with function body.


func _on_AIMTextureButton_mouse_exited(label):
	font = get_node(label).get("custom_fonts/normal_font")
	font.outline_color = Color.white
	font.outline_size = 0
	print("AIM ", label, " Exited")
	font.update_changes()
	pass # Replace with function body.


func _on_resized(label):
	var labelSize = get_node(label)
	var buttonSize = get_node(label).get_child(1)
	buttonSize.rect_size.y = labelSize.rect_size.y
	print(buttonSize.rect_size.y)
	pass # Replace with function body.
