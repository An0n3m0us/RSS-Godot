extends Control

func _ready():
	for button in $Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.loadScene])

func _on_Button_pressed(loadScene):
	var _return = get_tree().change_scene(loadScene)
