extends TextureRect

onready var global = get_node("/root/global")
var MouseOver = false
var id
signal mouse_over_tbox
signal mouse_off_tbox


func _on_TextBox_mouse_entered():
	MouseOver = true
	emit_signal("mouse_over_tbox")
	pass # Replace with function body.


func _on_TextBox_mouse_exited():
	MouseOver = false
	emit_signal("mouse_off_tbox")
	pass # Replace with function body.

