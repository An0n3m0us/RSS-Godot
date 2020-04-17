extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_SettingsButton_mouse_entered():
	rect_rotation = -5
	rect_scale = Vector2(1.1, 1.1)
	pass # Replace with function body.


func _on_SettingsButton_mouse_exited():
	rect_rotation = 0
	rect_scale = Vector2(1, 1)
	pass # Replace with function body.
