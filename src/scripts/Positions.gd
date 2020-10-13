extends Sprite

var toggled = ""

func _ready():
	for button in get_tree().get_nodes_in_group("buttons"):
			button.connect("pressed", self, "_button_pressed", [button])

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		
		if get_rect().has_point(to_local(event.position)):
			if toggled != "":
				if (self.get_child_count() < 1):
					var scene = load("res://src/actors/" + toggled + ".tscn")
					var player = scene.instance()
					player.name = self.name + "_unit"
					player.position = Vector2(0, -50)
					player.target = Vector2(0, -50)
					self.add_child(player)
						
		for button in get_tree().get_nodes_in_group("buttons"):
			button.pressed = false
			toggled = ""

func _button_pressed(button):
	if button.pressed:
		toggled = button.name
	else:
		toggled = ""
