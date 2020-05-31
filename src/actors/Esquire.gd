extends KinematicBody2D

export (String) var type = ""
export (int) var health = 10
export (int) var speed = 100

var target = Vector2()
var velocity = Vector2()
var selected = false

var healthdeplete = false

# Health bar positioning
# Storing original health count

func _input(event):
	if selected == true:
		if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT:
			if event.pressed:
				target = get_global_mouse_position()

func _physics_process(delta):
	var movement = position.direction_to(target) * speed
	
	# Check if distance is greater than 5
	if position.distance_to(target) > 5:
		velocity = move_and_collide(movement * delta)

	if velocity:
		target = position

	# Check in which direction the character is moving
	if target[0] < position[0]:
		self.get_node("Pivot").scale = Vector2(-1, 1)
	elif target[0] > position[0]:
		self.get_node("Pivot").scale = Vector2(1, 1)

	# Check if colliding with object
	if healthdeplete == true:
		health -= 0.05

	update()

func _draw():
	# Health bar
	#if selected == true:
	draw_rect(Rect2(self.get_node("Pivot").position[0]-24, self.get_node("Pivot").position[1]-60, health*5, 5), Color8(100, 0, 0))
	draw_rect(Rect2(self.get_node("Pivot").position[0]-24, self.get_node("Pivot").position[1]-60, health*5, 5), Color8(255, 0 , 0))

func _on_Area2D_body_entered(body):
	if body.type != type:
		healthdeplete = true

func _on_Area2D_body_exited(body):
	if body.type != type:
		healthdeplete = false
