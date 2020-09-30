extends Node

var click_radius = 50 # Size of the sprite.
var size = self.rect_size*2

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if (event.position - self.rect_position-size).length() < click_radius:
			print(self.name)
			print(self.rect_position)
			var s = ColorRect.new()
			s.set_name("node")
			s.set_size(Vector2(50, 50))
			s.set_position(Vector2(self.rect_position[0]+25, self.rect_position[1]+25))
			get_parent().add_child(s) # Add it as a child of this node.
			var x = get_parent().get_children()[-1]
			x.color = Color(randf(), randf(), randf())
