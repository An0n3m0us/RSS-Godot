extends Node2D

# Credit KidsCanCode for drag-select code

var dragging = false  # Are we currently dragging?
var selected = []  # Array of selected units.
var drag_start = Vector2.ZERO  # Location where drag began.
var select_rect = RectangleShape2D.new()  # Collision shape for drag box.

func _ready():
	pass

func _input(event):
	
	# Adding units
	if event is InputEventKey:
		if event.pressed:
			var scene
			var player
			if event.scancode == KEY_1:
				scene = load("res://src/actors/Esquire.tscn")
				player = scene.instance()
			if event.scancode == KEY_2:
				scene = load("res://src/actors/Esquire-enemy.tscn")
				player = scene.instance()
			if event.scancode == KEY_3:
				scene = load("res://src/actors/RoyalKnight.tscn")
				player = scene.instance()

			if player:
				var rng = RandomNumberGenerator.new()
				rng.randomize()
				player.name = player.name + "_" + str(rng.randf_range(0, 10.0))
				player.position = get_global_mouse_position()
				player.target = player.position
				get_node("Units").add_child(player)

	# Drag-select
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

	# Drag rect
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start),
			Color(0, .5, .5, 0.5), true)
	
	# Redraw unit panel every frame
	for node in get_node("Camera2D/UnitPanel").get_children():
		get_node("Camera2D/UnitPanel").remove_child(node)

func _process(_delta):
	
	# Unit panel
	var list = get_node("Units").get_children()
	var panelnames = []
	for nodes in get_node("Camera2D/UnitPanel").get_children():
		panelnames.append(nodes.name)
		
	for unit in list:
		var i = get_node("Camera2D/UnitPanel").get_children().size()

		# Check health
		if unit.health <= 0:
			get_node("Units").remove_child(unit)
		
		# Unit icon when selected
		if unit.selected and not unit.name in panelnames:
			var uniticon = load("res://src/unitpanel/UnitIcon.tscn").instance()
			# FIXME: LOAD ALL IMAGES AT START INTO DICT AND INDEX IT
			uniticon.get_child(0).texture = load("res://assets/images/unitpanel/" + unit.name.split("_")[0] + ".png")
			uniticon.set_name(unit.name)
			uniticon.position = Vector2(360+(i*50)+(i*15), 655)
			uniticon.get_child(1).set_text(unit.name.split("-")[0].split("_")[0])
			uniticon.get_child(3).set_size(Vector2(unit.health*5, 5))
			get_node("Camera2D/UnitPanel").add_child(uniticon)
		
		# Set health
		if unit.name in panelnames:
			get_node("Camera2D/UnitPanel/" + unit.name).get_child(3).set_size(Vector2(unit.health*5, 5))
