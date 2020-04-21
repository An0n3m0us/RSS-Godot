extends KinematicBody2D

export (int) var speed = 300

var target = position
var velocity = Vector2()
		
func _on_GameScene_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				target = get_global_mouse_position()

func _physics_process(_delta):
	velocity = (target - position).normalized() * speed
	# rotation = velocity.angle()
	if (target - position).length() > 5:
		velocity = move_and_slide(velocity)
