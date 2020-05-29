extends Node2D

# Big thanks to KidsCanCode for drag-select code

var dragging = false  # Are we currently dragging?
var selected = []  # Array of selected units.
var drag_start = Vector2.ZERO  # Location where drag began.
var select_rect = RectangleShape2D.new()  # Collision shape for drag box.

func _ready():
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_1:
			var scene = load("res://src/actors/Esquire.tscn")
			var player = scene.instance()
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			player.name = player.name + "-"+str(rng.randf_range(-10.0, 10.0))
			player.position = get_global_mouse_position()
			player.target = player.position
			get_node("Units").add_child(player)
		if event.pressed and event.scancode == KEY_2:
			var scene = load("res://src/actors/Esquire-enemy.tscn")
			var player = scene.instance()
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			player.name = player.name.replace("-", "_") + "-"+str(rng.randf_range(-10.0, 10.0))
			player.position = get_global_mouse_position()
			player.target = player.position
			get_node("Units").add_child(player)

	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
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
				item.collider.get_node("Pivot").get_node("Selection").visible = true
	if event is InputEventMouseMotion and dragging:
		update()

func _draw():
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start),
			Color(0, .5, .5, 0.5), true)
			
	for node in get_node("Camera2D/UnitPanel").get_children():
		get_node("Camera2D/UnitPanel").remove_child(node)

func _process(_delta):
	
	# Unit panel
	var list = get_node("Units").get_children()
	var panelnames = []
	for nodes in get_node("Camera2D/UnitPanel").get_children():
		panelnames.append(nodes.name)
	for unit in range(0, list.size()):
		var i = get_node("Camera2D/UnitPanel").get_children().size()
		
		# Unit icon when selected
		if list[unit].selected == true:
			if not list[unit].name in panelnames:
				var uniticonscene = load("res://src/unitpanel/UnitIcon.tscn")
				var uniticon = uniticonscene.instance()
				if list[unit].name.split("-")[0] == "Esquire":
					uniticon.get_child(0).texture = load("res://assets/images/unitpanel/normalicon.png")
				else:
					uniticon.get_child(0).texture = load("res://assets/images/unitpanel/enemyicon.png")
				uniticon.set_name(list[unit].name)
				uniticon.position = Vector2(360+(i*50)+(i*15), 655)
				uniticon.get_child(1).set_text(list[unit].name.split("-")[0].split("_")[0])
				uniticon.get_child(3).set_size(Vector2(list[unit].health*5, 5))
				get_node("Camera2D/UnitPanel").add_child(uniticon)
		# Check health
		if list[unit].health <= 0:
			get_node("Units").remove_child(list[unit])
		
		if list[unit].name in panelnames:
			get_node("Camera2D/UnitPanel/" + list[unit].name).get_child(3).set_size(Vector2(list[unit].health*5, 5))
