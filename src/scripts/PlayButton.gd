extends TextureButton

export(String) var loadScene

func _ready():
	pass

func _on_PlayButton_mouse_entered():
	rect_rotation = -5
	rect_scale = Vector2(1.1, 1.1)
	$Hover.play()
	pass


func _on_PlayButton_mouse_exited():
	rect_rotation = 0
	rect_scale = Vector2(1, 1)
	pass


func _on_PlayButton_button_down():
	$Pressed.play()
	pass
