extends Node2D

# Big thanks to KidsCanCode for drag-select code

var dragging = false  # Are we currently dragging?
var selected = []  # Array of selected units.
var drag_start = Vector2.ZERO  # Location where drag began.
var select_rect = RectangleShape2D.new()  # Collision shape for drag box.

var characters = 0

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
			player.target = player.position
			add_child(player)
			characters += 1
		if event.pressed and event.scancode == KEY_2:
			var scene = load("res://src/actors/Esquire-enemy.tscn")
			var player = scene.instance()
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			player.name = "Esquire-enemy"+str(rng.randf_range(-10.0, 10.0))
			player.position = get_global_mouse_position()
			player.target = player.position
			add_child(player)
			characters += 1

	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			#if selected.size() == 0:
			#else:
			for item in selected:
				item.collider.selected = false
				item.collider.get_node("Pivot").get_node("Selection").visible = false
			selected = []
			dragging = true
			drag_start = get_global_mouse_position()
		elif dragging:
			dragging = false
			update()
			var drag_end = get_global_mouse_position()
			select_rect.extents = (drag_end - (drag_start)) / 2
			var space = get_world_2d().direct_space_state
			var query = Physics2DShapeQueryParameters.new()
			query.set_shape(select_rect)
			query.transform = Transform2D(0, (drag_end + drag_start) / 2)
			selected = space.intersect_shape(query)
			for item in selected:
				item.collider.selected = true
				print(item.collider.type)
				item.collider.get_node("Pivot").get_node("Selection").visible = true
	if event is InputEventMouseMotion and dragging:
		update()

func _draw():
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start),
			Color(0, .5, .5, 0.5), true)

	# PUSH CHARACTERS TO TABLE TO ACCESS SELECTED VALUE
	for i in range(0, characters):
		if characters:
			var uniticon = preload("res://src/unitpanel/UnitIcon.tscn").instance()
			if selected[i].collider.type == "Esquire":
				uniticon.get_child(0).texture = load("res://assets/images/unitpanel/normalicon.png")
			else:
				uniticon.get_child(0).texture = load("res://assets/images/unitpanel/enemyicon.png")
			uniticon.position = Vector2(360+(i*50)+(i*15), 655)
			get_node("Units").add_child(uniticon)
		else:
			for n in get_node("Units").get_children():
				get_node("Units").remove_child(n)
				n.queue_free()
	#draw_texture_rect(texture, Rect2(50, 50, 50, 50), 0)
