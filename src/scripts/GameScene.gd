extends Node2D

# Big thanks to KidsCanCode for drag-select code

var dragging = false  # Are we currently dragging?
var selected = []  # Array of selected units.
var drag_start = Vector2.ZERO  # Location where drag began.
var select_rect = RectangleShape2D.new()  # Collision shape for drag box.

var mouseFrom = 0
var mouseTo = 0

func _ready():
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_1:
			var scene = load("res://src/actors/Esquire.tscn")
			var player = scene.instance()
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			player.name = "Esquire"+str(rng.randf_range(-10.0, 10.0))
			player.position = get_global_mouse_position()
			add_child(player)
		if event.pressed and event.scancode == KEY_2:
			var scene = load("res://src/actors/Esquire-enemy.tscn")
			var player = scene.instance()
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			player.name = "Esquire-enemy"+str(rng.randf_range(-10.0, 10.0))
			player.position = get_global_mouse_position()
			player.scale = Vector2(-1, 1)
			add_child(player)

	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			if selected.size() == 0:
				dragging = true
				drag_start = event.position
			else:
				for item in selected:
					item.collider.position = event.position
					item.collider.get_node("Pivot").get_node("Selection").visible = false
				selected = []
		elif dragging:
			dragging = false
			update()
			var drag_end = event.position
			select_rect.extents = (drag_end - drag_start) / 2
			var space = get_world_2d().direct_space_state
			var query = Physics2DShapeQueryParameters.new()
			query.set_shape(select_rect)
			query.transform = Transform2D(0, (drag_end + drag_start) / 2)
			selected = space.intersect_shape(query)
			for item in selected:
				item.collider.get_node("Pivot").get_node("Selection").visible = true
	if event is InputEventMouseMotion and dragging:
		update()

func _draw():
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start),
			Color(0, .5, .5, 0.5), true)
