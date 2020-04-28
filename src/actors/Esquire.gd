extends KinematicBody2D

export (int) var speed = 200

var target = Vector2()
var velocity = Vector2()
var selected = false

func _input(event):
	if selected == true:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			if event.pressed:
				target = get_global_mouse_position()

func _physics_process(_delta):
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)

	if is_on_wall() or is_on_floor():
		target = position

	if target[0] < position[0]:
		self.get_node("Pivot").scale = Vector2(-1, 1)
	elif target[0] > position[0]:
		self.get_node("Pivot").scale = Vector2(1, 1)
