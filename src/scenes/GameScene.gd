extends Node

var click_radius = 50 # Size of the sprite.
var size = self.rect_size*2

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if (event.position - self.rect_position-size).length() < click_radius:
			if (get_parent().has_node(self.name + "_unit") == false):
				var scene = load("res://src/actors/Esquire.tscn")
				var player = scene.instance()
				player.name = self.name + "_unit"
				player.position = Vector2(self.rect_position[0]+50, self.rect_position[1])
				get_parent().add_child(player)
