extends TextureButton

export(String) var loadScene

func _ready():
	pass

func _on_SettingsButton_mouse_entered():
	rect_rotation = -5
	rect_scale = Vector2(1.1, 1.1)
	$Hover.play()
	pass


func _on_SettingsButton_mouse_exited():
	rect_rotation = 0
	rect_scale = Vector2(1, 1)
	pass


func _on_SettingsButton_button_down():
	$Pressed.play()
	pass # Replace with function body.
