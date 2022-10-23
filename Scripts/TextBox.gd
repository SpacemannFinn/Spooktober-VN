extends TextureRect

var MouseOver = false
onready var dia = get_node("/root/VisualNovel/Control")

func _input(delta):
	if Input.is_action_just_pressed("ui_accept_alt"):
		if dia.finished == true:
			if dia.pauseDialogue == false:
				dia.load_dialogue()
		else:
			if dia.pauseDialogue == false:
				get_node("/root/VisualNovel/Control/TextBox/Tween").stop_all()
				get_node("/root/VisualNovel/Control/TextBox/RichTextLabel").percent_visible = 1
				dia.finished = true


func _on_TextBox_mouse_entered():
	MouseOver = true
	pass # Replace with function body.


func _on_TextBox_mouse_exited():
	MouseOver = false
	pass # Replace with function body.
