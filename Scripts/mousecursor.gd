extends Node

# Load the custom images for the mouse cursor
var mouseUnclicked = load("res://UI/UI Assets/cursor_resized.png")
var mouseClicked = load("res://UI/UI Assets/cursor_click_resized.png")

func _input(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		Input.set_custom_mouse_cursor(mouseClicked, 0, Vector2(0, 0))
	else:
		Input.set_custom_mouse_cursor(mouseUnclicked, 0, Vector2(0, 0))
	

