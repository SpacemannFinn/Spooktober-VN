extends TextureButton

signal open_settings

func _on_SettingButton_pressed():
	emit_signal("open_settings")
	print("Settings Button Pressed and Open Settings signal Emitted")
	pass # Replace with function body.
